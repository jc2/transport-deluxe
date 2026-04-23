# API Contract: Authentication & Authorization

**Identity Provider**: Casdoor (self-hosted, Docker)
**Casdoor Base URL (local)**: `http://localhost:8000`
**Date**: 2026-04-23
**Updated**: 2026-04-23 — Casdoor is the direct JWT issuer; no custom Python auth service.

There is no custom Python auth-service for this feature. Casdoor exposes all required OAuth 2.0 endpoints natively. This document describes: (1) the Casdoor endpoints clients use, and (2) the pattern downstream Python APIs use to verify tokens.

---

## Casdoor Endpoints (used by clients)

### POST /api/login/oauth/access_token

Authenticate a user with username and password (OAuth 2.0 Resource Owner Password Credentials grant). Returns a Casdoor-signed JWT.

**Request**
```
Content-Type: application/x-www-form-urlencoded

grant_type=password
  &client_id=<CASDOOR_CLIENT_ID>
  &client_secret=<CASDOOR_CLIENT_SECRET>
  &username=alice
  &password=secret
  &scope=openid profile
```

**Success Response — HTTP 200**
```json
{
  "access_token": "<JWT>",
  "token_type": "Bearer",
  "expires_in": 86400
}
```

**Error Responses**

| HTTP | Condition |
|---|---|
| 401 | Invalid credentials |
| 400 | Missing required fields |

---

### POST /api/login/oauth/logout

Invalidate the user's current session in Casdoor.

**Request**
```
Content-Type: application/x-www-form-urlencoded

id_token_hint=<JWT>
```

**Success Response — HTTP 200**

---

### GET /.well-known/jwks

Return Casdoor's public key set in JWKS format. **Downstream Python APIs use this endpoint to verify JWT signatures.**

**Success Response — HTTP 200**
```json
{
  "keys": [
    {
      "kty": "RSA",
      "use": "sig",
      "alg": "RS256",
      "kid": "<key-id>",
      "n": "<base64url modulus>",
      "e": "AQAB"
    }
  ]
}
```

---

### GET /.well-known/openid-configuration

Standard OIDC discovery document. Downstream services can use this to auto-discover all endpoint URLs.

**Success Response — HTTP 200** (standard OIDC metadata document)

---

## Casdoor Admin Console

| Purpose | URL |
|---|---|
| User management (create, deactivate, assign roles) | `http://localhost:8000` |
| Default admin credentials | username: `admin`, password: `123` (change after first login) |

---

## Downstream Python API Authorization Pattern

Every downstream Python service that protects an endpoint MUST implement the following pattern. **No call to Casdoor is required at request time** — verification is stateless using the JWKS public key fetched at service startup (or cached).

### Step-by-step

```python
# 1. At startup: fetch and cache Casdoor's public key
#    GET http://casdoor:8000/.well-known/jwks

# 2. On every protected request:
#    a. Extract Bearer token from Authorization header
#    b. Decode + verify signature using cached JWKS (RS256)
#    c. Check exp > now()
#    d. Check iss == "http://casdoor:8000" (or configured issuer)
#    e. Extract name claim → forward as x-user header (Principle IX)
#    f. Extract roles claim → enforce access per table below
```

### Role Enforcement Table

| `roles` claim | Required for endpoint type | Decision |
|---|---|---|
| contains `"cost-configurator"` | cost configuration | ALLOW |
| contains `"margin-configurator"` | margin configuration | ALLOW |
| empty / no matching role | cost or margin configuration | `{"status": 403, "messages": ["forbidden"]}` |
| empty / no matching role | price prediction | ALLOW |
| no token / invalid token | any | `{"status": 401, "messages": ["unauthorized"]}` |

### Error Response Format (Principle III)

```json
{"status": 401, "messages": ["unauthorized"]}
{"status": 403, "messages": ["forbidden"]}
```

### x-user Header Propagation (Principle IX)

After successful token verification, the downstream service extracts the `name` claim and forwards it as the `x-user` HTTP header on all internal service-to-service calls. This value is recorded in the `created_by` / `edited_by` audit fields of any configuration change.

```python
x_user = token_claims["name"]  # e.g., "alice"
# include in outbound httpx request: headers={"x-user": x_user}
```

---

## Test Credentials (seeded via init_data.json)

| Username | Password | Role | Casdoor roles claim |
|---|---|---|---|
| `test-cost-configurator` | `test123` | Cost Configurator | `["cost-configurator"]` |
| `test-margin-configurator` | `test123` | Margin Configurator | `["margin-configurator"]` |
| `test-predictor` | `test123` | Predictor | `[]` |
