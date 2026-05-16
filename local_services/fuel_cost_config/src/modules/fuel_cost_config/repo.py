import uuid as uuid_lib
from collections.abc import Sequence

from sqlalchemy.exc import IntegrityError
from sqlmodel import col, func, select

from src.tools.db import get_db_session

from .exceptions import ConfigNotFoundError, DuplicateConfigError
from .models import FuelCostConfig


async def get_config(uuid_val: uuid_lib.UUID) -> FuelCostConfig:
    async with get_db_session() as session:
        stmt = (
            select(FuelCostConfig)
            .where(FuelCostConfig.uuid == uuid_val)
            .order_by(col(FuelCostConfig.version).desc())
            .limit(1)
        )
        result = await session.exec(stmt)
        record = result.first()
        if not record:
            raise ConfigNotFoundError(f"Configuration {uuid_val} not found.")
        return record


async def list_configs(
    customer_name: str | None = None,
    customer_subname: str | None = None,
    truck_type: str | None = None,
) -> Sequence[FuelCostConfig]:
    async with get_db_session() as session:
        stmt = (
            select(FuelCostConfig)
            .distinct(col(FuelCostConfig.uuid))
            .order_by(col(FuelCostConfig.uuid), col(FuelCostConfig.version).desc())
        )

        if customer_name is not None:
            stmt = stmt.where(FuelCostConfig.customer_name == customer_name)
        if customer_subname is not None:
            stmt = stmt.where(FuelCostConfig.customer_subname == customer_subname)
        if truck_type is not None:
            stmt = stmt.where(FuelCostConfig.truck_type == truck_type)

        result = await session.exec(stmt)
        return result.all()


async def count_matching(
    customer_name: str | None,
    customer_subname: str | None,
    truck_type: str,
    exclude_uuid: uuid_lib.UUID | None = None,
) -> int:
    async with get_db_session() as session:
        stmt = (
            select(func.count())
            .select_from(FuelCostConfig)
            .where(
                FuelCostConfig.customer_name == customer_name,
                FuelCostConfig.customer_subname == customer_subname,
                FuelCostConfig.truck_type == truck_type,
            )
        )
        if exclude_uuid is not None:
            stmt = stmt.where(FuelCostConfig.uuid != exclude_uuid)

        result = await session.exec(stmt)
        return result.one()


async def save_config(record: FuelCostConfig) -> FuelCostConfig:
    async with get_db_session() as session:
        try:
            session.add(record)
            await session.commit()
            await session.refresh(record)
            return record
        except IntegrityError as exc:
            await session.rollback()
            raise DuplicateConfigError("An active configuration already exists for this combination.") from exc


async def get_all_active_configs() -> Sequence[FuelCostConfig]:
    """Return the latest version of every distinct config (used by resolve logic)."""
    async with get_db_session() as session:
        stmt = (
            select(FuelCostConfig)
            .distinct(col(FuelCostConfig.uuid))
            .order_by(col(FuelCostConfig.uuid), col(FuelCostConfig.version).desc())
        )
        result = await session.exec(stmt)
        return result.all()


async def delete_config(uuid_val: uuid_lib.UUID) -> None:
    async with get_db_session() as session:
        stmt = (
            select(FuelCostConfig)
            .where(FuelCostConfig.uuid == uuid_val)
            .order_by(col(FuelCostConfig.version).desc())
            .limit(1)
        )
        result = await session.exec(stmt)
        record = result.first()
        if not record:
            raise ConfigNotFoundError(f"Configuration {uuid_val} not found.")
        await session.delete(record)
        await session.commit()
