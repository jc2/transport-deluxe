---
description: "Use when creating or modifying a configuration service (base_margin_config, fuel_cost_config, driver_tariff_config, lead_time_config). Covers file structure, layer responsibilities, DAO/DTO model split, REST API conventions, versioning pattern, authentication, database setup, SQLAdmin UI, MCP tools, and testing."
---

# Configuration Service Implementation Conventions

Configuration services manage versioned business rules with CRUD + resolve capabilities.
They expose both a REST API and an MCP server. They are NOT workflow engines — no Hamilton, no steps.py.

## 1. File Structure & Responsibilities

```text
src/
├── main.py                          # App bootstrap, lifespan, exception handlers, admin + router registration
├── tools/
│   ├── db.py                        # Engine singleton + get_db_session() context manager
│   ├── auth.py                      # JWT verification for REST (VerifiedJwt) + MCP (get_mcp_auth)
│   └── admin_auth.py                # Session-based admin auth via Casdoor ROPC grant
└── modules/{domain}/
    ├── models/
    │   ├── __init__.py              # Re-exports all DAOs and DTOs
    │   ├── dao.py                   # SQLModel table=True + internal Pydantic helper models
    │   └── dto.py                   # Pydantic BaseModel request/response DTOs (NOT SQLModel)
    ├── exceptions.py                # Domain exceptions: ConfigNotFoundError, DuplicateConfigError
    ├── repo.py                      # All DB operations — manages its own sessions
    ├── service.py                   # Business logic only — calls repo.*, never touches DB directly
    ├── router.py                    # FastAPI route declarations only — calls service.*, no logic
    ├── admin.py                     # SQLAdmin ModelView for the web admin UI
    ├── mcp_server.py                # mcp = FastMCP("Name", auth=get_mcp_auth())
    └── mcp_tools.py                 # @mcp.tool decorated functions — delegates to service.*
```

## 2. Layer Responsibilities (Strict Isolation)

The call chain is one-directional and non-skippable:

```
router.py    →  service.py  →  repo.py  →  database
mcp_tools.py →  service.py  →  repo.py  →  database
admin.py     →  database (via SQLAdmin session_maker — admin is the exception)
```

### router.py
- Declares routes only. Zero business logic.
- Extracts `created_by` from JWT: `jwt.get("preferred_username") or jwt.get("name") or jwt["sub"]`.
- Calls `service.*` functions with DTOs. Never imports `repo.*`.
- No `AsyncSession` injection — sessions are repo-owned.

### service.py
- Pure business logic: validates constraints, builds DAOs, interprets domain exceptions.
- Calls `repo.*` functions only. Never imports `db.py` or writes SQL.
- Returns DTOs built via `DomainConfigResponse.from_dao(record)`.
- Domain exceptions (`ConfigNotFoundError`, `DuplicateConfigError`) bubble up — `main.py` converts them to HTTP responses.
- Never receives or passes sessions. No session parameter on any service function.

### repo.py
- All SQL lives here. Each function opens its own session via `get_db_session()`.
- Raises `ConfigNotFoundError` when a record is not found.
- Catches `IntegrityError` and re-raises as `DuplicateConfigError`.
- Never imports service.py.

### exceptions.py

```python
class ConfigNotFoundError(Exception):
    """Raised when a requested configuration does not exist."""

class DuplicateConfigError(Exception):
    """Raised when a configuration with the same parameters already exists."""
```

## 3. Models: DAO vs DTO

### dao.py — Database Models

Contains the `SQLModel, table=True` class and any internal Pydantic helper models used across layers.

