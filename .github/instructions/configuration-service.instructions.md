---
description: "Use when creating or modifying a configuration service (base_margin_config, fuel_cost_config, driver_tariff_config, lead_time_config). Covers file structure, REST API conventions, versioning pattern, database setup, SQLAdmin UI, MCP tools, usability requirements, and testing."
---

# Configuration Service Implementation Conventions

Configuration services manage versioned business rules with CRUD + resolve capabilities.
They are exposed both as a REST API and as an MCP server. They are NOT workflow engines — no Hamilton, no steps.py.

## 1. File Structure & Responsibilities

```text
src/
├── main.py                        # App bootstrap, lifespan, exception handlers, admin + router registration
├── tools/
│   ├── db.py                      # Engine creation and get_session dependency
│   ├── auth.py                    # JWT verification + VerifiedJwt Annotated type
│   └── admin_auth.py              # Session-based admin authentication for SQLAdmin
└── modules/{domain}/
    ├── models.py                  # SQLModel table + Pydantic DTOs + Response with from_orm_row classmethod
    ├── router.py                  # FastAPI routes — declarations only, no business logic
    ├── service.py                 # Async CRUD + resolve functions, only place with DB logic
    ├── admin.py                   # SQLAdmin ModelView for the web admin UI
    ├── mcp_server.py              # Single line: mcp = FastMCP("Service Name")
    └── mcp_tools.py               # @mcp.tool decorated functions — delegates to service.py
```

### main.py responsibilities

```python
# lifespan: run alembic upgrade head, then fetch_jwks
# mount MCP app on "/" with streamable-http transport
# register sqladmin Admin + view
# register router with app.include_router(router, prefix="/domain-configs")
# exception handlers: HTTPException → {"status", "messages"}, IntegrityError → 409, Exception → 503
mcp_app = mcp.http_app(path="/", transport="streamable-http")
app = FastAPI(lifespan=combine_lifespans(lifespan, mcp_app.lifespan))
```

Import `src.modules.{domain}.mcp_tools` with `# noqa: F401` in `main.py` to trigger tool registration as a side effect.

## 2. REST API Conventions

### Required endpoints

| Method | Path       | Auth    | Description                                         |
|--------|------------|---------|-----------------------------------------------------|
| POST   | `/`        | JWT     | Create new config (uuid4, version=1)                |
| GET    | `/`        | JWT     | List latest version of each config, with filters    |
| GET    | `/{uuid}`  | JWT     | Get latest version of a specific config             |
| PUT    | `/{uuid}`  | JWT     | Update: inserts new row with version+1, same UUID   |
| DELETE | `/{uuid}`  | JWT     | Delete all versions of a config by UUID             |
| POST   | `/resolve` | no auth | Resolve the best-matching config for a real context |

### Router pattern

```python
AsyncSessionDep = Annotated[AsyncSession, Depends(get_session)]

router = APIRouter(tags=["Domain Name"])

@router.post("", response_model=DomainConfig, status_code=status.HTTP_201_CREATED)
async def create_config(req: CreateRequest, session: AsyncSessionDep, jwt: VerifiedJwt) -> DomainConfig:
    created_by = jwt.get("preferred_username") or jwt.get("name", "api_user")
    return await create_domain_config(session, req, created_by)
```

- `created_by` is always derived from JWT claims — never from request headers or body.
- `/resolve` does not require a JWT since it is called by engines without user context.

### List endpoint — filter class

Filters are declared as a dependency class, not as individual query params:

```python
class ListFilterParams:
    def __init__(
        self,
        field_a: str | None = Query(None),
        field_b: str | None = Query(None),
    ):
        self.field_a = field_a
        self.field_b = field_b

@router.get("", response_model=list[DomainConfig])
async def list_configs(
    session: AsyncSessionDep, jwt: VerifiedJwt, filters: Annotated[ListFilterParams, Depends()]
) -> Sequence[DomainConfig]:
    return await list_domain_configs(session, field_a=filters.field_a, field_b=filters.field_b)
```

All filterable domain fields MUST be exposed as optional filter parameters. Filters use exact match.

## 3. Versioning Pattern (Append-Only)

The DB table uses `(uuid, version)` as a composite primary key.

