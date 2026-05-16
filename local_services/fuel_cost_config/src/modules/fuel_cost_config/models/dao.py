import uuid as uuid_lib
from datetime import datetime, timezone
from decimal import Decimal
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


class FuelCostConfig(SQLModel, table=True):
    __tablename__ = "fuel_cost_config"
    __table_args__ = (
        CheckConstraint(
            "customer_subname IS NULL OR customer_name IS NOT NULL",
            name="chk_fcc_customer_subname_requires_name",
        ),
    )

    uuid: uuid_lib.UUID = Field(sa_column_kwargs={"primary_key": True})
    version: int = Field(sa_column_kwargs={"primary_key": True})

    customer_name: str | None = Field(default=None, max_length=255)
    customer_subname: str | None = Field(default=None, max_length=255)
    truck_type: str = Field(max_length=50)
    fuel_cost_per_km: Decimal = Field(max_digits=10, decimal_places=4)

    created_by: str = Field(max_length=255)
    created_at: datetime = Field(default_factory=lambda: datetime.now(timezone.utc).replace(tzinfo=None))
