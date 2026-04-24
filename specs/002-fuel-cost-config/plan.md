# Implementation Plan: Fuel Cost Configuration Service

**Branch**: `002-fuel-cost-config` | **Date**: 2026-04-23 | **Spec**: [spec.md](spec.md)
**Input**: Feature specification from `specs/002-fuel-cost-config/spec.md`

---

## Summary

Build a standalone FastAPI sub-project (`fuel_cost_config/`) that manages versioned fuel cost configurations used by the price estimation engine. The service exposes 6 endpoints: 5 authenticated management endpoints (list with pagination+filtering, get by UUID, create, update-as-new-version, soft-delete) and 1 unauthenticated resolution endpoint that accepts a Load and returns the best-matching active configuration via a 3-level specificity hierarchy. Persistence uses PostgreSQL 16 with SQLModel + asyncpg. JWT verification uses Casdoor JWKS. No external HTTP calls are made by this service.

---

## Technical Context

**Language/Version**: Python 3.14+
**Primary Dependencies**: FastAPI, SQLModel, asyncpg, alembic, python-jose[cryptography]
**Storage**: PostgreSQL 16 — database `fuel_cost_config` (prod) / `fuel_cost_config_tests` (tests)
**Testing**: pytest — integration only, external/black-box, against `_tests` DB
**Target Platform**: Linux server via Docker Compose
**Project Type**: Monorepo sub-project (web service)
**Port**: 8001
**Constraints**: No 500s; uniform error format `{status, messages}`; all DB ops async; soft delete only; atomic transactions for update and deactivate
**Scale/Scope**: POC — small team, no concurrent load target

---

## Constitution Check

- [x] Sub-project has its own `pyproject.toml` and no imports from other sub-projects (Principle I)
- [x] Directory layout matches `src/main.py`, `src/tools/`, `src/modules/{domain}/` (Principle II)
- [x] Each module has `router.py`, `models.py`, `service.py` (Principle II) — **see violation below**
- [⚠️] Apache Hamilton NOT used — see Complexity Tracking (Principle II violation, justified)
- [x] All endpoints declare explicit HTTP error codes — no 500s, uniform `{status, messages}` format (Principle III)
- [x] Every handler has logging wired at appropriate levels (Principle IV)
- [x] Tests are integration-only, external/black-box, one per use case, against `_tests` DB (Principle V)
- [x] No docstrings anywhere in the sub-project (Principle VI)
- [x] Sub-project has a `README.md` with service description and one entry per module (Principle VII)
- [x] Root `README.md` updated with this sub-project's name, purpose, and port (Principle VII)
- [x] Sub-project added to root `docker-compose.yml` with dependencies declared (Principle VIII)
- [x] `docker-compose.test.yml` updated so tests can run in full-stack mode (Principle VIII)
- [x] All DB interaction uses fully async SQLModel + asyncpg, with soft deletes, versioning, and JWT-claim auditing (Principle IX)
- [x] No outbound HTTP calls needed — Principle X is N/A for runtime. JWT JWKS fetch at startup uses httpx async (Principle X)
- [x] No Docker volumes with data for this service — DB is in the shared `fuel-cost-config-db` service (Principle XI)
- [x] Tech stack: Python + FastAPI + SQLModel/asyncpg + PostgreSQL + httpx + Docker

**Constitution Check: CONDITIONAL PASS** — one justified violation documented below.

---

## Complexity Tracking

| Violation | Why Needed | Simpler Alternative Rejected Because |
|-----------|------------|-------------------------------------|
| No Apache Hamilton (`steps.py` absent) | This service has no DAG pipeline. All 6 use cases are linear: validate → query/mutate DB → respond. No step produces outputs consumed by other steps within the same request. | Forcing Hamilton would add a DAG framework with zero operational benefit and significant boilerplate. Plain `async def` functions in `service.py` are simpler, equally testable, and correct for this use case. |

---

## Project Structure

### Documentation (this feature)

