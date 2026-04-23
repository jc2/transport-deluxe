# Research: User Authentication and Authorization

**Feature**: 001-user-auth-authz
**Date**: 2026-04-23
**Status**: Complete — all NEEDS CLARIFICATION resolved

---

## 1. Casdoor as OAuth 2.0 Identity Provider

### Decision
Use **Casdoor** (open-source, self-hosted) as the identity provider. Casdoor is deployed as a Docker container managed via the project's Docker Compose stack. It is the exclusive owner of user credentials and role assignments.

### Rationale
- Fully OAuth 2.0 and OIDC compliant, satisfying the provider-agnostic constraint (A-008).
- Ships as a Docker image (`casbin/casdoor`), straightforward to add to Docker Compose.
- Built-in admin web console for user and role management (FR-017 — URL: `http://localhost:8000`).
- Supports the **Resource Owner Password Credentials (ROPC)** OAuth 2.0 grant type, which allows username + password authentication without a browser redirect. This is the correct grant type for our machine-to-machine login endpoint.
- Casdoor supports custom roles/groups natively, which can be mapped to canonical OAuth 2.0 scopes at the auth service layer.

### Casdoor ROPC Token Endpoint
```
POST http://localhost:8000/api/login/oauth/access_token
Content-Type: application/x-www-form-urlencoded

grant_type=password&client_id=...&client_secret=...&username=...&password=...&scope=openid profile
```
Returns a Casdoor-issued JWT. The auth service uses this to verify the user's identity and roles, then issues its own canonical JWT.

### Alternatives Considered
- **Auth0**: Cloud-hosted, would introduce an external dependency; ROPC grant is deprecated in newer OAuth 2.0 specs; not freely self-hostable.
- **Keycloak**: Heavier operational footprint; more complex configuration for a POC. Viable migration target.
- **Pure database-backed auth**: Would require the service to own passwords — violates FR-013.

---

## 2. Token Issuance Strategy

### Decision
**Casdoor issues JWTs directly.** No custom Python service is needed to issue tokens. Clients authenticate directly against Casdoor's OAuth 2.0 ROPC token endpoint and receive a Casdoor-signed JWT. Downstream Python APIs receive this JWT and verify it using Casdoor's public JWKS endpoint — no proxy, no wrapper service.

### Rationale
- Casdoor is a fully compliant OAuth 2.0 / OIDC server that natively handles: token issuance, RS256 JWT signing, JWKS key publication, and logout.
- Building a custom Python auth-service that proxies Casdoor would add an unnecessary service, an extra database, extra code, and extra deployment complexity — all for behaviour Casdoor already provides out of the box.
- Downstream services need only: (1) verify the JWT signature via Casdoor's JWKS endpoint, (2) check the `roles` claim. Both are trivial operations with any standard JWT library.
- The architecture remains provider-agnostic at the *verification* level: if Casdoor is swapped, only the JWKS URL changes in downstream configuration — no code changes.

### Casdoor Token Endpoint (ROPC)
```
POST http://localhost:8000/api/login/oauth/access_token
Content-Type: application/x-www-form-urlencoded

grant_type=password&client_id=CLIENT_ID&client_secret=CLIENT_SECRET
  &username=alice&password=secret&scope=openid profile
```
Returns a Casdoor-issued JWT directly to the client.

### Alternatives Considered
- **Custom Python auth-service proxying Casdoor**: Adds complexity with no functional benefit for a POC — Casdoor already provides everything needed. Rejected.
- **Token exchange (RFC 8693)**: More complex, not necessary for a POC. Rejected.

---

## 3. JWT Revocation / Logout

### Decision
Logout is handled by Casdoor's native logout endpoint. No custom blacklist database is required. For the POC (long-lived tokens, A-004), clients additionally discard the token locally on logout. Casdoor's `POST /api/login/oauth/logout` invalidates the session on the server side.

### Rationale
- No custom Python service → no custom blacklist database. Casdoor manages all token state natively.
- For the POC context (small team, long-lived tokens, no high-security SLA), relying on Casdoor's built-in revocation is sufficient. The edge case of a stolen token being used after logout is accepted as a POC risk.
- When upgrading to production, short-lived tokens (e.g., 15 min) + refresh tokens reduce the revocation window to an acceptable level without a custom blacklist.

### Downstream API Behaviour
Downstream Python APIs perform **stateless JWT verification only**: verify the signature against Casdoor's JWKS endpoint and check `exp`. They do NOT call any introspection endpoint. This is acceptable for the POC because the token lifetime is the primary revocation mechanism.

