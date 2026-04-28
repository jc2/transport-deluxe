import pytest_asyncio
from httpx import ASGITransport, AsyncClient
from sqlmodel import SQLModel
from src.main import app
from src.tools.db import engine


@pytest_asyncio.fixture(autouse=True)
async def setup_db():
    from src.modules.pricing.models import PricingAudit  # noqa: F401

    # In-memory execution using default sqlmodel + sqlalchemy create_all
    async with engine.begin() as conn:
        await conn.run_sync(SQLModel.metadata.create_all)
    yield
    async with engine.begin() as conn:
        await conn.run_sync(SQLModel.metadata.drop_all)


@pytest_asyncio.fixture
async def async_client(setup_db):
    async with AsyncClient(
        transport=ASGITransport(app=app),
        base_url="http://test",  # type: ignore
    ) as client:
        yield client