- **Create**: `uuid = uuid4()`, `version = 1`. Check for duplicate combination before insert → 409 if exists.
- **Update**: read current latest version, insert new row with same UUID and `version = current.version + 1`. Check for duplicate across OTHER UUIDs → 409 if exists.
- **Get**: `SELECT ... WHERE uuid = ? ORDER BY version DESC LIMIT 1`.
- **List**: `SELECT DISTINCT ON (uuid) ... ORDER BY uuid, version DESC` — returns only the latest version per UUID.
- Older versions are never deleted; they serve as an audit trail.

## 4. Models (models.py)

```python
class DomainConfig(SQLModel, table=True):
    __tablename__ = "domain_config"
    __table_args__ = (CheckConstraint(...),)        # DB-level invariants

    uuid: uuid.UUID = Field(sa_column_kwargs={"primary_key": True})
    version: int = Field(sa_column_kwargs={"primary_key": True})
    # Flat columns — no JSON, no nested SQLModel in the DB table
    created_by: str = Field(max_length=255)
    created_at: datetime = Field(default_factory=lambda: datetime.now(timezone.utc).replace(tzinfo=None))


class DomainConfigResponse(SQLModel):
    # Nested representation for API consumers
    @classmethod
    def from_orm_row(cls, row: DomainConfig) -> "DomainConfigResponse":
        # Reconstruct nested Pydantic models from flat DB columns
        ...


class CreateRequest(BaseDomainRequest):
    pass

class UpdateRequest(BaseDomainRequest):
    pass

class ResolveRequest(SQLModel):
    # Only context fields needed to find a match — no margin_percent or config-only fields
    ...

# Always call model_rebuild() at end of file for forward references
DomainConfig.model_rebuild()
DomainConfigResponse.model_rebuild()
CreateRequest.model_rebuild()
```

- DB columns are flat (e.g., `pickup_country`, `pickup_state`). Pydantic nesting (e.g., `Stop`) is rebuilt in `from_orm_row`.
- Validators (`@field_validator`, `@model_validator`) live in the request model, not the DB model.
- `CheckConstraint` enforces hierarchies and minimum requirements at the DB level.

## 5. Service Functions (service.py)

```python
async def create_domain_config(session: AsyncSession, req: CreateRequest, created_by: str) -> DomainConfig: ...
async def list_domain_configs(session: AsyncSession, field_a: str | None = None, ...) -> Sequence[DomainConfig]: ...
async def get_domain_config(session: AsyncSession, uuid_val: uuid.UUID) -> DomainConfig: ...  # raises 404
async def update_domain_config(session: AsyncSession, uuid_val: uuid.UUID, req: UpdateRequest, created_by: str) -> DomainConfig: ...
async def delete_domain_config(session: AsyncSession, uuid_val: uuid.UUID) -> None: ...
async def resolve_domain_config(session: AsyncSession, req: ResolveRequest) -> DomainConfig | None: ...  # None = no match
```

- `list_` applies `DISTINCT ON (uuid)` and filters via chained `.where()` clauses — only when the param is not None.
- `get_` raises `HTTPException(404)`. `resolve_` returns `None` — the router raises 404.
- Duplicate check uses `SELECT COUNT(*)` before insert/update, raising `HTTPException(409)`.

## 6. Database Setup (tools/db.py)

```python
engine = create_async_engine(
    url=os.environ["DATABASE_URL"],       # postgresql+asyncpg://...
    echo=False,
    connect_args={"server_settings": {"search_path": f"{schema},public"}},
)

async def get_session() -> AsyncGenerator[AsyncSession, None]:
    async with AsyncSession(engine, expire_on_commit=False) as session:
        yield session
```

- **No Alembic migrations during tests** — tests call `SQLModel.metadata.create_all` / `drop_all` directly.
- In production, `main.py` lifespan runs `alembic upgrade head` via subprocess before the app starts.
- All DB access is `async/await` — never synchronous.
- Schema isolation is enforced via `search_path`: each service owns its own PostgreSQL schema.

## 7. SQLAdmin UI (admin.py)

