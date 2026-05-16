import uuid as uuid_lib
from datetime import datetime
from decimal import Decimal
from typing import Optional

from pydantic import BaseModel, field_validator, model_validator

from .dao import Customer, FuelCostConfig, TruckType


class FuelCostConfigResponse(BaseModel):
    uuid: uuid_lib.UUID
    version: int
    customer: Customer | None
    truck_type: TruckType
    fuel_cost_per_km: Decimal
    created_by: str
    created_at: datetime

    @classmethod
    def from_dao(cls, row: FuelCostConfig) -> "FuelCostConfigResponse":
        customer = None
        if row.customer_name is not None:
            customer = Customer(name=row.customer_name, subname=row.customer_subname)
        return cls(
            uuid=row.uuid,
            version=row.version,
            customer=customer,
            truck_type=TruckType(row.truck_type),
            fuel_cost_per_km=row.fuel_cost_per_km,
            created_by=row.created_by,
            created_at=row.created_at,
        )


class FuelCostConfigRequest(BaseModel):
    customer: Customer | None = None
    truck_type: TruckType
    fuel_cost_per_km: Decimal

    @field_validator("fuel_cost_per_km")
    @classmethod
    def fuel_cost_must_be_positive(cls, v: Decimal) -> Decimal:
        if v <= 0:
            raise ValueError("fuel_cost_per_km must be greater than 0")
        return v

    @model_validator(mode="after")
    def subname_requires_name(self) -> "FuelCostConfigRequest":
        if self.customer is not None and self.customer.subname is not None and self.customer.name is None:
            raise ValueError("customer.subname requires customer.name to be set")
        return self


class CreateRequest(FuelCostConfigRequest):
    pass


class UpdateRequest(BaseModel):
    fuel_cost_per_km: Decimal

    @field_validator("fuel_cost_per_km")
    @classmethod
    def fuel_cost_must_be_positive(cls, v: Decimal) -> Decimal:
        if v <= 0:
            raise ValueError("fuel_cost_per_km must be greater than 0")
        return v


class ResolveRequest(BaseModel):
    customer: Optional[Customer] = None
    truck_type: TruckType
