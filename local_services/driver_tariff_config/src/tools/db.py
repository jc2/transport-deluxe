import os
from collections.abc import AsyncGenerator
from contextlib import asynccontextmanager

from sqlalchemy.ext.asyncio import AsyncEngine, create_async_engine
from sqlmodel.ext.asyncio.session import AsyncSession


def _make_engine() -> AsyncEngine:
    url = os.environ["DATABASE_URL"]
    schema = os.environ.get("DB_SCHEMA", "public")
    return create_async_engine(
        url,
        echo=False,
        connect_args={"server_settings": {"search_path": f"{schema},public"}},
    )


engine = _make_engine()


@asynccontextmanager
async def get_db_session() -> AsyncGenerator[AsyncSession, None]:
    async with AsyncSession(engine, expire_on_commit=False) as session:
        yield session
