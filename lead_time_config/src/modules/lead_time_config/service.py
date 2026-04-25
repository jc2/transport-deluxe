import logging
import uuid as uuid_lib

from fastapi import HTTPException
from sqlalchemy import func, text
from sqlalchemy.exc import IntegrityError
from sqlmodel import col, select
from sqlmodel.ext.asyncio.session import AsyncSession

from src.modules.lead_time_config.models import (
    CreateRequest,
    LeadTimeConfig,
    LeadTimeConfigResponse,
    PaginatedResponse,
    ResolveRequest,
    UpdateRequest,
)

logger = logging.getLogger(__name__)


async def list_configs(
    session: AsyncSession,
    uuid: uuid_lib.UUID | None,
    page: int,
    page_size: int,
) -> PaginatedResponse[LeadTimeConfigResponse]:
    stmt = select(LeadTimeConfig)

    if uuid is None:
        # Get only the latest version for each uuid using DISTINCT ON
        stmt = stmt.distinct(col(LeadTimeConfig.uuid)).order_by(
            col(LeadTimeConfig.uuid), col(LeadTimeConfig.version).desc()
        )
    else:
        stmt = stmt.where(LeadTimeConfig.uuid == uuid).order_by(col(LeadTimeConfig.version).asc())

    count_stmt = select(func.count()).select_from(stmt.subquery())
    total_result = await session.exec(count_stmt)
    total = total_result.one()

    stmt = stmt.offset((page - 1) * page_size).limit(page_size)
    result = await session.exec(stmt)
    rows = result.all()

    total_pages = max(1, (total + page_size - 1) // page_size)

    logger.info("list_configs returned %d items (page=%d)", len(rows), page)
    return PaginatedResponse(
        data=[LeadTimeConfigResponse.from_orm_row(r) for r in rows],
        page=page,
        page_size=page_size,
        total=total,
        total_pages=total_pages,
    )


async def get_config(
    session: AsyncSession,
    uuid: uuid_lib.UUID,
) -> LeadTimeConfigResponse:
    stmt = (
        select(LeadTimeConfig).where(LeadTimeConfig.uuid == uuid).order_by(col(LeadTimeConfig.version).desc()).limit(1)
    )
    result = await session.exec(stmt)
    row = result.first()
    if row is None:
        raise HTTPException(
            status_code=404,
            detail={
                "status": 404,
                "messages": ["No active configuration found for this UUID"],
            },
        )
    logger.info("get_config found uuid=%s version=%s", uuid, row.version)
    return LeadTimeConfigResponse.from_orm_row(row)


async def create_config(
    session: AsyncSession,
    request: CreateRequest,
    created_by: str,
) -> LeadTimeConfigResponse:
    # Optional logic: verify no identical active configurations exist to avoid pure duplication
    stmt = (
        select(func.count())
        .select_from(LeadTimeConfig)
        .where(
            LeadTimeConfig.min_days == request.min_days,
            LeadTimeConfig.max_days == request.max_days,
        )
    )
    count_result = await session.exec(stmt)
    if count_result.one() > 0:
        raise HTTPException(
            status_code=409,
            detail={
                "status": 409,
                "messages": ["A configuration already exists for this min/max combination"],
            },
        )

    new_uuid = uuid_lib.uuid4()
    row = LeadTimeConfig(
        uuid=new_uuid,
        version=1,
        min_days=request.min_days,
        max_days=request.max_days,
        configuration_factor=request.configuration_factor,
        created_by=created_by,
    )
    session.add(row)
    try:
        await session.commit()
    except IntegrityError:
        await session.rollback()
        raise HTTPException(
            status_code=409,
            detail={
                "status": 409,
                "messages": ["An active configuration already exists for this combination"],
            },
        )
    await session.refresh(row)

    logger.info(
        "create_config created uuid=%s rule=[%s, %s] created_by=%s",
        new_uuid,
        request.min_days,
        request.max_days,
        created_by,
    )
    return LeadTimeConfigResponse.from_orm_row(row)


async def update_config(
    session: AsyncSession,
    uuid: uuid_lib.UUID,
    request: UpdateRequest,
    created_by: str,
) -> LeadTimeConfigResponse:
    stmt = (
        select(LeadTimeConfig)
        .where(LeadTimeConfig.uuid == uuid)
        .order_by(col(LeadTimeConfig.version).desc())
        .limit(1)
        .with_for_update()
    )
    result = await session.exec(stmt)
    current = result.first()
    if current is None:
        raise HTTPException(
            status_code=404,
            detail={
                "status": 404,
                "messages": ["No active configuration found for this UUID"],
            },
        )

    new_version = current.version + 1
    new_row = LeadTimeConfig(
        uuid=uuid,
        version=new_version,
        min_days=current.min_days,
        max_days=current.max_days,
        configuration_factor=request.configuration_factor,
        created_by=created_by,
    )
    session.add(new_row)
    await session.commit()
    await session.refresh(new_row)

    logger.info(
        "update_config uuid=%s new_version=%s created_by=%s",
        uuid,
        new_version,
        created_by,
    )
    return LeadTimeConfigResponse.from_orm_row(new_row)


async def resolve_config(
    session: AsyncSession,
    request: ResolveRequest,
) -> LeadTimeConfigResponse:
    days = request.days_to_shipment

    stmt = text("""
        SELECT uuid, version, min_days, max_days, configuration_factor, created_by, created_at
        FROM lead_time_config
        WHERE min_days <= :days
          AND (max_days IS NULL OR max_days >= :days)
        ORDER BY version DESC
        LIMIT 1
    """)

    result = await session.exec(stmt.bindparams(days=days))  # type: ignore[call-overload]
    row = result.first()

    if row is None:
        logger.warning(
            "resolve_config found no match for days_to_shipment=%s",
            days,
        )
        raise HTTPException(
            status_code=400,
            detail={
                "status": 400,
                "messages": ["No active lead time configuration found for the given shipment date"],
            },
        )

    config = LeadTimeConfig(
        uuid=row.uuid,
        version=row.version,
        min_days=row.min_days,
        max_days=row.max_days,
        configuration_factor=row.configuration_factor,
        created_by=row.created_by,
        created_at=row.created_at,
    )
    logger.info("resolve_config matched uuid=%s version=%s for days=%s", config.uuid, config.version, days)
    return LeadTimeConfigResponse.from_orm_row(config)
