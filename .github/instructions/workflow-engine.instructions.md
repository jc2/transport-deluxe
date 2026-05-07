---
description: "Use when creating or modifying a workflow engine service (costing_engine, margin_engine, pricing_engine). Covers file structure, Hamilton orchestration, audit/traceability pattern, step conventions, external service calls, database setup, and testing."
---

# Workflow Engine Implementation Conventions

Workflow engines execute multi-step business logic pipelines. They are NOT configuration services — no SQLAdmin UI, no CRUD, no versioning. Their job is to **execute a workflow, persist every step's audit trace, and return a result**.

## 1. File Structure & Responsibilities

```text
src/
├── main.py                        # App bootstrap, lifespan, exception handlers, router registration
├── tools/
│   ├── db.py                      # Engine creation and get_session dependency
│   └── auth.py                    # JWT or mock auth (if used)
└── modules/{domain}/
    ├── models.py                  # Request/Response/Audit SQLModel + Pydantic models
    ├── router.py                  # Single endpoint declaration — no logic
    ├── service.py                 # Workflow orchestration: IO resolution → Hamilton → audit persistence
    ├── steps.py                   # Business logic functions consumed by Hamilton
    └── admin.py                   # Read-only SQLAdmin view of audit records (optional)
```

### main.py responsibilities

```python
# lifespan: run alembic upgrade head (tables only, no migrations)
# register router with app.include_router(router, prefix="/domain")
# exception handlers: HTTPException → {"status", "messages"}, Exception → 503
```

No MCP server, no SQLAdmin write access, no JWT (unless the engine requires user context).

## 2. The Single Endpoint

Every workflow engine exposes exactly **one POST endpoint**:

```python
@router.post("/estimate", response_model=DomainResponse)
async def estimate(
    request: DomainRequest,
    session: AsyncSessionDep,
    x_correlation_id: Annotated[Optional[uuid.UUID], Header()] = None,
) -> DomainResponse:
    if not x_correlation_id:
        raise HTTPException(
            status_code=400,
            detail={"status": 400, "messages": ["Missing X-Correlation-ID header"]},
        )
    return await service.run_domain_workflow(session, request, x_correlation_id)
```

- `X-Correlation-ID` is **required** — callers (other engines or frontends) provide it.
- The router has zero business logic. All logic lives in `service.py`.
- Duplicate `correlation_id` → return 400 immediately (idempotency guard at service entry).

## 3. Service Orchestration Pattern (service.py)

The service function follows a strict 3-phase pattern:

```python
async def run_domain_workflow(
    session: AsyncSession,
    request: DomainRequest,
    correlation_id: uuid.UUID,
) -> DomainResponse:
    # PHASE 0: Idempotency check
    existing = await session.exec(select(DomainAudit).where(DomainAudit.correlation_id == correlation_id).limit(1))
    if existing.first():
        raise HTTPException(status_code=400, detail=f"Already processed: {correlation_id}")

    # PHASE 1: Resolve IO-bound dependencies BEFORE Hamilton
    # Run async calls (external services, geocoding) in parallel with asyncio.gather
    result_a, result_b = await asyncio.gather(
        steps.fetch_external_a(request.field),
        steps.fetch_external_b(request.field),
    )

    # PHASE 2: Hamilton executes CPU-bound / deterministic business logic
    inputs = {"result_a": result_a, "result_b": result_b}
    dr = driver.Driver(inputs, steps)
    logic_results = dr.execute(["output_var_a", "output_var_b", "final_output"])

    # PHASE 3: Persist audit row per step, then return response
    full_results = {"result_a": result_a, "result_b": result_b, **logic_results}
    for step_name in ["result_a", "result_b", "output_var_a", "output_var_b", "final_output"]:
        audit_row = DomainAudit(
            correlation_id=correlation_id,
            step_name=step_name,
            step_type=_step_type_for(step_name),
            input=_input_for(step_name, request, full_results),
            output=clean_for_json(full_results[step_name]),
        )
        session.add(audit_row)
    await session.commit()

    return DomainResponse(correlation_id=correlation_id, ...)
```

### Why IO before Hamilton
Hamilton is synchronous by design for business logic. All async IO (HTTP calls to external services, geocoding APIs) MUST be resolved before calling `driver.Driver`, using `asyncio.gather` for parallelism.

## 4. Steps (steps.py)

```python
# steps.py — ONLY functions, no classes

async def fetch_external_data(field: str) -> dict[str, Any]:
    async with httpx.AsyncClient() as client:
        response = await client.post(SERVICE_URL, json={"field": field}, timeout=10.0)
        response.raise_for_status()
        return response.json()


def output_var_a(result_a: dict[str, Any], result_b: dict[str, Any]) -> Decimal:
    # Hamilton node: function name = variable name in the DAG
    # Parameters = other node names (Hamilton injects them)
    ...


def final_output(output_var_a: Decimal, output_var_b: Decimal) -> Decimal:
    ...
```

Constraints:
- **No classes** in `steps.py` — only module-level functions.
- Functions consumed by Hamilton MUST be synchronous (Hamilton drives them). IO functions are async and called before Hamilton.
- Hamilton matches function names to variable names. The DAG is implicit — keep naming consistent.
- External service URLs are module-level constants using `http://{service-name}:{port}/...` (Docker internal network).

## 5. Audit Model & Traceability