```python
# mypy: ignore-errors   ← required because SQLAdmin's typing is incompatible with mypy strict

class DomainConfigAdmin(ModelView, model=DomainConfig):
    column_list = [...]     # All columns for the list view
    form_columns = [...]    # Excludes uuid, version, created_by, created_at

    async def on_model_change(self, data, model, is_created, request):
        for k, v in data.items():
            if v == "":
                data[k] = None              # WTForms sends empty string; PostgreSQL needs NULL
        if is_created:
            # Duplicate check
            data["uuid"] = uuid.uuid4()
            data["version"] = 1
            data["created_by"] = request.session.get("admin_user", "admin")

    async def update_model(self, request, pk: str, data: dict):
        # Read current version, insert new row with version+1
        ...
```

- Always convert empty strings to `None` in `on_model_change` before any logic runs.
- The admin `update_model` MUST implement the same version-increment logic as `service.update_`.
- Add `# mypy: ignore-errors` at the top — do not fix mypy errors in admin.py.

## 8. Usability Requirements

These requirements ensure the service is usable from both a frontend and an MCP agent.

- **Filters on list**: every domain field that could be used for lookup MUST be an optional filter on `GET /` and on the `get_all_configs_tool` MCP tool.
- **Latest-version-only**: `GET /` always returns only the latest version per UUID. Never expose raw multi-version rows.
- **Stable ordering**: list results are always ordered by `uuid` (and `version DESC` for the DISTINCT select).
- **Resolve endpoint**: every configuration service MUST expose `/resolve` (POST) to find the best-matching config for a given real-world context. The resolve logic uses a **priority scoring algorithm** based on specificity.
- **Resolve uses full context**: callers of `/resolve` MUST provide the complete known context of the entity being evaluated (e.g., customer name, full pickup + drop geography). Omitting known fields degrades match quality.

## 9. MCP Tool Conventions

See `mcp-tools.instructions.md` for the full MCP conventions.

Every configuration service MUST expose these MCP tools:

| Tool name                      | Annotation        | Operation                             |
|-------------------------------|-------------------|---------------------------------------|
| `set_{domain}`                | `idempotentHint`  | Create or update (uuid_str = update)  |
| `delete_{domain}_tool`        | `destructiveHint` | Delete by UUID string                 |
| `resolve_applicable_{domain}` | `readOnlyHint`    | Resolve best match for a context      |
| `get_all_configs_tool`        | `readOnlyHint`    | List all, with optional filters       |
| `get_config_tool`             | `readOnlyHint`    | Get single config by UUID string      |

## 10. Testing Conventions

### conftest.py required fixtures

```python
@pytest_asyncio.fixture(scope="session")
async def test_db():
    # Creates engine → drop_all → create_all before yield; drop_all + dispose after yield

@pytest_asyncio.fixture(scope="function")
async def clean_table(test_db):
    # DELETE FROM {table} before yield — ensures each test starts clean

@pytest_asyncio.fixture(scope="session")
async def auth_token():
    # Fetches real Casdoor token via password grant using test service account

@pytest_asyncio.fixture(scope="session", autouse=True)
async def load_jwks():
    # Calls fetch_jwks() so JWT verification works during tests

@pytest_asyncio.fixture(scope="function")
async def client(test_db):
    # Replaces db_module.engine with test_db; wraps app with ASGITransport

@pytest_asyncio.fixture(scope="function")
async def mcp_client(test_db, clean_table):
    # Replaces engine in mcp_tools_module with test_db; yields fastmcp.Client(mcp)
```

### HTTP tests

```python
@pytest.mark.asyncio
async def test_create_success(client, auth_token, clean_table):
    resp = await client.post("/domain-configs", json={...}, headers={"Authorization": f"Bearer {auth_token}"})
    assert resp.status_code == 201
    assert resp.json()["version"] == 1
```

- One test per endpoint use case. Always pass `clean_table` for isolation.
- Assert `status_code` and the key fields of the response body.
- Happy path only unless a specific constraint is being tested.

### MCP tests

```python
async def test_set_domain_config(mcp_client: Client):
    result = await mcp_client.call_tool("set_domain_config", {"field": "value"})
    assert result.data["result"] == "Created successfully"
    assert result.data["config"]["version"] == 1
```

- One test per MCP tool, covering the happy path.
- Access results via `result.data[...]`.
- No `@pytest.mark.asyncio` needed if `asyncio_mode = "auto"` is set in `pyproject.toml`.
