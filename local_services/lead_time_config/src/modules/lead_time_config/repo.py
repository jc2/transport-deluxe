import uuid as uuid_lib
from collections.abc import Sequence

from sqlalchemy import text
from sqlalchemy.exc import IntegrityError
from sqlmodel import col, func, select

from src.tools.db import get_db_session

from .exceptions import ConfigNotFoundError, DuplicateConfigError
from .models import LeadTimeConfig


async def get_config(uuid_val: uuid_lib.UUID) -> LeadTimeConfig:
    async with get_db_session() as session:
        stmt = (
            select(LeadTimeConfig)
            .where(LeadTimeConfig.uuid == uuid_val)
            .order_by(col(LeadTimeConfig.version).desc())
            .limit(1)
        )
        result = await session.exec(stmt)
        record = result.first()
        if not record:
            raise ConfigNotFoundError(f"Configuration {uuid_val} not found.")
        return record


async def list_configs(
    min_days: int | None = None,
    max_days: int | None = None,
) -> Sequence[LeadTimeConfig]:
    async with get_db_session() as session:
        stmt = (
            select(LeadTimeConfig)
            .distinct(col(LeadTimeConfig.uuid))
            .order_by(col(LeadTimeConfig.uuid), col(LeadTimeConfig.version).desc())
        )

        if min_days is not None:
            stmt = stmt.where(LeadTimeConfig.min_days == min_days)
        if max_days is not None:
            stmt = stmt.where(LeadTimeConfig.max_days == max_days)

        result = await session.exec(stmt)
        return result.all()


async def check_overlap(min_days: int, max_days: int | None, exclude_uuid: uuid_lib.UUID | None = None) -> bool:
    async with get_db_session() as session:
        exclude_clause = "AND uuid::text != :exclude_uuid" if exclude_uuid is not None else ""
        stmt = text(f"""
            SELECT COUNT(*)
            FROM (
                SELECT DISTINCT ON (uuid) *
                FROM lead_time_config
                ORDER BY uuid, version DESC
            ) AS latest_configs
            WHERE (:min_days <= COALESCE(max_days, 2147483647))
              AND (COALESCE(:max_days, 2147483647) >= min_days)
              {exclude_clause}
        """)
        params: dict[str, object] = {"min_days": min_days, "max_days": max_days}
        if exclude_uuid is not None:
            params["exclude_uuid"] = str(exclude_uuid)
        result = await session.execute(stmt.bindparams(**params))
        row = result.first()
        count = int(row[0]) if row else 0
        return count > 0


async def count_matching(min_days: int, max_days: int | None) -> int:
    async with get_db_session() as session:
        stmt = (
            select(func.count())
            .select_from(LeadTimeConfig)
            .where(LeadTimeConfig.min_days == min_days, LeadTimeConfig.max_days == max_days)
        )
        result = await session.exec(stmt)
        return result.one()


async def save_config(record: LeadTimeConfig) -> LeadTimeConfig:
    async with get_db_session() as session:
        try:
            session.add(record)
            await session.commit()
            await session.refresh(record)
            return record
        except IntegrityError as exc:
            await session.rollback()
            raise DuplicateConfigError("Already exists.") from exc


async def delete_config(uuid_val: uuid_lib.UUID) -> None:
    async with get_db_session() as session:
        stmt = (
            select(LeadTimeConfig)
            .where(LeadTimeConfig.uuid == uuid_val)
            .order_by(col(LeadTimeConfig.version).desc())
            .limit(1)
        )
        result = await session.exec(stmt)
        record = result.first()
        if not record:
            raise ConfigNotFoundError(f"Configuration {uuid_val} not found.")

        await session.delete(record)
        await session.commit()


async def get_all_active_configs() -> Sequence[LeadTimeConfig]:
    async with get_db_session() as session:
        stmt = (
            select(LeadTimeConfig)
            .distinct(col(LeadTimeConfig.uuid))
            .order_by(col(LeadTimeConfig.uuid), col(LeadTimeConfig.version).desc())
        )
        result = await session.exec(stmt)
        return result.all()
