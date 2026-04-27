---
name: transport-deluxe-global-rules
description: "Global rules for the Transport Deluxe project. Use when: running Python commands, running tests, adding services, or modifying database logic."
---

# Global Project Rules

Follow these rules consistently across the entire Transport Deluxe workspace.

## Python Execution
- ALWAYS use `uv run python` for any command that executes Python code or scripts.
- Example: `uv run python scripts/get_token.py` instead of `python scripts/get_token.py`.

## Testing
- ALWAYS run tests using Docker Compose, never locally.
- Use the main `Makefile` command `make test` or the specific `docker compose` commands defined in `docker-compose.test.yml`.
- Tests are focused ONLY on "happy path" scenarios. Do not implement complex edge-case testing unless explicitly requested.

## Database & Migrations
- This is a Proof of Concept (POC) project.
- DO NOT create or run database migrations (Alembic or similar).
- Database schemas are handled by the application (e.g., `SQLModel` or `SQLAlchemy`'s `create_all` patterns).

## Adding New Services
When adding a new service to `local_services/`, you MUST update the following files to include the new service:
1. `docker-compose.yml`: Add the service and its database.
2. `docker-compose.test.yml`: Add the test database and test runner service.
3. `Makefile`: Add the test execution step to the `test` target.
4. `pyproject.toml` (root): Add the service as an editable dependency in `[tool.uv.sources]`.
5. `.pre-commit-config.yaml`: Add a new `mypy` hook for the service.
6. `README.md`: Update the "Port Index" and "Admin UI" sections.
