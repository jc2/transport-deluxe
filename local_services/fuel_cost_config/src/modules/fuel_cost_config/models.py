import uuid as uuid_lib
from datetime import datetime, timezone
from decimal import Decimal
from enum import Enum
from typing import Generic, TypeVar

from pydantic import field_validator, model_validator
from sqlmodel import Field, SQLModel


class TruckType(str, Enum):
    flatbed = "flatbed"
    reefer = "reefer"
    dryvan = "dryvan"


class FuelCostConfig(SQLModel, table=True):
    __tablename__ = "fuel_cost_config"

    uuid: uuid_lib.UUID = Field(sa_column_kwargs={"primary_key": True})
    version: int = Field(sa_column_kwargs={"primary_key": True})
    customer_name: str | None = Field(default=None, max_length=255)
    customer_subname: str | None = Field(default=None, max_length=255)
    truck_type: str = Field(max_length=50)
    fuel_cost_per_km: Decimal = Field(max_digits=10, decimal_places=4)
    created_by: str = Field(max_length=255)
    created_at: datetime = Field(default_factory=lambda: datetime.now(timezone.utc).replace(tzinfo=None))


class CustomerField(SQLModel):
    name: str
    subname: str | None = None


class FuelCostConfigResponse(SQLModel):
    uuid: uuid_lib.UUID
    version: int
    customer: CustomerField | None
    truck_type: TruckType
    fuel_cost_per_km: Decimal
    created_by: str
    created_at: datetime

    @classmethod
    def from_orm_row(cls, row: FuelCostConfig) -> "FuelCostConfigResponse":
        customer = None
        if row.customer_name is not None:
            customer = CustomerField(name=row.customer_name, subname=row.customer_subname)
        return cls(
            uuid=row.uuid,
            version=row.version,
            customer=customer,
            truck_type=TruckType(row.truck_type),
            fuel_cost_per_km=row.fuel_cost_per_km,
            created_by=row.created_by,
            created_at=row.created_at,
        )


T = TypeVar("T")


class PaginatedResponse(SQLModel, Generic[T]):
    data: list[T]
    page: int
    page_size: int
    total: int
    total_pages: int


class CreateRequest(SQLModel):
    customer: CustomerField | None = None
    truck_type: TruckType
    fuel_cost_per_km: Decimal

    @field_validator("fuel_cost_per_km")
    @classmethod
    def fuel_cost_must_be_positive(cls, v: Decimal) -> Decimal:
        if v <= 0:
            raise ValueError("fuel_cost_per_km must be greater than 0")
        return v

    @model_validator(mode="after")
    def subname_requires_name(self) -> "CreateRequest":
        if self.customer is not None and self.customer.subname is not None and self.customer.name is None:
            raise ValueError("customer.subname requires customer.name to be set")
        return self


class UpdateRequest(SQLModel):
    fuel_cost_per_km: Decimal

    @field_validator("fuel_cost_per_km")
    @classmethod
    def fuel_cost_must_be_positive(cls, v: Decimal) -> Decimal:
        if v <= 0:
            raise ValueError("fuel_cost_per_km must be greater than 0")
        return v


class ResolveRequest(SQLModel):
    customer: CustomerField | None = None
    truck_type: TruckType
