import logging
import os
from typing import Annotated, Any

import httpx
from fastapi import Depends, HTTPException
from fastapi.security import HTTPAuthorizationCredentials, HTTPBearer
from jose import JWTError, jwt

logger = logging.getLogger(__name__)

_jwks: dict[str, Any] = {}

bearer_scheme = HTTPBearer(auto_error=False)


async def fetch_jwks() -> None:
    url = os.environ["CASDOOR_JWKS_URL"]
    async with httpx.AsyncClient() as client:
        response = await client.get(url, timeout=10.0)
        response.raise_for_status()
        global _jwks
        data: dict[str, Any] = response.json()
        _jwks = data
    logger.info("JWKS fetched successfully from %s", url)


def _find_key_for_token(token: str) -> dict[str, Any]:
    unverified_header = jwt.get_unverified_header(token)
    kid = unverified_header.get("kid")
    for key in _jwks.get("keys", []):
        if key.get("kid") == kid:
            return dict(key)
    raise HTTPException(
        status_code=401,
        detail={"status": 401, "messages": ["No matching key found in JWKS"]},
    )


JwtCredentials = Annotated[HTTPAuthorizationCredentials | None, Depends(bearer_scheme)]


async def verify_jwt(credentials: JwtCredentials) -> dict[str, Any]:
    if credentials is None:
        raise HTTPException(
            status_code=401,
            detail={"status": 401, "messages": ["Missing Authorization header"]},
        )

    token = credentials.credentials
    try:
        public_key = _find_key_for_token(token)
        payload = jwt.decode(
            token,
            public_key,
            algorithms=["RS256"],
            options={"verify_aud": False},
        )
    except JWTError as exc:
        logger.warning("JWT verification failed: %s", exc)
        raise HTTPException(
            status_code=401,
            detail={"status": 401, "messages": ["Invalid or expired token"]},
        )

    roles = payload.get("roles") or []
    role_names = [r.get("name") if isinstance(r, dict) else r for r in roles]
    if "margin-configurator" not in role_names:
        raise HTTPException(
            status_code=403,
            detail={
                "status": 403,
                "messages": ["Forbidden: margin-configurator role required"],
            },
        )

    return dict(payload)


VerifiedJwt = Annotated[dict[str, Any], Depends(verify_jwt)]