### Alternatives Considered
- **Custom PostgreSQL blacklist in a Python service**: Over-engineered for a POC — adds a full service + database. Rejected.
- **Short-lived tokens**: Better security posture, but contradicts A-004 (POC UX decision). Deferred to production.

---

## 4. Role Claim in Casdoor's JWT

### Decision
Casdoor is configured (via `init_data.json`) to include the user's roles as a `roles` array in the JWT payload. Downstream Python APIs check `token["roles"]` directly. The canonical role names are Casdoor's own role names: `cost-configurator` and `margin-configurator`. Any authenticated user without either role is a Predictor.

| Casdoor Role Name | Access granted by downstream API |
|---|---|
| `cost-configurator` | Cost configuration endpoints |
| `margin-configurator` | Margin configuration endpoints |
| *(no role)* | Price prediction endpoints only |

### Rationale
- Since there is no custom auth-service to perform scope mapping, downstream APIs read Casdoor's `roles` claim directly. This is simpler and equally correct.
- The `scope` claim approach (A-009 from clarifications) assumed a custom service performing the mapping. Without that service, using Casdoor's `roles` claim is the natural equivalent.
- A-009 is superseded: downstream APIs check `roles` contains `"cost-configurator"` or `"margin-configurator"` rather than checking a `scope` string.

### Conflict Detection
Casdoor can be configured to enforce mutual exclusivity of roles at the admin console level. The `init_data.json` seed data assigns each test user exactly one role. If a user somehow has both roles, downstream APIs MUST deny access with 403 (the expected enforcement is that Casdoor admin console prevents conflicting assignment).

---

## 5. RSA Key Pair for JWT Signing

### Decision
Casdoor manages its own RSA key pair for JWT signing. The public key is published by Casdoor at `GET http://localhost:8000/.well-known/jwks`. Downstream Python APIs fetch this endpoint at startup (or on first request) to retrieve the public key for JWT verification. No custom key management is needed.

### Rationale
- Casdoor ships with a built-in RSA key pair generated at first startup. It handles key storage and publication automatically.
- Downstream services use any standard JWT library (e.g., `python-jose`, `PyJWT`) to verify the signature against the fetched JWKS — this is the standard OAuth 2.0 verification pattern.
- No private key is ever handled by application code.

### Key Rotation
Deferred to post-POC. Casdoor supports key rotation via its admin console.

---

## 6. Test JWT CLI Script

### Decision
A Python CLI script at `scripts/get_token.py`. Usage:

```bash
python scripts/get_token.py cost-configurator
python scripts/get_token.py margin-configurator
python scripts/get_token.py predictor
```

### Rationale
- Python is the project's primary language (consistent with constitution tech stack).
- The script calls **Casdoor's ROPC token endpoint directly** (`POST http://localhost:8000/api/login/oauth/access_token`) using `httpx` (sync is acceptable in a CLI script) with pre-seeded test user credentials.
- Prints the raw Casdoor JWT to stdout so it can be piped directly into API calls: `curl -H "Authorization: Bearer $(python scripts/get_token.py cost-configurator)" http://localhost:8001/...`
- Casdoor initial data is seeded via its built-in `init_data.json` mechanism at container startup, ensuring test users exist without any manual console setup.

---

## 7. Docker Compose and Volume Layout

### Decision
Two services added to `docker-compose.yml`: `casdoor` and `casdoor-db`. No `auth-service` or `auth-db` — those do not exist.

```yaml
# docker-compose.yml additions
services:
  casdoor:
    image: casbin/casdoor:latest
    ports: ["8000:8000"]
    depends_on: [casdoor-db]
    volumes:
      - ./casdoor/init_data.json:/init_data.json  # seeds app, users, roles
    environment: [driverName=postgres, dataSourceName=...]

  casdoor-db:
    image: postgres:16
    volumes:
      - ./persistence/casdoor/postgres/data:/var/lib/postgresql/data
```

### Volume Paths (Principle XI)
```
persistence/
└── casdoor/
    └── postgres/
        └── .gitkeep
```

---

## 8. Token Lifetime (POC)

### Decision
Casdoor access token lifetime: **24 hours** (POC default). Configurable in Casdoor's application settings via the admin console or `init_data.json`.

### Rationale
- Long enough that developers are not interrupted mid-session during a POC sprint.
- Configurable so it can be tightened before production without code changes.