```python
# dao.py
from sqlalchemy import CheckConstraint
from sqlmodel import Field, SQLModel

class Customer(SQLModel): ...   # Pydantic helper (not a table), used in DTO + service
class Stop(SQLModel): ...       # Pydantic helper (not a table)

class DomainConfig(SQLModel, table=True):
    __tablename__ = "domain_config"
    __table_args__ = (CheckConstraint(...),)

    uuid: uuid.UUID = Field(sa_column_kwargs={"primary_key": True})
    version: int = Field(sa_column_kwargs={"primary_key": True})

    # FLAT columns — NO nested models, NO JSON columns in the DB table
    customer_name: str | None = Field(default=None, max_length=255)
    # ... all fields as scalar columns ...

    created_by: str = Field(max_length=255)
    created_at: datetime = Field(default_factory=lambda: datetime.now(timezone.utc).replace(tzinfo=None))
```

### dto.py — API Request/Response Models

DTOs are `pydantic.BaseModel` (NOT `SQLModel`). They represent the structured API contract.

```python
# dto.py
from pydantic import BaseModel, field_validator, model_validator
from .dao import DomainConfig, Customer, Stop

class DomainConfigResponse(BaseModel):
    uuid: uuid.UUID
    version: int
    customer: Customer | None
    pickup: Stop | None
    margin_percent: float
    created_by: str
    created_at: datetime

    @classmethod
    def from_dao(cls, row: DomainConfig) -> "DomainConfigResponse":
        # Reconstruct nested Pydantic structure from flat DAO columns
        customer = Customer(name=row.customer_name or "") if row.customer_name else None
        ...
        return cls(uuid=row.uuid, version=row.version, customer=customer, ...)

class CreateRequest(BaseModel):
    customer: Customer | None = None
    pickup: Stop | None = None
    margin_percent: float

    @field_validator("margin_percent")
    @classmethod
    def must_be_valid(cls, v: float) -> float:
        if v < 0 or v > 0.99:
            raise ValueError("margin_percent must be between 0 and 0.99")
        return v

    @model_validator(mode="after")
    def check_at_least_one_field(self) -> "CreateRequest":
        # Enforce business invariants before hitting the service layer
        ...

class UpdateRequest(CreateRequest): pass

class ResolveRequest(BaseModel):
    customer: Customer | None = None
    pickup: Stop | None = None
    drop: Stop | None = None
```

### models/__init__.py

Re-exports everything so consumers use `from .models import ...`:

```python
from .dao import DomainConfig, Customer, Stop
from .dto import DomainConfigResponse, CreateRequest, UpdateRequest, ResolveRequest

__all__ = ["DomainConfig", "Customer", "Stop",
           "DomainConfigResponse", "CreateRequest", "UpdateRequest", "ResolveRequest"]
```

## 4. Database Layer (tools/db.py)

```python
import os
from contextlib import asynccontextmanager
from sqlalchemy.ext.asyncio import create_async_engine, AsyncEngine
from sqlmodel.ext.asyncio.session import AsyncSession

def _make_engine() -> AsyncEngine:
    url = os.environ["DATABASE_URL"]
    schema = os.environ.get("DB_SCHEMA", "public")
    return create_async_engine(
        url, echo=False,
        connect_args={"server_settings": {"search_path": f"{schema},public"}},
    )

engine = _make_engine()

@asynccontextmanager
async def get_db_session() -> AsyncGenerator[AsyncSession, None]:
    """Context manager for DB sessions. Tests swap engine via: db_module.engine = test_engine."""
    async with AsyncSession(engine, expire_on_commit=False) as session:
        yield session
```

`engine` is a module-level singleton. Tests reassign `db_module.engine` to redirect all repo calls to the test DB.
**Do NOT** use `Depends(get_session)` in FastAPI routes — sessions are exclusively repo-owned.

## 5. Repo Layer (repo.py)

Each function opens its own session. Callers pass only domain values, never sessions.

