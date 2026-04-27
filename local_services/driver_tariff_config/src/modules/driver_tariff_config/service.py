import logging
import uuid as uuid_lib

from fastapi import HTTPException
from sqlalchemy import func, text
from sqlalchemy.exc import IntegrityError
from sqlmodel import col, select
from sqlmodel.ext.asyncio.session import AsyncSession

from src.modules.driver_tariff_config.models import (
    CreateRequest,
    DriverTariffConfig,
    DriverTariffConfigResponse,
    PaginatedResponse,
    ResolveRequest,
    UpdateRequest,
)

logger = logging.getLogger(__name__)


async def list_configs(
    session: AsyncSession,
    pickup_state: str | None,
    drop_state: str | None,
    uuid: uuid_lib.UUID | None,
    page: int,
    page_size: int,
) -> PaginatedResponse[DriverTariffConfigResponse]:
    stmt = select(DriverTariffConfig)

    if uuid is None:
        # Get only the latest version for each uuid using DISTINCT ON
        stmt = stmt.distinct(col(DriverTariffConfig.uuid)).order_by(
            col(DriverTariffConfig.uuid), col(DriverTariffConfig.version).desc()
        )
    else:
        stmt = stmt.order_by(col(DriverTariffConfig.version).asc())

    if pickup_state is not None:
        stmt = stmt.where(DriverTariffConfig.pickup_state == pickup_state)
    if drop_state is not None:
        stmt = stmt.where(DriverTariffConfig.drop_state == drop_state)

    count_stmt = select(func.count()).select_from(stmt.subquery())
    total_result = await session.exec(count_stmt)
    total = total_result.one()

    stmt = stmt.offset((page - 1) * page_size).limit(page_size)
    result = await session.exec(stmt)
    rows = result.all()

    total_pages = max(1, (total + page_size - 1) // page_size)

    logger.info("list_configs returned %d items (page=%d)", len(rows), page)
    return PaginatedResponse(
        data=[DriverTariffConfigResponse.from_orm_row(r) for r in rows],
        page=page,
        page_size=page_size,
        total=total,
        total_pages=total_pages,
    )


async def get_config(
    session: AsyncSession,
    uuid: uuid_lib.UUID,
) -> DriverTariffConfigResponse:
    stmt = (
        select(DriverTariffConfig)
        .where(DriverTariffConfig.uuid == uuid)  # noqa: E712
        .order_by(col(DriverTariffConfig.version).desc())
        .limit(1)
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
    return DriverTariffConfigResponse.from_orm_row(row)


async def create_config(
    session: AsyncSession,
    request: CreateRequest,
    created_by: str,
) -> DriverTariffConfigResponse:
    stmt = (
        select(func.count())
        .select_from(DriverTariffConfig)
        .where(
            DriverTariffConfig.pickup_state == request.pickup_state,
            DriverTariffConfig.drop_state == request.drop_state,
        )
    )
    count_result = await session.exec(stmt)
    if count_result.one() > 0:
        raise HTTPException(
            status_code=409,
            detail={
                "status": 409,
                "messages": ["A configuration already exists for this pickup and drop state combination"],
            },
        )

    new_uuid = uuid_lib.uuid4()
    row = DriverTariffConfig(
        uuid=new_uuid,
        version=1,
        pickup_state=request.pickup_state,
        drop_state=request.drop_state,
        tariff_factor=request.tariff_factor,
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
        "create_config created uuid=%s created_by=%s",
        new_uuid,
        created_by,
    )
    return DriverTariffConfigResponse.from_orm_row(row)


async def update_config(
    session: AsyncSession,
    uuid: uuid_lib.UUID,
    request: UpdateRequest,
    created_by: str,
) -> DriverTariffConfigResponse:
    stmt = (
        select(DriverTariffConfig)
        .where(DriverTariffConfig.uuid == uuid)  # noqa: E712
        .order_by(col(DriverTariffConfig.version).desc())
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
    new_row = DriverTariffConfig(
        uuid=uuid,
        version=new_version,
        pickup_state=current.pickup_state,
        drop_state=current.drop_state,
        tariff_factor=request.tariff_factor,
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
    return DriverTariffConfigResponse.from_orm_row(new_row)


async def deactivate_config(
    session: AsyncSession,
    uuid: uuid_lib.UUID,
) -> None:
    stmt = (
        select(DriverTariffConfig).where(DriverTariffConfig.uuid == uuid)  # noqa: E712
    )
    result = await session.exec(stmt)
    rows = result.all()
    if not rows:
        raise HTTPException(
            status_code=404,
            detail={
                "status": 404,
                "messages": ["No active configuration found for this UUID"],
            },
        )

    for row in rows:
        await session.delete(row)
    await session.commit()
    logger.info("deactivate_config deleted uuid=%s entirely", uuid)


async def resolve_config(
    session: AsyncSession,
    request: ResolveRequest,
) -> DriverTariffConfigResponse:
    pickup_state = request.load.route.pickup.state
    drop_state = request.load.route.drop.state

    # specific match (both states) = priority 1
    # origin default (pickup, no drop) = priority 2
    # destination default (no pickup, drop) = priority 3
    # distinct on uuid using greatest version

    stmt = text("""
        SELECT uuid, version, pickup_state, drop_state, tariff_factor, created_by, created_at
        FROM driver_tariff_config
        WHERE (pickup_state = :pickup_state AND drop_state = :drop_state)
           OR (pickup_state = :pickup_state AND drop_state IS NULL)
           OR (pickup_state IS NULL AND drop_state = :drop_state)
           OR (pickup_state IS NULL AND drop_state IS NULL)
        ORDER BY
            CASE
                WHEN pickup_state = :pickup_state AND drop_state = :drop_state THEN 1
                WHEN pickup_state = :pickup_state AND drop_state IS NULL THEN 2
                WHEN pickup_state IS NULL AND drop_state = :drop_state THEN 3
                WHEN pickup_state IS NULL AND drop_state IS NULL THEN 4
            END,
            version DESC
        LIMIT 1
    """)

    result = await session.exec(  # type: ignore[call-overload]
        stmt.bindparams(
            pickup_state=pickup_state,
            drop_state=drop_state,
        )
    )
    row = result.first()

    if row is None:
        logger.warning(
            "resolve_config found no match for Route %s -> %s",
            pickup_state,
            drop_state,
        )
        raise HTTPException(
            status_code=404,
            detail={
                "status": 404,
                "messages": ["No configuration resolves for this route combination"],
            },
        )

    return DriverTariffConfigResponse(
        uuid=row.uuid,
        version=row.version,
        pickup_state=row.pickup_state,
        drop_state=row.drop_state,
        tariff_factor=row.tariff_factor,
        created_by=row.created_by,
        created_at=row.created_at,
    )
