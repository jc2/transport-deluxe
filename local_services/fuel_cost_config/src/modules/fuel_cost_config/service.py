import logging
import uuid as uuid_lib

from fastapi import HTTPException
from sqlalchemy import func, text
from sqlalchemy.exc import IntegrityError
from sqlmodel import col, select
from sqlmodel.ext.asyncio.session import AsyncSession

from src.modules.fuel_cost_config.models import (
    CreateRequest,
    FuelCostConfig,
    FuelCostConfigResponse,
    PaginatedResponse,
    ResolveRequest,
    TruckType,
    UpdateRequest,
)

logger = logging.getLogger(__name__)


async def list_configs(
    session: AsyncSession,
    customer_name: str | None,
    customer_subname: str | None,
    truck_type: TruckType | None,
    uuid: uuid_lib.UUID | None,
    page: int,
    page_size: int,
) -> PaginatedResponse[FuelCostConfigResponse]:
    stmt = select(FuelCostConfig)

    if uuid is None:
        # Get only the latest version for each uuid using DISTINCT ON
        stmt = stmt.distinct(col(FuelCostConfig.uuid)).order_by(
            col(FuelCostConfig.uuid), col(FuelCostConfig.version).desc()
        )
    else:
        stmt = stmt.order_by(col(FuelCostConfig.version).asc())

    if customer_name is not None:
        stmt = stmt.where(FuelCostConfig.customer_name == customer_name)
    if customer_subname is not None:
        stmt = stmt.where(FuelCostConfig.customer_subname == customer_subname)
    if truck_type is not None:
        stmt = stmt.where(FuelCostConfig.truck_type == truck_type.value)

    count_stmt = select(func.count()).select_from(stmt.subquery())
    total_result = await session.exec(count_stmt)
    total = total_result.one()

    stmt = stmt.offset((page - 1) * page_size).limit(page_size)
    result = await session.exec(stmt)
    rows = result.all()

    total_pages = max(1, (total + page_size - 1) // page_size)

    logger.info("list_configs returned %d items (page=%d)", len(rows), page)
    return PaginatedResponse(
        data=[FuelCostConfigResponse.from_orm_row(r) for r in rows],
        page=page,
        page_size=page_size,
        total=total,
        total_pages=total_pages,
    )


async def get_config(
    session: AsyncSession,
    uuid: uuid_lib.UUID,
) -> FuelCostConfigResponse:
    stmt = (
        select(FuelCostConfig)
        .where(FuelCostConfig.uuid == uuid)  # noqa: E712
        .order_by(col(FuelCostConfig.version).desc())
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
    return FuelCostConfigResponse.from_orm_row(row)


async def create_config(
    session: AsyncSession,
    request: CreateRequest,
    created_by: str,
) -> FuelCostConfigResponse:
    customer_name = request.customer.name if request.customer else None
    customer_subname = request.customer.subname if request.customer else None

    stmt = (
        select(func.count())
        .select_from(FuelCostConfig)
        .where(
            FuelCostConfig.customer_name == customer_name,
            FuelCostConfig.customer_subname == customer_subname,
            FuelCostConfig.truck_type == request.truck_type.value,
        )
    )
    count_result = await session.exec(stmt)
    if count_result.one() > 0:
        raise HTTPException(
            status_code=409,
            detail={
                "status": 409,
                "messages": ["A configuration already exists for this combination"],
            },
        )

    new_uuid = uuid_lib.uuid4()
    row = FuelCostConfig(
        uuid=new_uuid,
        version=1,
        customer_name=customer_name,
        customer_subname=customer_subname,
        truck_type=request.truck_type.value,
        fuel_cost_per_km=request.fuel_cost_per_km,
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
        "create_config created uuid=%s truck_type=%s created_by=%s",
        new_uuid,
        request.truck_type,
        created_by,
    )
    return FuelCostConfigResponse.from_orm_row(row)


async def update_config(
    session: AsyncSession,
    uuid: uuid_lib.UUID,
    request: UpdateRequest,
    created_by: str,
) -> FuelCostConfigResponse:
    stmt = (
        select(FuelCostConfig)
        .where(FuelCostConfig.uuid == uuid)  # noqa: E712
        .order_by(col(FuelCostConfig.version).desc())
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
    new_row = FuelCostConfig(
        uuid=uuid,
        version=new_version,
        customer_name=current.customer_name,
        customer_subname=current.customer_subname,
        truck_type=current.truck_type,
        fuel_cost_per_km=request.fuel_cost_per_km,
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
    return FuelCostConfigResponse.from_orm_row(new_row)


async def deactivate_config(
    session: AsyncSession,
    uuid: uuid_lib.UUID,
) -> None:
    stmt = (
        select(FuelCostConfig)
        .where(FuelCostConfig.uuid == uuid)  # noqa: E712
        .order_by(col(FuelCostConfig.version).desc())
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

    if current.customer_name is None and current.customer_subname is None:
        count_stmt = select(func.count()).where(
            FuelCostConfig.customer_name == None,  # noqa: E711
            FuelCostConfig.customer_subname == None,  # noqa: E711
            FuelCostConfig.truck_type == current.truck_type,
        )
        count_result = await session.exec(count_stmt)
        count = count_result.one()
        if count <= 1:
            logger.warning(
                "deactivate_config blocked: last system baseline for truck_type=%s",
                current.truck_type,
            )
            raise HTTPException(
                status_code=400,
                detail={
                    "status": 400,
                    "messages": [
                        "Cannot deactivate the last active System-level configuration "
                        f"for truck type '{current.truck_type}'"
                    ],
                },
            )

    await session.commit()
    logger.info("deactivate_config uuid=%s version=%s", uuid, current.version)


async def resolve_config(
    session: AsyncSession,
    request: ResolveRequest,
) -> FuelCostConfigResponse:
    customer_name = request.customer.name if request.customer else None
    customer_subname = request.customer.subname if request.customer else None
    truck_type = request.truck_type.value

    stmt = text("""
        SELECT uuid, version, customer_name, customer_subname, truck_type,
               fuel_cost_per_km, created_by, created_at
        FROM fuel_cost_config
        WHERE truck_type = :truck_type
          AND (
              (customer_name = :customer_name AND customer_subname = :customer_subname)
              OR (
                  customer_name = :customer_name
                  AND customer_subname IS NULL
                  AND :customer_subname IS NOT NULL
              )
              OR (customer_name IS NULL AND customer_subname IS NULL)
          )
        ORDER BY
            CASE
                WHEN customer_name = :customer_name
                     AND customer_subname = :customer_subname THEN 1
                WHEN customer_name = :customer_name AND customer_subname IS NULL THEN 2
                ELSE 3
            END,
            version DESC
        LIMIT 1
    """)

    result = await session.exec(  # type: ignore[call-overload]
        stmt.bindparams(
            truck_type=truck_type,
            customer_name=customer_name,
            customer_subname=customer_subname,
        )
    )
    row = result.first()

    if row is None:
        logger.warning(
            "resolve_config found no match for truck_type=%s customer=%s/%s",
            truck_type,
            customer_name,
            customer_subname,
        )
        raise HTTPException(
            status_code=400,
            detail={
                "status": 400,
                "messages": ["No active fuel cost configuration found for the given load"],
            },
        )

    config = FuelCostConfig(
        uuid=row.uuid,
        version=row.version,
        customer_name=row.customer_name,
        customer_subname=row.customer_subname,
        truck_type=row.truck_type,
        fuel_cost_per_km=row.fuel_cost_per_km,
        created_by=row.created_by,
        created_at=row.created_at,
    )
    logger.info("resolve_config matched uuid=%s version=%s", config.uuid, config.version)
    return FuelCostConfigResponse.from_orm_row(config)
