# Implementation Plan: User Authentication and Authorization

**Branch**: `001-user-auth-authz` | **Date**: 2026-04-23 | **Spec**: [spec.md](spec.md)
**Input**: Feature specification from `specs/001-user-auth-authz/spec.md`
**Updated**: 2026-04-23 — architectural revision: Casdoor is the sole auth service; no custom Python auth-service is built.

---

## Summary

Deploy Casdoor as a self-hosted OAuth 2.0 / OIDC identity provider via Docker Compose. Casdoor issues JWTs directly to clients using the Resource Owner Password Credentials (ROPC) grant. No custom Python auth-service is created. Downstream Python services (future) will verify Casdoor-issued JWTs using Casdoor's JWKS endpoint. A CLI test script in `scripts/get_token.py` lets developers generate tokens for all three roles without manual browser interaction.

---

## Technical Context

**Language/Version**: Python 3.14+ (test script only)
**Primary Dependencies**: httpx (test script CLI call), Casdoor (Docker IdP, `casbin/casdoor:latest`)
**Storage**: Casdoor-managed PostgreSQL (`casdoor-db`) — no custom schema created by this feature
**Testing**: Manual validation — `docker compose up`, `python scripts/get_token.py <role>`
**Target Platform**: Linux server, Docker / Docker Compose
**Project Type**: Infrastructure configuration (Docker Compose + seed data + CLI script)
**Constraints**: RS256 JWT (Casdoor-managed RSA keys); JWKS at `http://localhost:8000/.well-known/jwks`
**Scale/Scope**: POC — small development team, no concurrent load target

---

## Constitution Check

Only the principles directly applicable to infrastructure-only changes are evaluated:

- [x] Root `README.md` updated with Casdoor admin URL and port table (Principle VII) — `http://localhost:8000`, default credentials `admin`/`123`
- [x] `docker-compose.yml` updated with `casdoor` and `casdoor-db` services with dependencies declared (Principle VIII)
- [x] Casdoor volume bind-mounted to `persistence/casdoor/postgres/` with `.gitkeep` (Principle XI)
- [N/A] Principles I, II, III, IV, V, VI, IX, X — no Python sub-project is created; not applicable

**Constitution Check: PASS.**

---

## Project Structure

### Documentation (this feature)

```text
specs/001-user-auth-authz/
├── spec.md              # Feature specification
├── plan.md              # This file
├── research.md          # Phase 0 output
├── data-model.md        # Phase 1 output — JWT structure, role table, verification pattern
├── quickstart.md        # Phase 1 output
├── contracts/
│   └── auth-api.md      # Casdoor endpoints + downstream verification pattern
└── tasks.md             # Phase 2 output (/speckit.tasks command)
```

### Files Created / Modified (repository root)

```text
docker-compose.yml            # MODIFIED — add casdoor + casdoor-db services
casdoor/
└── init_data.json            # NEW — seed: app config, 3 test users, 2 roles, 24h token lifetime
scripts/
└── get_token.py              # NEW — CLI: python scripts/get_token.py <role>
persistence/
└── casdoor/
    └── postgres/
        └── .gitkeep          # NEW — bind-mount anchor (Principle XI)
README.md                     # MODIFIED — add Casdoor admin URL, port index entry
```

---

## Docker Compose additions (root `docker-compose.yml`)

```yaml
services:
  casdoor-db:
    image: postgres:16
    environment:
      POSTGRES_DB: casdoor
      POSTGRES_USER: casdoor
      POSTGRES_PASSWORD: casdoor
    volumes:
      - ./persistence/casdoor/postgres/data:/var/lib/postgresql/data

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

## Key Technical Decisions

| Decision | Choice | Rationale |
|---|---|---|
| IdP | Casdoor (Docker) | OAuth 2.0 / OIDC compliant, self-hosted, built-in admin console |
| Auth flow | ROPC (password grant) | Username + password without browser redirect; suitable for POC/CLI |
| Token issuer | Casdoor directly | No custom Python service needed; simplifies architecture |
| JWT algorithm | RS256 (Casdoor-managed) | Asymmetric; downstream services verify without signing secret |
| Role claim | `roles` array in Casdoor JWT | Native Casdoor claim; no scope-mapping logic needed |
| Downstream auth | Stateless JWKS verification | No introspection call at request time; verifiable offline |
| Token lifetime | 24 h (set in Casdoor app config) | POC UX; tighten before production |
| Refresh tokens | None (POC) | Explicit POC simplification |
| Blacklist / revocation | None (POC) | Casdoor session-based logout; no stateful blacklist required for POC |

---

## Post-Constitution Check (Post-Design)

- `persistence/casdoor/postgres/.gitkeep` created — Principle XI satisfied.
- Root `README.md` updated with Casdoor admin URL and port entry — Principle VII satisfied.
- `scripts/get_token.py` is monorepo tooling, not a sub-project. Principle I not applicable.
- No custom database schema; Principle IX not applicable.
- Downstream JWT verification pattern documented in `data-model.md` and `contracts/auth-api.md` for future Python service authors.

**Post-design check: PASS.**
