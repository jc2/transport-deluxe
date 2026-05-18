import uuid as uuid_lib
from collections.abc import Sequence

from sqlalchemy.exc import IntegrityError
from sqlmodel import col, func, select
from src.tools.db import get_db_session

from .exceptions import ConfigNotFoundError, DuplicateConfigError
from .models import DriverTariffConfig


async def get_config(uuid_val: uuid_lib.UUID) -> DriverTariffConfig:
    async with get_db_session() as session:
        stmt = (
            select(DriverTariffConfig)
            .where(DriverTariffConfig.uuid == uuid_val)
            .order_by(col(DriverTariffConfig.version).desc())
            .limit(1)
        )
        result = await session.exec(stmt)
        record = result.first()
        if not record:
            raise ConfigNotFoundError(f"Configuration {uuid_val} not found.")
        return record


async def list_configs(
    pickup_state: str | None = None,
    drop_state: str | None = None,
) -> Sequence[DriverTariffConfig]:
    async with get_db_session() as session:
        stmt = (
            select(DriverTariffConfig)
            .distinct(col(DriverTariffConfig.uuid))
            .order_by(col(DriverTariffConfig.uuid), col(DriverTariffConfig.version).desc())
        )

        if pickup_state is not None:
            stmt = stmt.where(DriverTariffConfig.pickup_state == pickup_state)
        if drop_state is not None:
            stmt = stmt.where(DriverTariffConfig.drop_state == drop_state)

        result = await session.exec(stmt)
        return result.all()


async def get_all_active_configs() -> Sequence[DriverTariffConfig]:
    """Return the latest version of every distinct config (used by resolve logic)."""
    async with get_db_session() as session:
        stmt = (
            select(DriverTariffConfig)
            .distinct(col(DriverTariffConfig.uuid))
            .order_by(col(DriverTariffConfig.uuid), col(DriverTariffConfig.version).desc())
        )
        result = await session.exec(stmt)
        return result.all()


async def count_matching(
    pickup_state: str | None,
    drop_state: str | None,
    exclude_uuid: uuid_lib.UUID | None = None,
) -> int:
    async with get_db_session() as session:
        stmt = (
            select(func.count())
            .select_from(DriverTariffConfig)
            .where(
                DriverTariffConfig.pickup_state == pickup_state,
                DriverTariffConfig.drop_state == drop_state,
            )
        )
        if exclude_uuid is not None:
            stmt = stmt.where(DriverTariffConfig.uuid != exclude_uuid)

        result = await session.exec(stmt)
        return result.one()


async def save_config(record: DriverTariffConfig) -> DriverTariffConfig:
    async with get_db_session() as session:
        try:
            session.add(record)
            await session.commit()
            await session.refresh(record)
            return record
        except IntegrityError as exc:
            await session.rollback()
            raise DuplicateConfigError(
                "A configuration already exists for this pickup and drop state combination."
            ) from exc


async def delete_config(uuid_val: uuid_lib.UUID) -> None:
    async with get_db_session() as session:
        stmt = select(DriverTariffConfig).where(DriverTariffConfig.uuid == uuid_val)
        result = await session.exec(stmt)
        rows = result.all()
        if not rows:
            raise ConfigNotFoundError(f"Configuration {uuid_val} not found.")
        for row in rows:
            await session.delete(row)
        await session.commit()