```python
class StepType(str, Enum):
    ENRICHING = "enriching"               # Geocoding, distance calculation
    FETCH_CONFIGURATION = "fetch_configuration"  # Calls to config services
    CALCULATE_ADJUSTMENT = "calculate_adjustment"  # Business logic steps
    EQUATION = "equation"                 # Final computation steps


class DomainAudit(SQLModel, table=True):
    __tablename__ = "domain_audit"

    id: int | None = Field(default=None, primary_key=True)
    correlation_id: uuid.UUID = Field(index=True)
    step_name: str = Field(max_length=255)
    step_type: str = Field(max_length=50)
    input: dict[str, Any] = Field(default_factory=dict, sa_column=Column(JSON))
    output: Any = Field(default=None, sa_column=Column(JSON))
    timestamp: datetime = Field(default_factory=lambda: datetime.now(timezone.utc).replace(tzinfo=None))

    model_config = ConfigDict(arbitrary_types_allowed=True)
```

### Configuration tracking

When a step calls a configuration service (e.g., `/resolve`), the response MUST include `uuid` and `version`. These MUST be stored in the audit row's `output` to enable full traceability:

```python
# The config service /resolve returns {"uuid": "...", "version": 2, ...}
# Store the full response as the step output — uuid + version are preserved automatically
audit_row = DomainAudit(step_name="fuel_config", output=clean_for_json(fuel_config_response), ...)
```

### JSON serialisation helper

All audit outputs MUST be serialised to plain JSON-safe types before storing:

```python
def clean_for_json(obj: Any) -> Any:
    import numpy as np
    if isinstance(obj, (Decimal, np.float64)):
        return float(obj)
    if isinstance(obj, uuid.UUID):
        return str(obj)
    if isinstance(obj, dict):
        return {str(k): clean_for_json(v) for k, v in obj.items()}
    if isinstance(obj, list):
        return [clean_for_json(x) for x in obj]
    return obj
```

## 6. Response Model

```python
class DomainAdjustment(SQLModel):
    name: str
    amount: Decimal
    config_uuid: uuid.UUID | None = None   # From the config service response
    config_version: int | None = None       # From the config service response


class DomainResponse(SQLModel):
    correlation_id: uuid.UUID
    load: Load                             # Enriched with coordinates, distance
    adjustments: list[DomainAdjustment]
    # ...final computed values
```

## 7. Calling Configuration Services

Engines call configuration services via HTTP, never by importing them.

```python
# steps.py
CONFIG_SERVICE_URL = "http://service-name:8001/domain-configs/resolve"

async def domain_config(load: dict[str, Any]) -> dict[str, Any]:
    async with httpx.AsyncClient() as client:
        response = await client.post(CONFIG_SERVICE_URL, json={"load": load}, timeout=10.0)
        response.raise_for_status()
        result: dict[str, Any] = response.json()
        return result  # Always returns the raw dict including uuid + version
```

- Use the Docker internal hostname (`http://service-name:port`), not localhost.
- `response.raise_for_status()` — if a config service returns 404 (no config match), the engine step fails and the workflow error propagates.

## 8. Database Setup (tools/db.py)

Identical pattern to configuration services:

```python
engine = create_async_engine(
    url=os.environ["DATABASE_URL"],
    echo=False,
    connect_args={"server_settings": {"search_path": f"{schema},public"}},
)

async def get_session() -> AsyncGenerator[AsyncSession, None]:
    async with AsyncSession(engine, expire_on_commit=False) as session:
        yield session
```

- No migrations during tests — `SQLModel.metadata.create_all` in `test_db` fixture.
- Engines do NOT use Casdoor JWT for their endpoint (no user role on engine calls). `auth_token` fixture returns `"mock-token"`.

## 9. Testing Conventions

### conftest.py required fixtures

```python
@pytest_asyncio.fixture(scope="session")
async def test_db():
    engine = create_async_engine(url, echo=False, poolclass=NullPool)
    from src.modules.domain.models import DomainAudit  # noqa: F401  ← triggers table registration
    async with engine.begin() as conn:
        await conn.run_sync(SQLModel.metadata.create_all)
    yield engine
    async with engine.begin() as conn:
        await conn.run_sync(SQLModel.metadata.drop_all)
    await engine.dispose()

@pytest_asyncio.fixture(scope="function")
async def clean_table(test_db):
    async with AsyncSession(test_db) as session:
        await session.exec(text("DELETE FROM domain_audit"))
        await session.commit()
    yield

@pytest_asyncio.fixture(scope="session")
async def auth_token():
    return "mock-token"   # Engines do not enforce JWT roles

@pytest_asyncio.fixture(scope="function")
async def client(test_db):
    from src.tools import db as db_module
    db_module.engine = test_db
    transport = httpx.ASGITransport(app=app)
    async with httpx.AsyncClient(transport=transport, base_url="http://test") as ac:
        yield ac
```

### Test pattern

```python
@pytest.mark.asyncio
async def test_estimate_success(client, clean_table):
    correlation_id = str(uuid.uuid4())
    response = await client.post(
        "/domain/estimate",
        json={"load": {...}},
        headers={"x-correlation-id": correlation_id},
    )
    assert response.status_code == 200
    data = response.json()
    assert data["correlation_id"] == correlation_id
    assert "adjustments" in data
```

- No `auth_token` header needed unless the engine uses JWT.
- Always provide `X-Correlation-ID` as a header — use a fresh `uuid4()` per test.
- One test per workflow scenario. Check `correlation_id` in the response to confirm traceability.
- External service calls (config services, geocoding APIs) MUST be mocked via `respx` or `pytest-httpx` to avoid real network calls in tests.
