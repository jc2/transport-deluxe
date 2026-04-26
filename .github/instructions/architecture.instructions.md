---
description: "Use when creating, maintaining or reviewing local services (workflows or configurations) in the transport-deluxe monorepo. Covers architecture rules, directory structure, HTTP communication and testing requirements."
---
# Transport-Deluxe Architecture Principles

## 1. Monorepo & Local Services
- Services live inside `local_services/` and are grouped into two types: **workflows** and **configurations**.
- Each service is completely independent with its own `pyproject.toml` and `Dockerfile`.
- Cross-service imports are strictly forbidden. You must duplicate or extract shared utilities.

## 2. Layered Architecture
Services under `local_services/` follow one of two structural templates depending on their type:

### A. Configuration Services (e.g., `base_margin_config`)
These provide CRUD operations for configuration entities and use **SQLAdmin** for administration interfaces.
```text
local_services/{service-name}/
├── pyproject.toml
├── src/
│   ├── main.py              # Registers FastAPI app and SQLAdmin views
│   ├── tools/               # Cross-cutting utilities: db.py, logging.py, etc.
│   └── modules/
│       └── {domain}/
│           ├── router.py    # Endpoint declarations
│           ├── models.py    # Pydantic/SQLModel definitions
│           └── service.py   # Standard CRUD service logic
└── tests/
```

### B. Workflow Services
These orchestrate complex business logic using **Apache Hamilton**. They include an additional `steps.py` file to separate logic from execution. Workflow services often call Configuration services or external services.
```text
local_services/{service-name}/
├── pyproject.toml
├── src/
│   ├── main.py
│   ├── tools/               # Cross-cutting utilities: db.py, logging.py, etc.
│   └── modules/
│       └── {domain}/
│           ├── router.py    # Endpoint declaration only — no logic
│           ├── models.py    # Request/response/DB Pydantic/SQLModel models
│           ├── service.py   # Pipeline execution via Apache Hamilton
│           └── steps.py     # Business logic functions (receives/returns Pydantic models)
└── tests/
```
- **Step Constraints:** No classes are allowed in `steps.py`, only modular functions.
- **Workflow Persistence & Tracing:** Workflows MUST include a persistence layer using a `correlation_id` provided in the HTTP headers.
- **Step Auditing:** Each step in the pipeline MUST save a row in the database representing its execution execution. This row MUST include the `correlation_id`, the step's input, and the step's output.
- **Configuration Tracking:** When a step calls a configuration service, the saved execution row MUST record the configuration's `uuid` and `version` to ensure complete traceability.

## 3. Communication & Data
- All outbound HTTP connections MUST use `httpx` in purely asynchronous mode.
- All databases MUST use **SQLModel** with **asyncpg**.
- Store persistence data at the monorepo root: `persistence/{component-name}/{data-type}/`.
- Docker containers in `docker-compose.yml` MUST bind-mount these directories. Named/anonymous volumes are forbidden for persisted data.

## 4. API & Error Contract
- Endpoints MUST NOT return HTTP 500. Handle all failure paths explicitly.
- Errors MUST return a semantically correct HTTP code with the exact schema: `{"status": 4xx, "messages": ["..."]}`
- Include versioning, soft deletes, and audit tracking (driven by JWT token `name` claim, not headers).

## 5. Development & Testing
- Use **pytest** for Integration-Only testing (POC).
- Write exactly **one integration test per use case per endpoint** (external black-box testing over HTTP).
- Always clean up the `_tests` database during tests (use `yield` / `finally` blocks).
- **Code MUST be self-explanatory**: docstrings are prohibited. Inline comments are allowed only to explain *why*.
- Keep `README.md` (root and service-level) short and up-to-date.
