# mypy: ignore-errors

import logging
import os

import httpx
from fastapi import Request
from sqladmin.authentication import AuthenticationBackend

logger = logging.getLogger(__name__)


class AdminAuth(AuthenticationBackend):
    async def login(self, request: Request) -> bool:
        form = await request.form()
        username, password = form.get("username"), form.get("password")

        if not username or not password:
            return False

        # Authenticate via Casdoor using Resource Owner Password Credentials Grant
        casdoor_internal_url = os.environ.get("CASDOOR_INTERNAL_URL", "http://casdoor:8000")
        url = f"{casdoor_internal_url}/api/login/oauth/access_token"

        async with httpx.AsyncClient() as client:
            try:
                response = await client.post(
                    url,
                    data={
                        "grant_type": "password",
                        "client_id": "transport-deluxe-client",
                        "client_secret": "transport-deluxe-secret",
                        "username": username,
                        "password": password,
                        "scope": "openid profile",
                    },
                    headers={"Content-Type": "application/x-www-form-urlencoded"},
                    timeout=10.0,
                )
            except Exception as e:
                logger.error("Failed to reach Casdoor for login: %s", e)
                return False

        if response.status_code != 200:
            logger.warning("Casdoor login failed: %s", response.text)
            return False

        data = response.json()
        token = data.get("access_token")
        if not token:
            logger.warning("No access_token in Casdoor response")
            return False

        # Verify token roles
        try:
            from fastapi.security import HTTPAuthorizationCredentials

            from src.tools.auth import verify_jwt

            credentials = HTTPAuthorizationCredentials(scheme="Bearer", credentials=token)
            payload = await verify_jwt(credentials)
            jwt_name = payload.get("name") or payload.get("preferred_username") or username
        except Exception as e:
            logger.warning("JWT verification during login failed: %s", e)
            return False

        # Save minimal info in signed session cookie
        request.session.update({"admin_user": jwt_name})
        return True

    async def logout(self, request: Request) -> bool:
        request.session.clear()
        return True

    async def authenticate(self, request: Request) -> bool:
        # Starlette session cookie is cryptographically signed
        admin_user = request.session.get("admin_user")
        if not admin_user:
            return False
        return True
