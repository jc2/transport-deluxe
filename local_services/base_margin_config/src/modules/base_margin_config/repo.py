import uuid as uuid_lib
from collections.abc import Sequence

from sqlalchemy.exc import IntegrityError
from sqlmodel import col, func, select
from src.tools.db import get_db_session

from .exceptions import ConfigNotFoundError, DuplicateConfigError
from .models import BaseMarginConfig


async def get_config(uuid_val: uuid_lib.UUID) -> BaseMarginConfig:
    async with get_db_session() as session:
        stmt = (
            select(BaseMarginConfig)
            .where(BaseMarginConfig.uuid == uuid_val)
            .order_by(col(BaseMarginConfig.version).desc())
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
    pickup_country: str | None = None,
    pickup_state: str | None = None,
    pickup_city: str | None = None,
    pickup_postal_code: str | None = None,
    drop_country: str | None = None,
    drop_state: str | None = None,
    drop_city: str | None = None,
    drop_postal_code: str | None = None,
) -> Sequence[BaseMarginConfig]:
    async with get_db_session() as session:
        stmt = (
            select(BaseMarginConfig)
            .distinct(col(BaseMarginConfig.uuid))
            .order_by(col(BaseMarginConfig.uuid), col(BaseMarginConfig.version).desc())
        )

        if customer_name is not None:
            stmt = stmt.where(BaseMarginConfig.customer_name == customer_name)
        if customer_subname is not None:
            stmt = stmt.where(BaseMarginConfig.customer_subname == customer_subname)
        if pickup_country is not None:
            stmt = stmt.where(BaseMarginConfig.pickup_country == pickup_country)
        if pickup_state is not None:
            stmt = stmt.where(BaseMarginConfig.pickup_state == pickup_state)
        if pickup_city is not None:
            stmt = stmt.where(BaseMarginConfig.pickup_city == pickup_city)
        if pickup_postal_code is not None:
            stmt = stmt.where(BaseMarginConfig.pickup_postal_code == pickup_postal_code)
        if drop_country is not None:
            stmt = stmt.where(BaseMarginConfig.drop_country == drop_country)
        if drop_state is not None:
            stmt = stmt.where(BaseMarginConfig.drop_state == drop_state)
        if drop_city is not None:
            stmt = stmt.where(BaseMarginConfig.drop_city == drop_city)
        if drop_postal_code is not None:
            stmt = stmt.where(BaseMarginConfig.drop_postal_code == drop_postal_code)

        result = await session.exec(stmt)
        return result.all()


async def get_all_active_configs() -> Sequence[BaseMarginConfig]:
    """Return the latest version of every distinct config (used by resolve logic)."""
    async with get_db_session() as session:
        stmt = (
            select(BaseMarginConfig)
            .distinct(col(BaseMarginConfig.uuid))
            .order_by(col(BaseMarginConfig.uuid), col(BaseMarginConfig.version).desc())
        )
        result = await session.exec(stmt)
        return result.all()


async def count_matching(
    customer_name: str | None,
    customer_subname: str | None,
    pickup_country: str | None,
    pickup_state: str | None,
    pickup_city: str | None,
    pickup_postal_code: str | None,
    drop_country: str | None,
    drop_state: str | None,
    drop_city: str | None,
    drop_postal_code: str | None,
    exclude_uuid: uuid_lib.UUID | None = None,
) -> int:
    async with get_db_session() as session:
        stmt = (
            select(func.count())
            .select_from(BaseMarginConfig)
            .where(
                BaseMarginConfig.customer_name == customer_name,
                BaseMarginConfig.customer_subname == customer_subname,
                BaseMarginConfig.pickup_country == pickup_country,
                BaseMarginConfig.pickup_state == pickup_state,
                BaseMarginConfig.pickup_city == pickup_city,
                BaseMarginConfig.pickup_postal_code == pickup_postal_code,
                BaseMarginConfig.drop_country == drop_country,
                BaseMarginConfig.drop_state == drop_state,
                BaseMarginConfig.drop_city == drop_city,
                BaseMarginConfig.drop_postal_code == drop_postal_code,
            )
        )
        if exclude_uuid is not None:
            stmt = stmt.where(BaseMarginConfig.uuid != exclude_uuid)

        result = await session.exec(stmt)
        return result.one()


async def save_config(record: BaseMarginConfig) -> BaseMarginConfig:
    async with get_db_session() as session:
        try:
            session.add(record)
            await session.commit()
            await session.refresh(record)
            return record
        except IntegrityError as exc:
            await session.rollback()
            raise DuplicateConfigError("An active configuration already exists for this combination.") from exc


async def delete_config(uuid_val: uuid_lib.UUID) -> None:
    async with get_db_session() as session:
        stmt = (
            select(BaseMarginConfig)
            .where(BaseMarginConfig.uuid == uuid_val)
            .order_by(col(BaseMarginConfig.version).desc())
            .limit(1)
        )
        result = await session.exec(stmt)
        record = result.first()
        if not record:
            raise ConfigNotFoundError(f"Configuration {uuid_val} not found.")
        await session.delete(record)
        await session.commit()
