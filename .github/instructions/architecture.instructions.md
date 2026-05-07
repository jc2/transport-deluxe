---
description: "Use when creating, maintaining or reviewing local services (workflows or configurations) in the transport-deluxe monorepo. Covers architecture rules, directory structure, HTTP communication and testing requirements."
---
# Transport-Deluxe Architecture — Non-Negotiables

Two service types live in `local_services/`: **configuration services** and **workflow engines**.
For implementation conventions, load the relevant instruction:
- Configuration services → `configuration-service.instructions.md`
- Workflow engines → `workflow-engine.instructions.md`

## Monorepo Rules
- Each service is completely self-contained with its own `pyproject.toml` and `Dockerfile`.
- Cross-service imports are **forbidden**. Duplicate shared code; never import across services.

## Communication Stack
- All outbound HTTP MUST use `httpx` in async mode (`async with httpx.AsyncClient()`).
- All databases MUST use **SQLModel** with **asyncpg**. No synchronous DB access.

## Error Contract
- Endpoints MUST NOT return HTTP 500. All failure paths must be explicitly handled.
- Every error response MUST use: `{"status": 4xx, "messages": ["..."]}`
- `created_by` / `updated_by` is always derived from the JWT `name`/`preferred_username` claim — never from request headers or body.

## Persistence & Docker
- All persistent data lives at `persistence/{component-name}/{data-type}/` in the monorepo root.
- Docker services MUST bind-mount that directory. Named and anonymous volumes are forbidden.

## Code Style
- Docstrings are **prohibited**. Code must be self-explanatory.
- Inline comments are allowed only to explain **why**, never what.

## Testing
- Integration tests only (no unit tests). One test per endpoint use case, happy path.
- Always clean the test database between tests using `yield` / `finally`.
- Tests run inside Docker via `make test`. Never run tests locally.