```python
from src.tools.db import get_db_session
from .models import DomainConfig
from .exceptions import ConfigNotFoundError, DuplicateConfigError

async def get_config(uuid_val: uuid.UUID) -> DomainConfig:
    async with get_db_session() as session:
        stmt = (
            select(DomainConfig)
            .where(DomainConfig.uuid == uuid_val)
            .order_by(col(DomainConfig.version).desc())
            .limit(1)
        )
        result = await session.exec(stmt)
        record = result.first()
        if not record:
            raise ConfigNotFoundError(f"Configuration {uuid_val} not found.")
        return record

async def list_configs(
    customer_name: str | None = None,
    pickup_country: str | None = None,
    # ... all filterable fields as keyword-only args with default None ...
) -> Sequence[DomainConfig]:
    async with get_db_session() as session:
        stmt = (
            select(DomainConfig)
            .distinct(col(DomainConfig.uuid))
            .order_by(col(DomainConfig.uuid), col(DomainConfig.version).desc())
        )
        if customer_name is not None:
            stmt = stmt.where(DomainConfig.customer_name == customer_name)
        # ... one `if field is not None` block per optional filter ...
        result = await session.exec(stmt)
        return result.all()

async def count_matching(
    customer_name: str | None,
    pickup_country: str | None,
    # ... all fields (not optional — pass None explicitly for "no value") ...
    exclude_uuid: uuid.UUID | None = None,
) -> int:
    """Duplicate-detection used before create/update."""
    async with get_db_session() as session:
        stmt = (
            select(func.count())
            .select_from(DomainConfig)
            .where(DomainConfig.customer_name == customer_name, ...)
        )
        if exclude_uuid is not None:
            stmt = stmt.where(DomainConfig.uuid != exclude_uuid)
        result = await session.exec(stmt)
        return result.one()

async def get_all_active_configs() -> Sequence[DomainConfig]:
    """Latest version of every distinct config — used by resolve logic."""
    ...

async def save_config(record: DomainConfig) -> DomainConfig:
    async with get_db_session() as session:
        try:
            session.add(record)
            await session.commit()
            await session.refresh(record)
            return record
        except IntegrityError as exc:
            await session.rollback()
            raise DuplicateConfigError("Already exists.") from exc

async def delete_config(uuid_val: uuid.UUID) -> None:
    async with get_db_session() as session:
        # fetch latest → delete or raise ConfigNotFoundError
        ...
```

## 6. Service Layer (service.py)

Receives DTOs, calls repo functions, returns DTOs. No SQL, no sessions, no DB imports.

```python
from . import repo
from .exceptions import ConfigNotFoundError, DuplicateConfigError
from .models import DomainConfig, DomainConfigResponse, CreateRequest, UpdateRequest, ResolveRequest

def _flatten_request(req: CreateRequest | UpdateRequest) -> dict[str, str | None]:
    """Map nested DTO fields to flat DB column names."""
    return {
        "customer_name": req.customer.name if req.customer else None,
        "pickup_country": req.pickup.country if req.pickup and req.pickup.country else None,
        ...
    }

async def create_domain_config(req: CreateRequest, created_by: str) -> DomainConfigResponse:
    fields = _flatten_request(req)
    if await repo.count_matching(**fields) > 0:
        raise DuplicateConfigError("Already exists.")
    dao = DomainConfig(uuid=uuid4(), version=1, **fields, margin_percent=req.margin_percent, created_by=created_by)
    return DomainConfigResponse.from_dao(await repo.save_config(dao))

async def list_domain_configs(
    customer_name: str | None = None,
    pickup_country: str | None = None,
    # ... all filterable fields ...
) -> list[DomainConfigResponse]:
    records = await repo.list_configs(customer_name=customer_name, pickup_country=pickup_country, ...)
    return [DomainConfigResponse.from_dao(r) for r in records]

async def get_domain_config(uuid_val: uuid.UUID) -> DomainConfigResponse:
    return DomainConfigResponse.from_dao(await repo.get_config(uuid_val))

async def update_domain_config(uuid_val: uuid.UUID, req: UpdateRequest, created_by: str) -> DomainConfigResponse:
    current = await repo.get_config(uuid_val)  # raises ConfigNotFoundError if missing
    fields = _flatten_request(req)
    if await repo.count_matching(**fields, exclude_uuid=current.uuid) > 0:
        raise DuplicateConfigError("Already exists.")
    new_dao = DomainConfig(uuid=current.uuid, version=current.version + 1, **fields, created_by=created_by)
    return DomainConfigResponse.from_dao(await repo.save_config(new_dao))

async def delete_domain_config(uuid_val: uuid.UUID) -> None:
    await repo.delete_config(uuid_val)  # raises ConfigNotFoundError if missing

async def resolve_domain_config(req: ResolveRequest) -> DomainConfigResponse:
    all_configs = await repo.get_all_active_configs()
    valid_matches = [c for c in all_configs if _matches(c, req)]
    if not valid_matches:
        raise ConfigNotFoundError("No matching configuration found.")
    valid_matches.sort(key=_get_weight, reverse=True)  # priority-weight logic in service — pure Python
    return DomainConfigResponse.from_dao(valid_matches[0])
```

