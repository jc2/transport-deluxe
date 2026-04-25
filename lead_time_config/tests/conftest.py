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
async def test_db() -> None:
    url = os.environ["DATABASE_URL"]
    engine = create_async_engine(url, echo=False, poolclass=NullPool)

    from sqlalchemy import text
    from sqlmodel import SQLModel
    from src.modules.lead_time_config.models import LeadTimeConfig  # noqa: F401

    async with engine.begin() as conn:
        await conn.execute(text("DROP INDEX IF EXISTS uq_ltc_active_combination;"))
        await conn.run_sync(SQLModel.metadata.create_all)

    yield engine

    async with engine.begin() as conn:
        await conn.run_sync(SQLModel.metadata.drop_all)
    await engine.dispose()


@pytest_asyncio.fixture(scope="function")
async def clean_table(test_db):
    async with AsyncSession(test_db, expire_on_commit=False) as session:
        await session.exec(text("DELETE FROM lead_time_config"))
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
                "username": "test-margin-configurator",
                "password": "test123",
                "scope": "openid profile",
            },
            headers={"Content-Type": "application/x-www-form-urlencoded"},
            timeout=15.0,
        )
        response.raise_for_status()
        data = response.json()
        return data["access_token"]


@pytest_asyncio.fixture(scope="session", autouse=True)
async def load_jwks():
    from src.tools.auth import fetch_jwks

    await fetch_jwks()


@pytest_asyncio.fixture(scope="function")
async def client(test_db):
    from src.tools import db as db_module

    db_module.engine = test_db

    transport = httpx.ASGITransport(app=app)
    async with httpx.AsyncClient(transport=transport, base_url="http://test") as ac:
        yield ac