```text
specs/002-fuel-cost-config/
├── plan.md              ← this file
├── spec.md
├── research.md
├── data-model.md
├── quickstart.md
├── contracts/
│   └── fuel-cost-api.md
└── checklists/
    └── requirements.md
```

### Source Code

```text
fuel_cost_config/
├── pyproject.toml
├── README.md
├── Dockerfile
├── src/
│   ├── main.py                          # FastAPI app, lifespan, exception handlers, router include
│   ├── tools/
│   │   ├── db.py                        # Async engine, session dependency
│   │   └── auth.py                      # JWT verification dependency, user identity extracted from JWT claims
│   └── modules/
│       └── fuel_cost_config/
│           ├── router.py                # 6 endpoint declarations, delegates to service
│           ├── models.py                # SQLModel DB table, request/response Pydantic models, TruckType enum
│           └── service.py              # All business logic: list, get, create, update, deactivate, resolve
└── tests/
    ├── conftest.py                      # DB setup/teardown, HTTP client fixture, auth token fixture
    ├── test_list.py
    ├── test_get.py
    ├── test_create.py
    ├── test_update.py
    ├── test_deactivate.py
    └── test_resolve.py
```

**No `steps.py`** — see Complexity Tracking above.

---

## Docker Compose additions

### `docker-compose.yml` (additions to root file)

```yaml
services:
  fuel-cost-config-db:
    image: postgres:16
    environment:
      POSTGRES_DB: fuel_cost_config
      POSTGRES_USER: fuel_cost_config
      POSTGRES_PASSWORD: fuel_cost_config
    volumes:
      - ./persistence/fuel-cost-config-db/postgres:/var/lib/postgresql/data
    healthcheck:
      test: ["CMD-SHELL", "pg_isready -U fuel_cost_config -d fuel_cost_config"]
      interval: 5s
      timeout: 5s
      retries: 10

  fuel-cost-config:
    build: ./fuel_cost_config
    ports:
      - "8001:8001"
    depends_on:
      fuel-cost-config-db:
        condition: service_healthy
      casdoor:
        condition: service_healthy
    environment:
      DATABASE_URL: postgresql+asyncpg://fuel_cost_config:fuel_cost_config@fuel-cost-config-db/fuel_cost_config
      CASDOOR_JWKS_URL: http://casdoor:8000/.well-known/jwks
      CASDOOR_ISSUER: http://localhost:8000
```

### `docker-compose.test.yml` (test profile)

```yaml
services:
  fuel-cost-config-test-db:
    image: postgres:16
    environment:
      POSTGRES_DB: fuel_cost_config_tests
      POSTGRES_USER: fuel_cost_config
      POSTGRES_PASSWORD: fuel_cost_config
    volumes:
      - ./persistence/fuel-cost-config-test-db/postgres:/var/lib/postgresql/data
    healthcheck:
      test: ["CMD-SHELL", "pg_isready -U fuel_cost_config -d fuel_cost_config_tests"]
      interval: 5s
      timeout: 5s
      retries: 10

  fuel-cost-config-tests:
    build: ./fuel_cost_config
    command: pytest tests/ -v
    depends_on:
      fuel-cost-config-test-db:
        condition: service_healthy
      casdoor:
        condition: service_healthy
    environment:
      DATABASE_URL: postgresql+asyncpg://fuel_cost_config:fuel_cost_config@fuel-cost-config-test-db/fuel_cost_config_tests
      CASDOOR_JWKS_URL: http://casdoor:8000/.well-known/jwks
      CASDOOR_ISSUER: http://localhost:8000
    profiles:
      - test
```

---

## Key Design Decisions (summary — full rationale in research.md)
- **UI Management:** Use SQLAdmin integrated with FastAPI to provide a web interface for managing the Fuel Cost Configuration resource.


