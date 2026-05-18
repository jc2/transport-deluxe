import uuid as uuid_lib
from datetime import datetime
from decimal import Decimal

from pydantic import BaseModel, field_validator

from .dao import DriverTariffConfig, Load


class DriverTariffConfigResponse(BaseModel):
    uuid: uuid_lib.UUID
    version: int
    pickup_state: str | None
    drop_state: str | None
    tariff_factor: Decimal
    created_by: str
    created_at: datetime

    @classmethod
    def from_dao(cls, row: DriverTariffConfig) -> "DriverTariffConfigResponse":
        return cls(
            uuid=row.uuid,
            version=row.version,
            pickup_state=row.pickup_state,
            drop_state=row.drop_state,
            tariff_factor=row.tariff_factor,
            created_by=row.created_by,
            created_at=row.created_at,
        )


class CreateRequest(BaseModel):
    pickup_state: str | None = None
    drop_state: str | None = None
    tariff_factor: Decimal

    @field_validator("tariff_factor")
    @classmethod
    def tariff_factor_must_be_positive(cls, v: Decimal) -> Decimal:
        if v <= 0:
            raise ValueError("tariff_factor must be greater than 0")
        return v


class UpdateRequest(BaseModel):
    tariff_factor: Decimal

    @field_validator("tariff_factor")
    @classmethod
    def tariff_factor_must_be_positive(cls, v: Decimal) -> Decimal:
        if v <= 0:
            raise ValueError("tariff_factor must be greater than 0")
        return v


class ResolveRequest(BaseModel):
    load: Load
