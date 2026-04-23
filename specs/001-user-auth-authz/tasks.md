# Tasks: User Authentication and Authorization

**Feature**: 001-user-auth-authz
**Date**: 2026-04-23
**Plan**: [plan.md](plan.md)

Architecture: Casdoor (Docker) as the sole auth service. No custom Python auth-service. No tests. Deliverables are: Docker Compose additions, Casdoor seed data, a CLI test script, and README updates.

---

## [X] T001 — Create persistence volume directory

**Files**: `persistence/casdoor/postgres/.gitkeep`

Create the bind-mount anchor directory for Casdoor's PostgreSQL data. Required by Principle XI.

```bash
mkdir -p persistence/casdoor/postgres
touch persistence/casdoor/postgres/.gitkeep
```

---

## [X] T002 — Create Casdoor init_data.json

**Files**: `casdoor/init_data.json`

Create the Casdoor seed file. Must configure:
- Application named `transport-deluxe` with client ID, client secret, redirect URIs, and token lifetime of 86400 seconds (24 h)
- Organization named `transport-deluxe`
- 3 test users: `test-cost-configurator`, `test-margin-configurator`, `test-predictor` (all with password `test123`)
- 2 roles: `cost-configurator`, `margin-configurator`
- Role assignments: `test-cost-configurator` → `cost-configurator`; `test-margin-configurator` → `margin-configurator`; `test-predictor` → no role

Reference: [Casdoor init_data docs](https://casdoor.org/docs/basic/init-data).

---

## [X] T003 — Add casdoor-db service to docker-compose.yml

**Files**: `docker-compose.yml`

Add the `casdoor-db` PostgreSQL service:

```yaml
casdoor-db:
  image: postgres:16
  environment:
    POSTGRES_DB: casdoor
    POSTGRES_USER: casdoor
    POSTGRES_PASSWORD: casdoor
  volumes:
    - ./persistence/casdoor/postgres/data:/var/lib/postgresql/data
```

---

## [X] T004 — Add casdoor service to docker-compose.yml

**Files**: `docker-compose.yml`

Add the `casdoor` service, depending on `casdoor-db`:

```yaml
casdoor:
  image: casbin/casdoor:latest
  ports:
    - "8000:8000"
  depends_on:
    - casdoor-db
  environment:
    - driverName=postgres
    - dataSourceName=host=casdoor-db user=casdoor password=casdoor dbname=casdoor port=5432 sslmode=disable
  volumes:
    - ./casdoor/init_data.json:/init_data.json
```

---

## [X] T005 — Create scripts/get_token.py CLI

**Files**: `scripts/get_token.py`

Python CLI script that calls Casdoor's ROPC endpoint and prints the resulting JWT to stdout. Accepts a positional argument: `cost-configurator`, `margin-configurator`, or `predictor`. Maps argument to the corresponding seeded test user credentials. Uses `httpx` sync — Principle X (async HTTP) applies to sub-projects only; this is a standalone CLI tool and is explicitly exempt.

Usage:
```bash
python scripts/get_token.py cost-configurator
```

Exit code 0 on success, 1 on error. Errors print to stderr.

---

## [X] T006 — Update root README.md

**Files**: `README.md`

Add the following information:
- Port index entry for Casdoor: `8000 — Casdoor (Identity Provider / OAuth 2.0)`
- Section on authentication: Casdoor admin console URL (`http://localhost:8000`), default credentials (`admin` / `123`), and pointer to `scripts/get_token.py`

---

## T007 — (Optional) Document downstream JWT verification guide

**Files**: `docs/jwt-verification.md` or inline in future service READMEs

Extract the downstream JWT verification pattern from `data-model.md` and `contracts/auth-api.md` into a standalone developer guide for future Python API authors. This task is deferred until the first downstream Python service is scaffolded.

---

## Out of Scope / Deferred

The following functional requirements from `spec.md` are **explicitly out of scope** for this feature. They will be implemented when the relevant downstream Python services are scaffolded:

| Requirement | Description |
|---|---|
| FR-008 | Cost Configurator access enforcement |
| FR-009 | Margin Configurator access enforcement |
| FR-010 | Predictor access enforcement |
| FR-011 | Unauthenticated request rejection (401) |
| FR-012 | Expose user identity for audit (`x-user` header propagation) |
| FR-015 | Downstream APIs inspect `roles` claim |

The verification pattern is documented in `data-model.md` and `contracts/auth-api.md` as a reference for those future implementations.
