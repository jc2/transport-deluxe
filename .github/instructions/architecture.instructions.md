---
description: "Use when creating, maintaining or reviewing local services (workflows or configurations) in the transport-deluxe monorepo. Covers architecture rules, directory structure, layer responsibilities, HTTP communication and testing requirements."
---
# Transport-Deluxe Architecture — Non-Negotiables

Two service types live in `local_services/`: **configuration services** and **workflow engines**.
For implementation conventions, load the relevant instruction:
- Configuration services → `configuration-service.instructions.md`
- Workflow engines → `workflow-engine.instructions.md`

## Monorepo Rules
- Each service is completely self-contained with its own `pyproject.toml` and `Dockerfile`.
- Cross-service imports are **forbidden**. Duplicate shared code; never import across services.

## Layer Architecture (Configuration Services)

Every configuration service uses a strict 4-layer architecture. Layers only call downward:

```
router.py / mcp_tools.py  →  service.py  →  repo.py  →  database
```

- **router.py**: Route declarations only. Calls `service.*`. No SQL, no sessions.
- **mcp_tools.py**: MCP tool declarations only. Calls `service.*`. No SQL, no sessions.
- **service.py**: Business logic only. Calls `repo.*`. No SQL, no sessions. Returns DTOs.
- **repo.py**: All SQL. Opens its own sessions via `get_db_session()`. Returns DAOs.

Session management is exclusively in `repo.py`. No `AsyncSession` is passed between layers.

## Models: DAO vs DTO (Configuration Services)

- **DAO** (`models/dao.py`): `SQLModel, table=True` — flat columns matching the DB schema. Also contains Pydantic helper models (Customer, Stop, etc.) shared across layers.
- **DTO** (`models/dto.py`): `pydantic.BaseModel` (NOT SQLModel) — structured request/response objects. The `XxxResponse` DTO provides a `from_dao(row)` classmethod to convert from the flat DAO.
- **`models/__init__.py`**: Re-exports all DAOs and DTOs for clean imports.

## Communication Stack
- All outbound HTTP MUST use `httpx` in async mode (`async with httpx.AsyncClient()`).
- All databases MUST use **SQLModel** with **asyncpg**. No synchronous DB access.

## Error Contract
- Endpoints MUST NOT return HTTP 500. All failure paths must be explicitly handled.
- Every error response MUST use: `{"messages": ["..."]}`
- `created_by` / `updated_by` is always derived from the JWT `preferred_username`/`name` claim — never from request headers or body. Fall back to `jwt["sub"]` if both are missing.
- Domain exceptions (`ConfigNotFoundError`, `DuplicateConfigError`) are defined in `exceptions.py` and converted to HTTP responses by `main.py` exception handlers.

## Persistence & Docker
- All persistent data lives at `persistence/{component-name}/{data-type}/` in the monorepo root.
- Docker services MUST bind-mount that directory. Named and anonymous volumes are forbidden.

## Code Style
- Docstrings are **prohibited** except in MCP tool functions (where the docstring IS the agent-facing description).
- Inline comments are allowed only to explain **why**, never what.

## Testing
- Integration tests only (no unit tests). One test per endpoint use case, happy path.
- Always clean the test database between tests using `yield` / `finally`.
- Tests run inside Docker via `make test`. Never run tests locally.
