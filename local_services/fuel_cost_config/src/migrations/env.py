import asyncio
import os
from logging.config import fileConfig
from typing import Any

from alembic import context
from sqlalchemy import pool
from sqlalchemy.ext.asyncio import create_async_engine

config = context.config
if config.config_file_name is not None:
    fileConfig(config.config_file_name)

target_metadata = None


def _get_url() -> str:
    return os.environ["DATABASE_URL"]


def run_migrations_offline() -> None:
    url = _get_url()
    schema = os.environ.get("DB_SCHEMA", "public")
    context.configure(
        url=url,
        target_metadata=target_metadata,
        literal_binds=True,
        dialect_opts={"paramstyle": "named"},
        version_table_schema=schema,
    )
    with context.begin_transaction():
        context.run_migrations()


def do_run_migrations(connection: Any) -> None:
    schema = os.environ.get("DB_SCHEMA", "public")
    context.configure(connection=connection, target_metadata=target_metadata, version_table_schema=schema)
    with context.begin_transaction():
        context.run_migrations()


async def run_async_migrations() -> None:
    url = _get_url()
    schema = os.environ.get("DB_SCHEMA", "public")
    connectable = create_async_engine(
        url,
        poolclass=pool.NullPool,
        connect_args={"server_settings": {"search_path": f"{schema},public"}},
    )
    async with connectable.connect() as connection:
        await connection.run_sync(do_run_migrations)
    await connectable.dispose()


def run_migrations_online() -> None:
    asyncio.run(run_async_migrations())


if context.is_offline_mode():
    run_migrations_offline()
else:
    run_migrations_online()
