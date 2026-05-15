import logging
import os
from collections.abc import AsyncGenerator
from contextlib import asynccontextmanager

from fastapi import FastAPI, Request
from fastapi.exceptions import RequestValidationError
from fastapi.responses import JSONResponse
from fastmcp.utilities.lifespan import combine_lifespans
from sqladmin import Admin
from starlette.exceptions import HTTPException as StarletteHTTPException

import src.modules.lead_time_config.mcp_tools  # noqa: F401
from src.modules.lead_time_config.admin import LeadTimeConfigAdmin
from src.modules.lead_time_config.exceptions import (
    ConfigNotFoundError,
    DuplicateConfigError,
    InvalidConfigError,
    OverlappingConfigError,
)
from src.modules.lead_time_config.mcp_server import mcp
from src.modules.lead_time_config.router import router
from src.tools.admin_auth import AdminAuth
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

    yield


mcp_app = mcp.http_app(path="/mcp", transport="streamable-http")

app = FastAPI(title="Lead Time Configuration Service", lifespan=combine_lifespans(lifespan, mcp_app.lifespan))

admin_auth = AdminAuth(secret_key=os.environ.get("SESSION_SECRET", "super-secret-key"))
admin = Admin(app, engine, authentication_backend=admin_auth)
admin.add_view(LeadTimeConfigAdmin)


# ---------------------------------------------------------------------------
# Global exception handlers — ALL responses use {"messages": [...]}
# ---------------------------------------------------------------------------


@app.exception_handler(StarletteHTTPException)
async def http_exception_handler(request: Request, exc: StarletteHTTPException) -> JSONResponse:
    if isinstance(exc.detail, dict) and "messages" in exc.detail:
        messages = exc.detail["messages"]
    else:
        messages = [str(exc.detail)]
    return JSONResponse(status_code=exc.status_code, content={"messages": messages})


@app.exception_handler(RequestValidationError)
async def validation_exception_handler(request: Request, exc: RequestValidationError) -> JSONResponse:
    messages = [f"{' -> '.join(str(loc) for loc in e['loc'])}: {e['msg']}" for e in exc.errors()]
    return JSONResponse(status_code=422, content={"messages": messages})


@app.exception_handler(ConfigNotFoundError)
async def config_not_found_handler(request: Request, exc: ConfigNotFoundError) -> JSONResponse:
    return JSONResponse(status_code=404, content={"messages": [str(exc)]})


@app.exception_handler(DuplicateConfigError)
async def duplicate_config_handler(request: Request, exc: DuplicateConfigError) -> JSONResponse:
    return JSONResponse(status_code=409, content={"messages": [str(exc)]})


@app.exception_handler(OverlappingConfigError)
async def overlapping_config_handler(request: Request, exc: OverlappingConfigError) -> JSONResponse:
    return JSONResponse(status_code=409, content={"messages": [str(exc)]})


@app.exception_handler(InvalidConfigError)
async def invalid_config_handler(request: Request, exc: InvalidConfigError) -> JSONResponse:
    return JSONResponse(status_code=422, content={"messages": [str(exc)]})


@app.exception_handler(Exception)
async def unhandled_exception_handler(request: Request, exc: Exception) -> JSONResponse:
    logger.error("Unhandled exception: %s", exc, exc_info=True)
    return JSONResponse(status_code=503, content={"messages": ["Service temporarily unavailable"]})


app.include_router(router, prefix="/lead-time-configs")
app.mount("/", mcp_app)
