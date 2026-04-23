<!--
SYNC_IMPACT_REPORT
Version change: 1.2.0 → 1.3.0
Modified principles:
  - II. Layered Architecture: updated to include `steps.py` for Apache Hamilton and removing traditional OOP `service.py`.
Added principles:
  - IX. Data Persistence and Auditing: requires SQLModel, asyncpg, soft deletes, versioning, and x-user tracking.
  - X. Async HTTP Communications: requires httpx in async mode for all HTTP.
Added sections: none
Removed sections: none
Templates updated:
  - .specify/templates/plan-template.md ✅ added checks for IX, X, updated II and Tech Stack
  - .specify/templates/tasks-template.md ✅ no changes needed
  - .specify/templates/spec-template.md ✅ no changes needed
Deferred TODOs: none
-->

# transport-deluxe Constitution

## Core Principles

### I. Monorepo Modularity

Each sub-project lives in its own top-level directory and MUST be completely independent.
Every sub-project has its own `pyproject.toml`. Cross-sub-project imports are forbidden.
Shared utilities MUST be duplicated or extracted into a dedicated versioned package — never
referenced directly across sub-project boundaries.

### II. Layered Architecture

Every sub-project MUST follow this directory structure:

```
{project-name}/
├── pyproject.toml
├── src/
│   ├── main.py
│   ├── tools/               # Cross-cutting utilities: db.py, logging.py, etc.
│   └── modules/
│       └── {domain}/
│           ├── router.py    # Endpoint declaration only — no logic
│           ├── models.py    # Request/response/DB models and serialization
│           ├── service.py   # Pipeline execution via Apache Hamilton
│           └── steps.py     # All business logic steps implemented as functions
└── tests/
```

Each layer has a single, non-negotiable responsibility:

- `router.py` declares endpoints and delegates immediately to the service. No logic here.
- `service.py` acts strictly as the Apache Hamilton pipeline executor orchestrating `steps.py`.
- `steps.py` MUST contain all business logic. No classes allowed for processing logic. Each step MUST be a modular function. Every step MUST receive Pydantic models as input and return Pydantic models as output.
- `models.py` defines all data contracts: request bodies, responses, SQLModel ORM models.
- `tools/` holds cross-cutting utilities (DB session, structured logger). No domain logic.

### III. Uniform Error Contract

No endpoint MUST ever return HTTP 500. All errors MUST return a semantically correct HTTP code.
Every error response MUST conform exactly to:

```json
{"status": 4xx, "messages": ["..."]}
```

Exception handling MUST be explicit and cover all failure paths. An unhandled exception
reaching the framework is a constitution violation. FastAPI exception handlers MUST be
registered to catch any remaining uncaught exceptions and map them to this format.

### IV. Structured Observability

All operations MUST be logged with enough detail to reconstruct what happened without
reading the source code:

- `debug` — granular step-by-step detail inside operations.
- `info` — significant events: requests received, outcomes produced.
- `warning` — recoverable errors: transient failures, expected edge cases, retryable conditions.
- `error` — non-recoverable errors: invalid state, unrecoverable data issues, fatal failures.

No handler completes silently. Logging MUST be wired before a handler is considered done.

### V. Integration-Only Testing (POC)

This is a Proof of Concept. The test strategy is deliberately minimal:

- Tests MUST be implemented with **pytest**.
- One integration test per use case per endpoint. No more, no less.
- Tests are external and black-box: they call the running application over HTTP.
- Tests run against a dedicated `_tests` database (e.g., `transport_tests`).
- No unit tests, no mocks, no contract tests, no test doubles.
- Any test that writes data to the database MUST clean up that data after itself,
  including in unhandled failure scenarios. Use pytest fixtures with `yield` and
  unconditional teardown (e.g., `finally` blocks or autouse fixtures) to guarantee
  cleanup regardless of test outcome.

### VI. Readable Code, No Docstrings

Code MUST be self-explanatory through naming and structure. Docstrings are prohibited.
If code requires a comment to explain *what* it does, it MUST be refactored first.
Inline comments are allowed only to explain *why* a non-obvious decision was made.

### VII. Living README

Two READMEs MUST be maintained and kept current whenever a sub-project is created or changed:

**Sub-project `README.md`** (at `{project-name}/README.md`):

1. **Service description** — one short paragraph: what the service does and its purpose
   in the overall system.
2. **Module descriptions** — one entry per module under `src/modules/`. Each entry states:
   what the module does, what it serves, and how it contributes to the API as a whole.

**Root `README.md`** (at monorepo root):

1. **Monorepo description** — one short paragraph describing the system as a whole.
2. **Sub-project index** — one entry per sub-project: name, one-line purpose, and port.

No installation instructions, no code examples, no badge soup. Brevity is mandatory.

### VIII. Monorepo Orchestration

A single `docker-compose.yml` at the monorepo root MUST register every sub-project and
all shared dependencies (databases, etc.). It is the authoritative way to:

- Launch the entire system locally (`docker compose up`).
- Run all integration test suites together against their `_tests` databases.

Rules:

- Every new sub-project MUST be added to `docker-compose.yml` when it is created.
- Every sub-project service MUST declare its dependencies (e.g., `depends_on: db`).
- A dedicated test profile or override (e.g., `docker-compose.test.yml`) MUST allow
  running all `tests/` suites in isolation against `_tests` databases without
  affecting the production database containers.
- Ports assigned to each service MUST be documented in the root README (Principle VII).

### IX. Data Persistence and Auditing

All database interactions MUST be fully async and use **SQLModel** with **asyncpg**.
Every resource stored in the database MUST include:
- Soft delete pattern.
- Versioning (row versions).
- Auditability: we MUST always record who created and who deleted the entity.
- For now, the acting user is identified from the `x-user` HTTP header; this value MUST be propagated into the database audit fields.

### X. Async HTTP Communications

All outbound HTTP connections MUST use `httpx` in purely asynchronous mode. Synchronous requests are strictly forbidden.

## Technology Stack

The core stack is fixed across all sub-projects. No deviations without amending this constitution:

- **Language**: Python (latest stable)
- **API Framework**: FastAPI
- **Business Logic orchestration**: Apache Hamilton
- **Database**: PostgreSQL with SQLModel and asyncpg
- **HTTP Client**: httpx (async required)
- **Containerization**: Docker — each sub-project ships its own `Dockerfile`
- **Dependency management**: `pyproject.toml` per sub-project (no shared root dependencies)

## Development Workflow

1. Each feature targets a single, self-contained sub-project.
2. Sub-projects MUST be runnable independently via Docker.
3. Logging MUST be wired before a handler is considered complete (Principle IV).
4. The uniform error contract MUST be applied to all endpoints from the first commit (Principle III).
5. Integration tests MUST pass against the `_tests` database before a feature is done (Principle V).
6. Both the sub-project README and the root README MUST be updated before a feature is considered done (Principle VII).
7. The root `docker-compose.yml` MUST be updated to include the new sub-project before it is merged (Principle VIII).

## Governance

This constitution supersedes all other practices. Amendments require:

1. A documented reason for the change.
2. A version bump following semantic versioning:
   - MAJOR: removing or redefining a principle.
   - MINOR: adding a new principle or materially expanding guidance.
   - PATCH: wording clarifications, non-semantic fixes.
3. An updated Sync Impact Report prepended to this file.
4. Review of all dependent templates for consistency.

All implementation plans MUST include a Constitution Check verifying compliance with
principles I–X before work begins.

**Version**: 1.3.0 | **Ratified**: 2026-04-22 | **Last Amended**: 2026-04-23
