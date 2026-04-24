#!/usr/bin/env python3
"""CLI tool to obtain a JWT from Casdoor for a test user by role.

Usage:
    python scripts/get_token.py cost-configurator
    python scripts/get_token.py margin-configurator
    python scripts/get_token.py predictor

Prints the JWT access token to stdout. Exits 0 on success, 1 on error.
"""

import sys

import httpx

CASDOOR_URL = "http://localhost:8000"
CLIENT_ID = "transport-deluxe-client"
CLIENT_SECRET = "transport-deluxe-secret"

ROLE_USERS: dict[str, tuple[str, str]] = {
    "cost-configurator": ("test-cost-configurator", "test123"),
    "margin-configurator": ("test-margin-configurator", "test123"),
    "predictor": ("test-predictor", "test123"),
}

VALID_ROLES = ", ".join(ROLE_USERS)


def main() -> None:
    if len(sys.argv) != 2 or sys.argv[1] not in ROLE_USERS:
        print(
            f"Usage: python scripts/get_token.py <role>\nValid roles: {VALID_ROLES}",
            file=sys.stderr,
        )
        sys.exit(1)

    role = sys.argv[1]
    username, password = ROLE_USERS[role]

    try:
        response = httpx.post(
            f"{CASDOOR_URL}/api/login/oauth/access_token",
            data={
                "grant_type": "password",
                "client_id": CLIENT_ID,
                "client_secret": CLIENT_SECRET,
                "username": username,
                "password": password,
                "scope": "openid profile",
            },
            headers={"Content-Type": "application/x-www-form-urlencoded"},
            timeout=10,
        )
        response.raise_for_status()
    except httpx.HTTPStatusError as exc:
        status = exc.response.status_code
        body = exc.response.text
        print(f"Error: Casdoor returned HTTP {status}: {body}", file=sys.stderr)
        sys.exit(1)
    except httpx.RequestError as exc:
        print(
            f"Error: Could not connect to Casdoor at {CASDOOR_URL}: {exc}",
            file=sys.stderr,
        )
        sys.exit(1)

    data = response.json()
    token = data.get("access_token")
    if not token:
        print(f"Error: No access_token in response: {data}", file=sys.stderr)
        sys.exit(1)

    print(token)


if __name__ == "__main__":
    main()
