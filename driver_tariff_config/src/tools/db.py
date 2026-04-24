import os
from collections.abc import AsyncGenerator

from sqlalchemy.ext.asyncio import AsyncEngine, create_async_engine
from sqlmodel.ext.asyncio.session import AsyncSession


def _make_engine() -> AsyncEngine:
    url = os.environ["DATABASE_URL"]
    return create_async_engine(url, echo=False)


engine = _make_engine()


async def get_session() -> AsyncGenerator[AsyncSession, None]:
    async with AsyncSession(engine, expire_on_commit=False) as session:
        yield session
