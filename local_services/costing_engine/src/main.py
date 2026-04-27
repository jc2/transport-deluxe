import logging
from collections.abc import AsyncGenerator
from contextlib import asynccontextmanager

from fastapi import FastAPI, HTTPException, Request
from fastapi.responses import JSONResponse
from sqladmin import Admin

from .modules.costing.admin import CostingAuditAdmin
from .modules.costing.router import router
from .tools.db import engine

logging.basicConfig(
    level=logging.INFO,
    format=('{"time": "%(asctime)s", "level": "%(levelname)s", "logger": "%(name)s", "message": "%(message)s"}'),
)
logger = logging.getLogger(__name__)


@asynccontextmanager
async def lifespan(app: FastAPI) -> AsyncGenerator[None, None]:
    import subprocess

    # Run migrations
    result = subprocess.run(
        ["alembic", "-c", "/app/alembic.ini", "upgrade", "head"],
        capture_output=True,
        text=True,
        cwd="/app",
    )
    if result.returncode != 0:
        logger.error("Alembic migration failed: %s", result.stderr)
        # In a real environment, we might not want to crash if migrations are handled elsewhere,
        # but following fuel_cost_config pattern.
    else:
        logger.info("Alembic migrations applied")

    yield


app = FastAPI(title="Costing Engine Service", lifespan=lifespan)

admin = Admin(app, engine)
admin.add_view(CostingAuditAdmin)


@app.exception_handler(HTTPException)
async def http_exception_handler(request: Request, exc: HTTPException) -> JSONResponse:
    if isinstance(exc.detail, dict):
        content = exc.detail
    else:
        content = {"status": exc.status_code, "messages": [str(exc.detail)]}
    return JSONResponse(status_code=exc.status_code, content=content)


@app.exception_handler(Exception)
async def unhandled_exception_handler(request: Request, exc: Exception) -> JSONResponse:
    logger.error("Unhandled exception: %s", exc, exc_info=True)
    return JSONResponse(
        status_code=500,
        content={"status": 500, "messages": ["Internal Server Error"]},
    )


app.include_router(router, prefix="/costing")
