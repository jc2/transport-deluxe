import pytest
from sqlalchemy.exc import IntegrityError
from sqlmodel.ext.asyncio.session import AsyncSession
from src.modules.base_margin_config.models import BaseMarginConfig


@pytest.mark.asyncio
async def test_customer_name_required(test_db):
    config = BaseMarginConfig(
        version=1,
        customer_subname="Sub",
        margin_percent=0.1,
        created_by="test",
    )
    async with AsyncSession(test_db) as session:
        session.add(config)
        with pytest.raises(IntegrityError):
            await session.commit()


@pytest.mark.asyncio
async def test_pickup_country_required_for_state(test_db):
    config = BaseMarginConfig(
        version=1,
        pickup_state="TX",
        margin_percent=0.1,
        created_by="test",
    )
    async with AsyncSession(test_db) as session:
        session.add(config)
        with pytest.raises(IntegrityError):
            await session.commit()


@pytest.mark.asyncio
async def test_drop_city_required_for_postal(test_db):
    config = BaseMarginConfig(
        version=1,
        drop_country="US",
        drop_state="CA",
        drop_postal_code="90210",
        margin_percent=0.1,
        created_by="test",
    )
    async with AsyncSession(test_db) as session:
        session.add(config)
        with pytest.raises(IntegrityError):
            await session.commit()


@pytest.mark.asyncio
async def test_at_least_one_field_required(test_db):
    config = BaseMarginConfig(
        version=1,
        margin_percent=0.1,
        created_by="test",
    )
    async with AsyncSession(test_db) as session:
        session.add(config)
        with pytest.raises(IntegrityError):
            await session.commit()
