import os

import httpx
import pytest_asyncio
from sqlalchemy import text
from sqlalchemy.ext.asyncio import create_async_engine
from sqlalchemy.pool import NullPool
from sqlmodel import SQLModel
from sqlmodel.ext.asyncio.session import AsyncSession
from src.main import app
from src.modules.reports.models import CostingAudit, MarginAudit, PricingAudit  # noqa: F401


@pytest_asyncio.fixture(scope="session")
async def test_db():
    url = os.environ["DATABASE_URL"]
    engine = create_async_engine(url, echo=False, poolclass=NullPool)

    async with engine.begin() as conn:
        await conn.run_sync(SQLModel.metadata.create_all)

    yield engine

    async with engine.begin() as conn:
        await conn.run_sync(SQLModel.metadata.drop_all)
    await engine.dispose()


@pytest_asyncio.fixture(scope="function")
async def clean_tables(test_db):
    async with AsyncSession(test_db, expire_on_commit=False) as session:
        await session.exec(text("DELETE FROM costing_engine.costing_audit"))
        await session.exec(text("DELETE FROM margin_engine.margin_audit"))
        await session.exec(text("DELETE FROM pricing_engine.pricing_audit"))
        await session.commit()
    yield


@pytest_asyncio.fixture(scope="function")
async def client(test_db):
    from src.tools import db as db_module

    db_module.engine = test_db

    transport = httpx.ASGITransport(app=app)
    async with httpx.AsyncClient(transport=transport, base_url="http://test") as ac:
        yield ac
