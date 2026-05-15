import uuid as uuid_lib
from datetime import date, datetime, timezone
from enum import Enum
from typing import Optional

from sqlalchemy import CheckConstraint
from sqlmodel import Field, SQLModel


class TruckType(str, Enum):
    FLATBED = "Flatbed"
    REEFER = "Reefer"
    DRYVAN = "Dryvan"


class Customer(SQLModel):
    name: str = Field(max_length=255)
    subname: Optional[str] = Field(default=None, max_length=255)


class Stop(SQLModel):
    country: str = Field(default="", max_length=255)
    state: str = Field(default="", max_length=255)
    city: str = Field(default="", max_length=255)
    postal_code: str = Field(default="", max_length=255)
    latitude: Optional[float] = None
    longitude: Optional[float] = None


class Route(SQLModel):
    pickup: Stop
    drop: Stop


class Load(SQLModel):
    route: Route
    customer: Customer
    truck_type: TruckType
    ship_date: date
    distance_km: Optional[float] = None


class BaseMarginConfig(SQLModel, table=True):
    __tablename__ = "base_margin_config"
    __table_args__ = (
        # Customer hierarchy
        CheckConstraint(
            "customer_subname IS NULL OR customer_name IS NOT NULL", name="chk_customer_subname_requires_name"
        ),
        # Pickup hierarchy
        CheckConstraint("pickup_state IS NULL OR pickup_country IS NOT NULL", name="chk_pickup_state_requires_country"),
        CheckConstraint("pickup_city IS NULL OR pickup_state IS NOT NULL", name="chk_pickup_city_requires_state"),
        CheckConstraint(
            "pickup_postal_code IS NULL OR pickup_city IS NOT NULL", name="chk_pickup_postal_requires_city"
        ),
        # Drop hierarchy
        CheckConstraint("drop_state IS NULL OR drop_country IS NOT NULL", name="chk_drop_state_requires_country"),
        CheckConstraint("drop_city IS NULL OR drop_state IS NOT NULL", name="chk_drop_city_requires_state"),
        CheckConstraint("drop_postal_code IS NULL OR drop_city IS NOT NULL", name="chk_drop_postal_requires_city"),
        # At least one definition
        CheckConstraint(
            "customer_name IS NOT NULL OR pickup_country IS NOT NULL OR drop_country IS NOT NULL",
            name="chk_at_least_one_field",
        ),
    )

    uuid: uuid_lib.UUID = Field(sa_column_kwargs={"primary_key": True})
    version: int = Field(sa_column_kwargs={"primary_key": True})

    customer_name: str | None = Field(default=None, max_length=255)
    customer_subname: str | None = Field(default=None, max_length=255)

    pickup_country: str | None = Field(default=None, max_length=255)
    pickup_state: str | None = Field(default=None, max_length=255)
    pickup_city: str | None = Field(default=None, max_length=255)
    pickup_postal_code: str | None = Field(default=None, max_length=255)

    drop_country: str | None = Field(default=None, max_length=255)
    drop_state: str | None = Field(default=None, max_length=255)
    drop_city: str | None = Field(default=None, max_length=255)
    drop_postal_code: str | None = Field(default=None, max_length=255)

    margin_percent: float = Field(default=0.0)

    created_by: str = Field(max_length=255)
    created_at: datetime = Field(default_factory=lambda: datetime.now(timezone.utc).replace(tzinfo=None))
