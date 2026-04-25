import logging
import logging.config
import os
from collections.abc import AsyncGenerator
from contextlib import asynccontextmanager

from fastapi import FastAPI, HTTPException, Request
from fastapi.responses import JSONResponse
from sqladmin import Admin

from src.modules.base_margin_config.admin import BaseMarginConfigAdmin
from src.modules.base_margin_config.router import router
from src.tools.admin_auth import AdminAuth
from src.tools.auth import fetch_jwks
from src.tools.db import engine

logging.basicConfig(
    level=logging.INFO,
    format=('{"time": "%(asctime)s", "level": "%(levelname)s", "logger": "%(name)s", "message": "%(message)s"}'),
)
logger = logging.getLogger(__name__)


@asynccontextmanager
async def lifespan(app: FastAPI) -> AsyncGenerator[None, None]:
    import subprocess

    result = subprocess.run(
        ["alembic", "-c", "/app/alembic.ini", "upgrade", "head"],
        capture_output=True,
        text=True,
        cwd="/app",
    )
    if result.returncode != 0:
        logger.error("Alembic migration failed: %s", result.stderr)
        raise RuntimeError(f"Migration failed: {result.stderr}")
    logger.info("Alembic migrations applied")

    await fetch_jwks()
    yield


app = FastAPI(title="Base Margin Configuration Service", lifespan=lifespan)

admin_auth = AdminAuth(secret_key=os.environ.get("SESSION_SECRET", "super-secret-key"))
admin = Admin(app, engine, authentication_backend=admin_auth)
admin.add_view(BaseMarginConfigAdmin)


@app.exception_handler(HTTPException)
async def http_exception_handler(request: Request, exc: HTTPException) -> JSONResponse:
    if isinstance(exc.detail, dict):
        content = exc.detail
    else:
        content = {"status": exc.status_code, "messages": [str(exc.detail)]}
    return JSONResponse(status_code=exc.status_code, content=content)


@app.exception_handler(Exception)
async def unhandled_exception_handler(request: Request, exc: Exception) -> JSONResponse:
    from sqlalchemy.exc import IntegrityError

    if isinstance(exc, IntegrityError):
        orig_type = type(exc.orig).__name__ if exc.orig else ""
        if "UniqueViolation" in orig_type or "unique" in str(exc.orig).lower():
            logger.warning("Unique constraint violation: %s", exc)
            return JSONResponse(
                status_code=409,
                content={
                    "status": 409,
                    "messages": ["An active configuration already exists for this combination"],
                },
            )
    logger.error("Unhandled exception: %s", exc, exc_info=True)
    return JSONResponse(
        status_code=503,
        content={"status": 503, "messages": ["Service temporarily unavailable"]},
    )


app.include_router(router, prefix="/base-margin-configs")
