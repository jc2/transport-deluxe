import logging
import os
from typing import Annotated, Any

from fastapi import Depends, HTTPException
from fastapi.security import HTTPAuthorizationCredentials, HTTPBearer
from fastmcp.server.auth import OAuthProxy  # type: ignore[import-not-found]
from fastmcp.server.auth.providers.jwt import JWTVerifier  # type: ignore[import-not-found]

logger = logging.getLogger(__name__)

bearer_scheme = HTTPBearer(auto_error=False)

_REQUIRED_ROLE = "margin-configurator"


def _has_required_role(roles_claim: list[Any]) -> bool:
    role_names = [r.get("name") if isinstance(r, dict) else r for r in roles_claim]
    return _REQUIRED_ROLE in role_names


class CasdoorJWTVerifier(JWTVerifier):  # type: ignore[misc]
    """JWTVerifier extended to support Casdoor's role-based authorization.

    Casdoor encodes roles as a list of objects (e.g. [{"name": "margin-configurator", ...}])
    in the `roles` JWT claim, rather than the standard OAuth `scope` string.
    This verifier validates the JWT via JWKS and then enforces the required role.
    """

    async def verify_token(self, token: str) -> Any:
        access_token = await super().verify_token(token)
        if access_token is None:
            return None

        roles: list[Any] = access_token.claims.get("roles") or []
        if not _has_required_role(roles):
            logger.warning(
                "Bearer token rejected: missing required role %r",
                _REQUIRED_ROLE,
            )
            return None

        return access_token


_proxy: OAuthProxy | None = None


def get_mcp_auth() -> OAuthProxy:
    """Build the MCP OAuth proxy from environment variables."""
    global _proxy
    if _proxy is None:
        # Public URL (browser-facing): used for auth redirects and JWT issuer validation
        casdoor_public = os.environ["CASDOOR_ISSUER"]  # e.g. http://localhost:8000
        # Internal URL (server-to-server): used for token exchange inside Docker
        casdoor_internal = os.environ.get("CASDOOR_INTERNAL_URL", casdoor_public)
        service_base_url = os.environ.get("SERVICE_BASE_URL", "http://localhost:8003")

        token_verifier = CasdoorJWTVerifier(
            jwks_uri=os.environ["CASDOOR_JWKS_URL"],
            issuer=casdoor_public,
            audience=os.environ.get("CASDOOR_AUDIENCE"),
        )

        _proxy = OAuthProxy(
            upstream_authorization_endpoint=f"{casdoor_public}/login/oauth/authorize",
            upstream_token_endpoint=f"{casdoor_internal}/api/login/oauth/access_token",
            upstream_client_id=os.environ["CASDOOR_CLIENT_ID"],
            upstream_client_secret=os.environ["CASDOOR_CLIENT_SECRET"],
            token_verifier=token_verifier,
            base_url=service_base_url,
            allowed_client_redirect_uris=[
                "http://127.0.0.1:*",
                "https://vscode.dev/redirect",
            ],
            valid_scopes=["openid", "profile"],
            forward_pkce=False,
            forward_resource=False,
            token_endpoint_auth_method="client_secret_post",
            require_authorization_consent="external",
        )
    return _proxy


# ---------------------------------------------------------------------------
# REST API auth (FastAPI dependency — unchanged)
# ---------------------------------------------------------------------------

JwtCredentials = Annotated[HTTPAuthorizationCredentials | None, Depends(bearer_scheme)]


async def verify_jwt(credentials: JwtCredentials) -> dict[str, Any]:
    if credentials is None:
        raise HTTPException(status_code=401, detail={"status": 401, "messages": ["Missing Authorization header"]})

    proxy = get_mcp_auth()
    access_token = await proxy.verify_token(credentials.credentials)
    if access_token is None:
        raise HTTPException(
            status_code=401,
            detail={"status": 401, "messages": ["Invalid or expired token"]},
        )

    return dict(access_token.claims)


VerifiedJwt = Annotated[dict[str, Any], Depends(verify_jwt)]