## 7. REST API (router.py)

Router declares routes and delegates. No logic, no SQL, no session imports.

```python
from fastapi import APIRouter, Depends, Query, status
from typing import Annotated
from ...tools.auth import VerifiedJwt
from .models import DomainConfigResponse, CreateRequest, UpdateRequest, ResolveRequest
from .service import (create_domain_config, list_domain_configs, get_domain_config,
                      update_domain_config, delete_domain_config, resolve_domain_config)

class ListFilterParams:
    def __init__(
        self,
        customer_name: str | None = Query(None),
        pickup_country: str | None = Query(None),
        # ... one param per filterable domain field ...
    ):
        self.customer_name = customer_name
        self.pickup_country = pickup_country
        # ... assign all ...

router = APIRouter(tags=["Domain Name"])

@router.post("", response_model=DomainConfigResponse, status_code=status.HTTP_201_CREATED)
async def create_config(req: CreateRequest, jwt: VerifiedJwt) -> DomainConfigResponse:
    created_by = jwt.get("preferred_username") or jwt.get("name") or jwt["sub"]
    return await create_domain_config(req, created_by)

@router.get("", response_model=list[DomainConfigResponse])
async def list_configs(jwt: VerifiedJwt, filters: Annotated[ListFilterParams, Depends()]) -> list[DomainConfigResponse]:
    return await list_domain_configs(customer_name=filters.customer_name, ...)

@router.get("/{uuid}", response_model=DomainConfigResponse)
async def get_config(uuid: uuid.UUID, jwt: VerifiedJwt) -> DomainConfigResponse:
    return await get_domain_config(uuid)

@router.put("/{uuid}", response_model=DomainConfigResponse)
async def update_config(uuid: uuid.UUID, req: UpdateRequest, jwt: VerifiedJwt) -> DomainConfigResponse:
    created_by = jwt.get("preferred_username") or jwt.get("name") or jwt["sub"]
    return await update_domain_config(uuid, req, created_by)

@router.delete("/{uuid}", status_code=status.HTTP_204_NO_CONTENT)
async def delete_config(uuid: uuid.UUID, jwt: VerifiedJwt) -> None:
    await delete_domain_config(uuid)

@router.post("/resolve", response_model=DomainConfigResponse)
async def resolve_config(req: ResolveRequest) -> DomainConfigResponse:
    return await resolve_domain_config(req)  # NO JWT — called by engines without user context
```

### Required endpoints

| Method | Path       | Auth    | Description                                         |
|--------|------------|---------|-----------------------------------------------------|
| POST   | `/`        | JWT     | Create new config (uuid4, version=1)                |
| GET    | `/`        | JWT     | List latest version of each config, with filters    |
| GET    | `/{uuid}`  | JWT     | Get latest version of a specific config             |
| PUT    | `/{uuid}`  | JWT     | Update: inserts new row with version+1, same UUID   |
| DELETE | `/{uuid}`  | JWT     | Delete latest version by UUID                       |
| POST   | `/resolve` | no auth | Resolve the best-matching config for a real context |

All filterable domain fields MUST be exposed as optional `ListFilterParams` query parameters. Filters use exact match.

## 8. Authentication (tools/auth.py)

