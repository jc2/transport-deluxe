#!/usr/bin/env python3
"""CLI tool to verify a JWT token from Casdoor.

Usage:
    python scripts/verify_token.py <jwt_token>

This script verifies:
- Signature (using the Casdoor JWKS endpoint)
- Issuer (iss)
- Audience (aud)
- Expiration Time (exp)
- Extracts the user's name
- Checks for active valid roles
"""

import sys
from datetime import datetime, timezone
from typing import Any

import httpx
from jose import JWTError, jwt
from jose.exceptions import ExpiredSignatureError, JWTClaimsError

CASDOOR_URL = "http://localhost:8000"
JWKS_URL = f"{CASDOOR_URL}/.well-known/jwks"
CLIENT_ID = "transport-deluxe-client"


def fetch_jwks() -> dict[str, Any]:
    """Fetches the JWKS keys from Casdoor."""
    print(f"Fetching JWKS from {JWKS_URL}...")
    try:
        response = httpx.get(JWKS_URL, timeout=10.0)
        response.raise_for_status()
        data: dict[str, Any] = response.json()
        return data
    except Exception as e:
        print(f"❌ Failed to fetch JWKS: {e}", file=sys.stderr)
        sys.exit(1)


def get_public_key(token: str, jwks: dict[str, Any]) -> dict[str, Any]:
    """Finds the matching public key for the token's signature."""
    try:
        unverified_header = jwt.get_unverified_header(token)
    except JWTError as e:
        print(f"❌ Invalid token format: {e}", file=sys.stderr)
        sys.exit(1)

    kid = unverified_header.get("kid")
    for key in jwks.get("keys", []):
        if key.get("kid") == kid:
            return dict(key)

    print(f"❌ No matching key found in JWKS for kid '{kid}'", file=sys.stderr)
    sys.exit(1)


def main() -> None:
    if len(sys.argv) != 2:
        print("Usage: python scripts/verify_token.py <jwt_token>", file=sys.stderr)
        sys.exit(1)

    token = sys.argv[1]

    jwks = fetch_jwks()
    public_key = get_public_key(token, jwks)

    print("\nVerifying token...")
    try:
        # jwt.decode automatically verifies:
        # 1. Signature (using public_key)
        # 2. Expiration (exp)
        # 3. Issuer (iss)
        # 4. Audience (aud)
        payload = jwt.decode(
            token,
            public_key,
            algorithms=["RS256"],
            issuer=CASDOOR_URL,
            audience=CLIENT_ID,
        )
        print("✅ Signature: Valid")
        print(f"✅ Issuer: {payload.get('iss')} (Valid)")
        print(f"✅ Audience: {payload.get('aud')} (Valid)")

        exp = payload.get("exp")
        if exp:
            exp_time = datetime.fromtimestamp(exp, tz=timezone.utc)
            print(
                f"✅ Expiration Time: {exp_time.strftime('%Y-%m-%d %H:%M:%S UTC')} (Valid and strictly in the future)"
            )

    except ExpiredSignatureError:
        print("❌ Expiration Time: Token has expired", file=sys.stderr)
        sys.exit(1)
    except JWTClaimsError as e:
        print(f"❌ Claims Verification Failed: {e}", file=sys.stderr)
        sys.exit(1)
    except JWTError as e:
        print(f"❌ Signature/Verification Error: {e}", file=sys.stderr)
        sys.exit(1)

    print("\n--- Token Extracted Data ---")

    # Extract Name
    name = payload.get("name", "N/A")
    print(f"👤 Name: {name}")

    # Check Roles
    roles = payload.get("roles", [])
    if not roles:
        print("🔑 Roles: No roles defined in this token.")
    else:
        active_roles = []
        inactive_roles = []

        for role in roles:
            role_name = role.get("name")
            is_enabled = role.get("isEnabled", False)
            if is_enabled:
                active_roles.append(role_name)
            else:
                inactive_roles.append(role_name)

        if active_roles:
            print(f"🔑 Active Roles: {', '.join(active_roles)}")
        else:
            print("🔑 Active Roles: None (Roles are defined, but all are disabled)")

        if inactive_roles:
            print(f"   Inactive Roles: {', '.join(inactive_roles)}")


if __name__ == "__main__":
    main()
