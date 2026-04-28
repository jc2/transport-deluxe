import logging
from collections.abc import AsyncGenerator
from contextlib import asynccontextmanager

from fastapi import FastAPI, HTTPException, Request
from fastapi.responses import JSONResponse
from sqladmin import Admin
from sqlmodel import SQLModel

from .modules.pricing.admin import PricingAuditAdmin
from .modules.pricing.router import router
from .tools.db import engine

logging.basicConfig(
    level=logging.INFO,
    format=('{"time": "%(asctime)s", "level": "%(levelname)s", "logger": "%(name)s", "message": "%(message)s"}'),
)
logger = logging.getLogger(__name__)


@asynccontextmanager
async def lifespan(app: FastAPI) -> AsyncGenerator[None, None]:
    async with engine.begin() as conn:
        logger.info("Setting up tables...")
        await conn.run_sync(SQLModel.metadata.create_all)
        logger.info("Tables created successfully.")
    yield
    await engine.dispose()


app = FastAPI(title="Pricing Engine Service", lifespan=lifespan)

admin = Admin(app, engine)
admin.add_view(PricingAuditAdmin)


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


app.include_router(router)
