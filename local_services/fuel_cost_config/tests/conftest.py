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
CLIENT_SECRET = os.environ.get("CASDOOR_CLIENT_SECRET", "transport-deluxe-secret")


@pytest_asyncio.fixture(scope="session")
async def test_db():
    url = os.environ.get("DATABASE_URL", "postgresql+asyncpg://postgres:postgres@localhost:5432/fuel_cost_config_test")
    engine = create_async_engine(url, echo=False, poolclass=NullPool)

    from sqlmodel import SQLModel
    from src.modules.fuel_cost_config.models import FuelCostConfig  # noqa: F401 (registers SQLModel table metadata)

    async with engine.begin() as conn:
        await conn.run_sync(SQLModel.metadata.drop_all)
        await conn.run_sync(SQLModel.metadata.create_all)

    yield engine

    async with engine.begin() as conn:
        await conn.run_sync(SQLModel.metadata.drop_all)
    await engine.dispose()


@pytest_asyncio.fixture(scope="function")
async def clean_table(test_db):
    async with AsyncSession(test_db, expire_on_commit=False) as session:
        await session.exec(text("DELETE FROM fuel_cost_config"))
        await session.commit()
    yield


@pytest_asyncio.fixture(scope="session")
async def auth_token():
    async with httpx.AsyncClient() as client:
        response = await client.post(
            f"{CASDOOR_URL}/api/login/oauth/access_token",
            data={
                "grant_type": "password",
                "client_id": CLIENT_ID,
                "client_secret": CLIENT_SECRET,
                "username": "test-cost-configurator",
                "password": "test123",
                "scope": "openid profile",
            },
            headers={"Content-Type": "application/x-www-form-urlencoded"},
            timeout=15.0,
        )
        response.raise_for_status()
        data = response.json()
        return data["access_token"]


@pytest_asyncio.fixture(scope="function")
async def client(test_db):
    from src.tools import db as db_module

    db_module.engine = test_db

    transport = httpx.ASGITransport(app=app)
    async with httpx.AsyncClient(transport=transport, base_url="http://test") as ac:
        yield ac


@pytest_asyncio.fixture(scope="function")
async def mcp_client(test_db, clean_table):
    from fastmcp import Client
    from src.modules.fuel_cost_config import mcp_tools as _  # noqa: F401 — registers tools on mcp
    from src.modules.fuel_cost_config import repo as repo_module
    from src.modules.fuel_cost_config.mcp_server import mcp
    from src.tools import db as db_module

    db_module.engine = test_db
    repo_module  # ensure module is imported so engine reference is live

    async with Client(mcp) as c:
        yield c
