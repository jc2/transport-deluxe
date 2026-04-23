# Quickstart: User Authentication and Authorization

**Feature**: 001-user-auth-authz
**Date**: 2026-04-23
**Updated**: 2026-04-23 — Casdoor is the sole auth service; no custom Python auth-service.

---

## Prerequisites

- Docker and Docker Compose installed and running
- Python 3.14+ (for the test token script)
- `httpx` installed: `pip install httpx` (or `uv add httpx`)

---

## Start the Stack

```bash
docker compose up -d
```

This starts:
- **Casdoor** (identity provider + JWT issuer) at `http://localhost:8000`
- **PostgreSQL** for Casdoor at port `5434`

---

## Casdoor Admin Console

Open `http://localhost:8000` in your browser.

Default admin credentials (change after first login):
- **Username**: `admin`
- **Password**: `123`

From the console you can:
- Create and deactivate users
- Assign roles (`cost-configurator`, `margin-configurator`)
- Inspect issued tokens

---

## Get a Test Token

Use the CLI script to generate a JWT for any role:

```bash
# Cost Configurator
python scripts/get_token.py cost-configurator

# Margin Configurator
python scripts/get_token.py margin-configurator

# Predictor (no config role)
python scripts/get_token.py predictor
```

The JWT is printed to stdout. Copy it for use with any downstream API.

---

## Test Authentication Manually

**Login via Casdoor ROPC** (what the script does internally):
```bash
curl -X POST http://localhost:8000/api/login/oauth/access_token \
  -H "Content-Type: application/x-www-form-urlencoded" \
  -d "grant_type=password&client_id=<CLIENT_ID>&client_secret=<CLIENT_SECRET>&username=test-cost-configurator&password=test123&scope=openid"
```

**Fetch Casdoor's public key (JWKS)** — used by downstream services to verify tokens:
```bash
curl http://localhost:8000/.well-known/jwks
```

**Logout via Casdoor**:
```bash
curl -X POST http://localhost:8000/api/login/oauth/logout \
  -d "id_token_hint=$TOKEN"
```

---

## Verify Token Roles

Decode the JWT payload (it is base64url-encoded, not encrypted):

```bash
TOKEN=$(python scripts/get_token.py cost-configurator)
echo $TOKEN | cut -d. -f2 | base64 -d 2>/dev/null | python -m json.tool
```

Expected for `cost-configurator`:
```json
{
  "sub": "transport-deluxe/test-cost-configurator",
  "name": "test-cost-configurator",
  "roles": ["cost-configurator"],
  "iss": "http://localhost:8000",
  "exp": 1745086400
}
```

---

## Seed Users Reference

| Username | Password | Role claim |
|---|---|---|
| `test-cost-configurator` | `test123` | `["cost-configurator"]` |
| `test-margin-configurator` | `test123` | `["margin-configurator"]` |
| `test-predictor` | `test123` | `[]` |


Tests run against the `transport_tests` database and clean up after themselves.

---

## Public Key (JWKS)

Retrieve the auth service's public key for JWT verification:
```bash
curl http://localhost:8001/auth/.well-known/jwks
```
