import uuid
from collections.abc import Sequence
from typing import Optional

from fastapi import HTTPException
from sqlmodel import col, func, select
from sqlmodel.ext.asyncio.session import AsyncSession

from .models import (
    BaseMarginConfig,
    CreateRequest,
    ResolveRequest,
    Stop,
    UpdateRequest,
)


async def create_base_margin_config(
    session: AsyncSession, req: CreateRequest, created_by: str = "admin"
) -> BaseMarginConfig:
    c_name = req.customer.name if req.customer else None
    c_subname = req.customer.subname if req.customer else None

    p_country = req.pickup.country if req.pickup and req.pickup.country else None
    p_state = req.pickup.state if req.pickup and req.pickup.state else None
    p_city = req.pickup.city if req.pickup and req.pickup.city else None
    p_postal_code = req.pickup.postal_code if req.pickup and req.pickup.postal_code else None

    d_country = req.drop.country if req.drop and req.drop.country else None
    d_state = req.drop.state if req.drop and req.drop.state else None
    d_city = req.drop.city if req.drop and req.drop.city else None
    d_postal_code = req.drop.postal_code if req.drop and req.drop.postal_code else None

    stmt = (
        select(func.count())
        .select_from(BaseMarginConfig)
        .where(
            BaseMarginConfig.customer_name == c_name,
            BaseMarginConfig.customer_subname == c_subname,
            BaseMarginConfig.pickup_country == p_country,
            BaseMarginConfig.pickup_state == p_state,
            BaseMarginConfig.pickup_city == p_city,
            BaseMarginConfig.pickup_postal_code == p_postal_code,
            BaseMarginConfig.drop_country == d_country,
            BaseMarginConfig.drop_state == d_state,
            BaseMarginConfig.drop_city == d_city,
            BaseMarginConfig.drop_postal_code == d_postal_code,
        )
    )
    result = await session.exec(stmt)
    count = result.one()

    if count > 0:
        raise HTTPException(
            status_code=409, detail="A Base Margin Configuration already exists with these exact parameters."
        )

    record = BaseMarginConfig(
        uuid=uuid.uuid4(),
        version=1,
        customer_name=c_name,
        customer_subname=c_subname,
        pickup_country=p_country,
        pickup_state=p_state,
        pickup_city=p_city,
        pickup_postal_code=p_postal_code,
        drop_country=d_country,
        drop_state=d_state,
        drop_city=d_city,
        drop_postal_code=d_postal_code,
        margin_percent=req.margin_percent,
        created_by=created_by,
    )

    session.add(record)
    await session.commit()
    await session.refresh(record)
    return record