### REST API — `VerifiedJwt` dependency

Validates JWT signature via JWKS and enforces the service-specific role.

```python
_REQUIRED_ROLE = "margin-configurator"

def _has_required_role(roles_claim: list[Any]) -> bool:
    # Casdoor encodes roles as [{"name": "role-name", ...}] or plain strings
    role_names = [r.get("name") if isinstance(r, dict) else r for r in roles_claim]
    return _REQUIRED_ROLE in role_names

async def verify_jwt(credentials: JwtCredentials) -> dict[str, Any]:
    if credentials is None:
        raise HTTPException(status_code=401, detail={"messages": ["Missing Authorization header"]})
    access_token = await _get_rest_verifier().verify_token(credentials.credentials)
    if access_token is None:
        raise HTTPException(status_code=401, detail={"messages": ["Invalid or expired token"]})
    roles = access_token.claims.get("roles") or []
    if not _has_required_role(roles):
        raise HTTPException(status_code=403, detail={"messages": [f"Missing required role: {_REQUIRED_ROLE}"]})
    return dict(access_token.claims)

VerifiedJwt = Annotated[dict[str, Any], Depends(verify_jwt)]
```

### MCP Authentication — `CasdoorJWTVerifier` + `get_mcp_auth()`

```python
class CasdoorJWTVerifier(JWTVerifier):
    async def verify_token(self, token: str) -> Any:
        access_token = await super().verify_token(token)
        if access_token is None:
            return None
        if not _has_required_role(access_token.claims.get("roles") or []):
            return None
        return access_token

def get_mcp_auth() -> OAuthProxy:
    """Singleton OAuthProxy configured via env vars: CASDOOR_ISSUER, CASDOOR_INTERNAL_URL,
    CASDOOR_CLIENT_ID, CASDOOR_CLIENT_SECRET, SERVICE_BASE_URL."""
    ...
```

MCP tools read caller identity via:
```python
from fastmcp.server.dependencies import get_access_token

def _current_user() -> str:
    token = get_access_token()
    if token:
        return token.claims.get("preferred_username") or token.claims.get("name") or token.client_id
    return "mcp-agent"
```

### Admin Authentication (tools/admin_auth.py)

```python
class AdminAuth(AuthenticationBackend):
    async def login(self, request: Request) -> bool:
        # 1. Read username/password from form
        # 2. POST to Casdoor ROPC endpoint /api/login/oauth/access_token
        # 3. Call verify_jwt() on the access_token to enforce role
        # 4. Store {admin_user, service, role} in signed session cookie
        ...

    async def authenticate(self, request: Request) -> bool:
        return (
            request.session.get("service") == SERVICE_NAME
            and request.session.get("role") == REQUIRED_ROLE
            and bool(request.session.get("admin_user"))
        )
```

## 9. Versioning Pattern (Append-Only)

The DB table uses `(uuid, version)` as composite primary key.

- **Create**: `uuid = uuid4()`, `version = 1`. Use `count_matching()` → raise `DuplicateConfigError` if > 0.
- **Update**: fetch current via `get_config()`, insert new row with same UUID and `version = current.version + 1`. Use `count_matching(exclude_uuid=current.uuid)` → raise if > 0.
- **Get**: `SELECT ... WHERE uuid = ? ORDER BY version DESC LIMIT 1`.
- **List**: `SELECT DISTINCT ON (uuid) ... ORDER BY uuid, version DESC` — returns only latest version per UUID.
- Older versions are never deleted; they serve as an audit trail.

## 10. main.py Responsibilities

