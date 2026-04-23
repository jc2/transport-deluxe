# Data Model: User Authentication and Authorization

**Feature**: 001-user-auth-authz
**Date**: 2026-04-23
**Updated**: 2026-04-23 — revised after architectural clarification: no custom Python auth service; Casdoor issues JWTs directly.

---

## Persistence

**No custom database for this feature.** Casdoor manages all identity-related persistence in its own PostgreSQL database (`casdoor-db`). No custom schema is created by this feature.

---

## External Entity: Casdoor User (owned by Casdoor)

The system does not persist user data. User identity lives entirely in Casdoor. The following describes what is stored in Casdoor and how it surfaces in JWTs:

| Attribute | Casdoor field | Appears in JWT as |
|---|---|---|
| Username | `name` | `name` claim |
| Display name | `displayName` | `displayName` claim |
| Roles | Casdoor role assignments | `roles` array claim |
| Account status | `isForbidden` flag | login rejected at Casdoor if `true` |

---

## JWT Access Token (Casdoor-issued)

Casdoor signs JWTs with RS256 using its own managed RSA key pair. The public key is available at `GET http://localhost:8000/.well-known/jwks`.

### Header
```json
{
  "alg": "RS256",
  "typ": "JWT"
}
```

### Payload Claims

| Claim | Type | Description |
|---|---|---|
| `sub` | string | Casdoor user ID (`owner/username` format) |
| `name` | string | Username — primary identifier used by downstream services |
| `displayName` | string | Human-readable display name |
| `roles` | array of strings | Casdoor role names assigned to the user (e.g., `["cost-configurator"]`) |
| `iss` | string | Casdoor issuer URL (e.g., `http://localhost:8000`) |
| `iat` | unix timestamp | Issued-at time |
| `exp` | unix timestamp | Expiry (24 hours after `iat` for POC) |
| `jti` | string | JWT ID (issued by Casdoor) |

### Example Payloads

**Cost Configurator**:
```json
{
  "sub": "transport-deluxe/alice",
  "name": "alice",
  "roles": ["cost-configurator"],
  "iss": "http://localhost:8000",
  "iat": 1745000000,
  "exp": 1745086400,
  "jti": "a1b2c3d4-..."
}
```

**Margin Configurator**:
```json
{
  "sub": "transport-deluxe/bob",
  "name": "bob",
  "roles": ["margin-configurator"],
  "iss": "http://localhost:8000",
  "iat": 1745000000,
  "exp": 1745086400,
  "jti": "e5f6a7b8-..."
}
```

**Predictor (no config role)**:
```json
{
  "sub": "transport-deluxe/carol",
  "name": "carol",
  "roles": [],
  "iss": "http://localhost:8000",
  "iat": 1745000000,
  "exp": 1745086400,
  "jti": "c9d0e1f2-..."
}
```

---

## Role Authorization Table

Downstream Python APIs enforce access by checking the `roles` claim:

| `roles` claim contains | Access granted |
|---|---|
| `"cost-configurator"` | Cost configuration endpoints |
| `"margin-configurator"` | Margin configuration endpoints |
| both `"cost-configurator"` and `"margin-configurator"` | Both cost and margin configuration endpoints |
| neither (empty or absent) | Price prediction endpoints only |

---

## Downstream API JWT Verification Pattern

Every downstream Python service that protects an endpoint MUST:

1. Extract `Authorization: Bearer <token>` header.
2. Verify the JWT signature using Casdoor's JWKS: `GET http://casdoor:8000/.well-known/jwks`.
3. Check `exp` is in the future and `iss` matches the expected Casdoor URL.
4. Extract `name` claim — forward as `x-user` header to any internal calls (Principle IX audit trail).
5. Extract `roles` claim — enforce access per the Role Authorization Table above.
6. On any verification failure → `{"status": 401, "messages": ["unauthorized"]}`.
7. On missing required role → `{"status": 403, "messages": ["forbidden"]}`.

---

## Token Lifecycle

```
[Client] ──POST /api/login/oauth/access_token──▶ [Casdoor]
                                                      │
                                              Returns signed JWT
                                                      ▼
[Client] ──Bearer JWT──▶ [Downstream API] ──verify sig via JWKS──▶ [Casdoor JWKS]
                                │
                         check exp + iss + roles
                                │
                     ┌──────────┴──────────┐
                  Valid                  Invalid/Expired
                     │                        │
               Proceed                   401 Unauthorized

[Client] ──POST /api/login/oauth/logout──▶ [Casdoor] (invalidates session)
```