async def list_base_margin_configs(
    session: AsyncSession,
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


async def get_base_margin_config(session: AsyncSession, uuid_val: uuid.UUID) -> BaseMarginConfig:
    stmt = (
        select(BaseMarginConfig)
        .where(BaseMarginConfig.uuid == uuid_val)
        .order_by(col(BaseMarginConfig.version).desc())
        .limit(1)
    )
    result = await session.exec(stmt)
    record = result.first()
    if not record:
        raise HTTPException(status_code=404, detail="Configuration not found.")
    return record


async def update_base_margin_config(
    session: AsyncSession, uuid_val: uuid.UUID, req: UpdateRequest, created_by: str = "admin"
) -> BaseMarginConfig:
    current = await get_base_margin_config(session, uuid_val)

    c_name = req.customer.name if req.customer else None
    c_subname = req.customer.subname if req.customer else None

    p_country = req.pickup.country if req.pickup and req.pickup.country else None
    p_state = req.pickup.state if req.pickup and req.pickup.state else None
    p_city = req.pickup.city if req.pickup and req.pickup.city else None
    p_postal_code = req.pickup.postal_code if req.pickup and req.pickup.postal_code else None

    d_country = req.drop.country if req.drop and req.drop.country else None
    d_state = req.drop.state if req.drop and req.drop.state else None
    d_city = req.drop.city if req.drop and req.drop.city else None
    d_postal_code = req.drop.postal_code if req.drop and req.drop.postal_code else None

    stmt = (
        select(func.count())
        .select_from(BaseMarginConfig)
        .where(
            BaseMarginConfig.customer_name == c_name,
            BaseMarginConfig.customer_subname == c_subname,
            BaseMarginConfig.pickup_country == p_country,
            BaseMarginConfig.pickup_state == p_state,
            BaseMarginConfig.pickup_city == p_city,
            BaseMarginConfig.pickup_postal_code == p_postal_code,
            BaseMarginConfig.drop_country == d_country,
            BaseMarginConfig.drop_state == d_state,
            BaseMarginConfig.drop_city == d_city,
            BaseMarginConfig.drop_postal_code == d_postal_code,
            BaseMarginConfig.uuid != current.uuid,
        )
    )
    result = await session.exec(stmt)
    count = result.one()
    if count > 0:
        raise HTTPException(
            status_code=409, detail="A Base Margin Configuration already exists with these exact parameters."
        )

    new_version = current.version + 1
    new_record = BaseMarginConfig(
        uuid=current.uuid,
        version=new_version,
        customer_name=c_name,
        customer_subname=c_subname,
        pickup_country=p_country,
        pickup_state=p_state,
        pickup_city=p_city,
        pickup_postal_code=p_postal_code,
        drop_country=d_country,
        drop_state=d_state,
        drop_city=d_city,
        drop_postal_code=d_postal_code,
        margin_percent=req.margin_percent,
        created_by=created_by,
    )
    session.add(new_record)
    await session.commit()
    await session.refresh(new_record)
    return new_record


async def delete_base_margin_config(session: AsyncSession, uuid_val: uuid.UUID) -> None:
    current = await get_base_margin_config(session, uuid_val)
    # The actual implementation of append-only delete would insert something or just rely on a separate query.
    # For now, base_margin_config just raises 404 since we do not keep soft-deletion states anymore without is_deleted
    await session.delete(current)
    await session.commit()


async def resolve_base_margin_config(session: AsyncSession, req: ResolveRequest) -> Optional[BaseMarginConfig]:
    # Bring only active variables
    stmt = (
        select(BaseMarginConfig)
        .distinct(col(BaseMarginConfig.uuid))
        .order_by(col(BaseMarginConfig.uuid), col(BaseMarginConfig.version).desc())
    )
    result = await session.exec(stmt)
    all_configs = result.all()

    c_name = req.customer.name if req.customer else None
    c_subname = req.customer.subname if req.customer else None
    req_p = req.pickup if req.pickup else Stop()
    req_d = req.drop if req.drop else Stop()

    valid_matches = []

    # 1. Filter out configurations that CONTRADICT the request
    for c in all_configs:
        match = True

        # Identity match
        if c.customer_name is not None and c.customer_name != c_name:
            match = False
        if c.customer_subname is not None and (c_subname is None or c.customer_subname != c_subname):
            match = False

        # Pickup match
        if c.pickup_country is not None and c.pickup_country != (req_p.country or ""):
            if c.pickup_country != "":  # Allow match if DB has "" and request has ""
                match = False
        if c.pickup_state is not None and c.pickup_state != (req_p.state or ""):
            if c.pickup_state != "":
                match = False
        if c.pickup_city is not None and c.pickup_city != (req_p.city or ""):
            if c.pickup_city != "":
                match = False
        if c.pickup_postal_code is not None and c.pickup_postal_code != (req_p.postal_code or ""):
            if c.pickup_postal_code != "":
                match = False

        # Drop match
        if c.drop_country is not None and c.drop_country != (req_d.country or ""):
            if c.drop_country != "":
                match = False
        if c.drop_state is not None and c.drop_state != (req_d.state or ""):
            if c.drop_state != "":
                match = False
        if c.drop_city is not None and c.drop_city != (req_d.city or ""):
            if c.drop_city != "":
                match = False
        if c.drop_postal_code is not None and c.drop_postal_code != (req_d.postal_code or ""):
            if c.drop_postal_code != "":
                match = False

        if match:
            valid_matches.append(c)

    if not valid_matches:
        # Fallback for broad matches if No-Pickup/No-Drop configs exist (None in DB)
        # But wait, we just did that. Let's remove the prints to clean up.
        return None

    if not valid_matches:
        return None

    # 2. Priority Logic / Weight function
    def get_weight(c: BaseMarginConfig) -> int:
        weight = 0

        # Priority 1: Customer specifics (Most important)
        if c.customer_name is not None:
            weight += 100_000_000
        if c.customer_subname is not None:
            weight += 10_000_000

        has_pickup = any([c.pickup_country, c.pickup_state, c.pickup_city, c.pickup_postal_code])
        has_drop = any([c.drop_country, c.drop_state, c.drop_city, c.drop_postal_code])

        # Priority 2: Route configuration bounds (Full Route vs Single Point)
        if has_pickup and has_drop:
            weight += 1_000_000
        elif has_pickup or has_drop:
            weight += 100_000

        # Priority 3: Geographical Specificity / Depth
        # Country > State > City > Postal Code (in importance of depth match)
        if c.pickup_country is not None:
            weight += 1
        if c.pickup_state is not None:
            weight += 10
        if c.pickup_city is not None:
            weight += 100
        if c.pickup_postal_code is not None:
            weight += 1000

        if c.drop_country is not None:
            weight += 1
        if c.drop_state is not None:
            weight += 10
        if c.drop_city is not None:
            weight += 100
        if c.drop_postal_code is not None:
            weight += 1000

        return weight

    valid_matches.sort(key=get_weight, reverse=True)
    return valid_matches[0]
