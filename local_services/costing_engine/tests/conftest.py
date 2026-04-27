import os

import httpx
import pytest_asyncio
from sqlalchemy import text
from sqlalchemy.ext.asyncio import create_async_engine
from sqlalchemy.pool import NullPool
from sqlmodel.ext.asyncio.session import AsyncSession
from src.main import app

CASDOOR_URL = os.environ.get("CASDOOR_URL", "http://localhost:8000")
CLIENT_ID = "transport-deluxe-client"
CLIENT_SECRET = "transport-deluxe-secret"


@pytest_asyncio.fixture(scope="session")
async def test_db():
    url = os.environ["DATABASE_URL"]
    engine = create_async_engine(url, echo=False, poolclass=NullPool)

    from sqlmodel import SQLModel
    from src.modules.costing.models import CostingAudit  # noqa: F401

    async with engine.begin() as conn:
        await conn.run_sync(SQLModel.metadata.create_all)

    yield engine

    async with engine.begin() as conn:
        await conn.run_sync(SQLModel.metadata.drop_all)
    await engine.dispose()


@pytest_asyncio.fixture(scope="function")
async def clean_table(test_db):
    async with AsyncSession(test_db, expire_on_commit=False) as session:
        await session.exec(text("DELETE FROM costing_audit"))
        await session.commit()
    yield


@pytest_asyncio.fixture(scope="session")
async def auth_token():
    return "mock-token"


@pytest_asyncio.fixture(scope="function")
async def client(test_db):
    from src.tools import db as db_module

    db_module.engine = test_db

    transport = httpx.ASGITransport(app=app)
    async with httpx.AsyncClient(transport=transport, base_url="http://test") as ac:
        yield ac