```python
# Always in this order:
import src.modules.{domain}.mcp_tools  # noqa: F401  ← side-effect: registers MCP tools

mcp_app = mcp.http_app(path="/mcp", transport="streamable-http")
app = FastAPI(title="...", lifespan=combine_lifespans(lifespan, mcp_app.lifespan))

# lifespan: run alembic upgrade head via subprocess
# Register SQLAdmin with AdminAuth + domain ModelView
# Register router with prefix
# Mount MCP app
app.include_router(router, prefix="/domain-configs")
app.mount("/", mcp_app)

# Exception handlers (register all four):
# StarletteHTTPException  → {"messages": [...]}
# RequestValidationError  → {"messages": [...]}  (flatten Pydantic errors)
# ConfigNotFoundError     → 404  {"messages": [...]}
# DuplicateConfigError    → 409  {"messages": [...]}
# Exception               → 503  {"messages": ["Service temporarily unavailable"]}
```

## 11. SQLAdmin (admin.py)

```python
# mypy: ignore-errors  ← always at top of admin.py

class DomainConfigAdmin(ModelView, model=DomainConfig):
    column_list = [DomainConfig.uuid, DomainConfig.version, ...]
    form_columns = [DomainConfig.customer_name, ...]  # exclude uuid, version, created_at, created_by

    async def on_model_change(self, data, model, is_created, request):
        for k, v in data.items():
            if v == "":
                data[k] = None  # WTForms empty strings → None → PostgreSQL NULL
        if is_created:
            # Duplicate check, then:
            data["uuid"] = uuid4()
            data["version"] = 1
            data["created_by"] = request.session.get("admin_user") or "admin"

    async def update_model(self, request, pk: str, data: dict):
        # Fetch current record → create new row with version+1, same uuid
        # Set created_by from session cookie
        ...
```

## 12. Testing

Integration tests only. Run inside Docker via `make test`. Never run locally.

### conftest.py Pattern

```python
@pytest_asyncio.fixture(scope="session")
async def test_db():
    engine = create_async_engine(url, echo=False, poolclass=NullPool)
    from sqlmodel import SQLModel
    from src.modules.{domain}.models import DomainConfig  # noqa: F401 — registers table metadata
    async with engine.begin() as conn:
        await conn.run_sync(SQLModel.metadata.drop_all)
        await conn.run_sync(SQLModel.metadata.create_all)
    yield engine
    async with engine.begin() as conn:
        await conn.run_sync(SQLModel.metadata.drop_all)
    await engine.dispose()

@pytest_asyncio.fixture(scope="function")
async def clean_table(test_db):
    async with AsyncSession(test_db) as session:
        await session.exec(text("DELETE FROM domain_config"))
        await session.commit()
    yield

@pytest_asyncio.fixture(scope="session")
async def auth_token():
    async with httpx.AsyncClient() as client:
        response = await client.post(f"{CASDOOR_URL}/api/login/oauth/access_token", data={
            "grant_type": "password", "client_id": CLIENT_ID, "client_secret": CLIENT_SECRET,
            "username": "test-domain-configurator", "password": "test123", "scope": "openid profile",
        })
        return response.json()["access_token"]

@pytest_asyncio.fixture(scope="function")
async def client(test_db):
    from src.tools import db as db_module
    db_module.engine = test_db      # Override engine singleton — all repo calls use test DB
    async with httpx.AsyncClient(transport=httpx.ASGITransport(app=app), base_url="http://test") as ac:
        yield ac

@pytest_asyncio.fixture(scope="function")
async def mcp_client(test_db, clean_table):
    from fastmcp import Client
    from src.modules.{domain} import repo as repo_module
    from src.modules.{domain}.mcp_server import mcp
    from src.tools import db as db_module
    db_module.engine = test_db
    repo_module  # ensure import so engine reference is live
    async with Client(mcp) as c:
        yield c
```

### Required Test Files

- `test_create.py`: success (201), duplicate → 409, validation failure → 422, 401 without token, 403 wrong role, `created_by` from JWT
- `test_get.py`: success (200), not-found → 404
- `test_list.py`: no filters (returns all), with filters (filtered result)
- `test_update.py`: success (version incremented), not-found → 404
- `test_constraints.py`: DB-level constraint violations
- `test_resolve.py`: match found, no match → 404
- `test_mcp_tools.py`: create, update (via `set_*`), delete, resolve, list
- `test_auth.py`: 401 without token, 403 wrong role