| Decision | Choice |
|----------|--------|
| CRUD library | None — manual SQLModel + asyncpg |
| Pipeline framework | None — plain async functions in `service.py` |
| Version history endpoint | list endpoint with `uuid` + `include_inactive=true` params |
| Active uniqueness | PostgreSQL partial unique index on `(COALESCE(customer_name,''), COALESCE(customer_subname,''), truck_type)` WHERE `is_active=TRUE` — DB columns match API: `customer_name`, `customer_subname` |
| Resolution strategy | Single SQL query with `CASE`-based priority ordering, `LIMIT 1` |
| Concurrency safety | PostgreSQL atomic transactions (update + deactivate guard) |
| JWT auth | `python-jose[cryptography]`, RS256, Casdoor JWKS |
| Audit field source | JWT `name` claim → `created_by` column |

---

## Database Schema (summary — full detail in data-model.md)

```sql
CREATE TABLE fuel_cost_config (
    uuid             UUID            NOT NULL,
    version          INTEGER         NOT NULL,
    customer_name    VARCHAR(255),
    customer_subname VARCHAR(255),
    truck_type       VARCHAR(50)     NOT NULL,
    fuel_cost_per_km NUMERIC(10, 4)  NOT NULL,
    is_active        BOOLEAN         NOT NULL DEFAULT TRUE,
    created_by       VARCHAR(255)    NOT NULL,
    created_at       TIMESTAMPTZ     NOT NULL DEFAULT NOW(),
    PRIMARY KEY (uuid, version)
);

CREATE UNIQUE INDEX uq_fcc_active_combination
    ON fuel_cost_config (COALESCE(customer_name, ''), COALESCE(customer_subname, ''), truck_type)
    WHERE is_active = TRUE;

CREATE INDEX idx_fcc_lookup   ON fuel_cost_config (customer_name, customer_subname, truck_type, is_active);
CREATE INDEX idx_fcc_uuid     ON fuel_cost_config (uuid, is_active);
CREATE INDEX idx_fcc_sort     ON fuel_cost_config (created_at DESC);
```

---

## API Surface (summary — full detail in contracts/fuel-cost-api.md)

| # | Method | Path | Auth | Description |
|---|--------|------|------|-------------|
| 1 | GET | `/fuel-cost-configs` | Cost Configurator | List with pagination + filters |
| 2 | GET | `/fuel-cost-configs/{uuid}` | Cost Configurator | Get latest active version |
| 3 | POST | `/fuel-cost-configs` | Cost Configurator | Create (version 1) |
| 4 | PUT | `/fuel-cost-configs/{uuid}` | Cost Configurator | Update (new version, atomic) |
| 5 | DELETE | `/fuel-cost-configs/{uuid}` | Cost Configurator | Soft delete (atomic guard) |
| 6 | POST | `/fuel-cost-configs/resolve` | **None** | Resolve best match for Load |

---

## Integration Test Coverage (one per use case)

| File | Scenario |
|------|----------|
| `test_list.py` | List returns paginated active configs; filter by truck_type; filter by customer_name; history view via `include_inactive=true` |
| `test_get.py` | Get returns active version; 404 for deactivated |
| `test_create.py` | Create System / Customer Name / Customer Subname; 409 on duplicate; 400 on invalid fuel_cost |
| `test_update.py` | Update creates new version and deactivates old; 404 on missing UUID |
| `test_deactivate.py` | Deactivate removes from active list; 400 when last system baseline; record still in history |
| `test_resolve.py` | Customer Subname wins over Customer Name; Customer Name wins over System; System fallback; 400 when no match |

### SQLAdmin UI Configuration Details
- **View Configuration (ModelView):** Create a ModelView for `FuelCostConfig` displaying key fields (`uuid`, `version`, `customer_name`, `customer_subname`, `truck_type`, `fuel_cost_per_km`, `is_active`, `created_by`, `created_at`).
- **Authentication (Admin Backend):** Secure the `/admin` interface using SQLAdmin's `AuthenticationBackend` integrated with the existing Casdoor verification (e.g. valid JWT in cookie/headers, enforcing the specific role/access level needed for Fuel Cost config management).
- **Search & Filter:** Enable search and column filters for `customer_name`, `customer_subname`, `truck_type`, and `is_active`.
