import uuid as uuid_lib
from datetime import datetime, timezone
from decimal import Decimal
from typing import Generic, TypeVar

from pydantic import field_validator
from sqlmodel import Field, SQLModel


class DriverTariffConfig(SQLModel, table=True):
    __tablename__ = "driver_tariff_config"

    uuid: uuid_lib.UUID = Field(sa_column_kwargs={"primary_key": True})
    version: int = Field(sa_column_kwargs={"primary_key": True})
    pickup_state: str | None = Field(default=None, max_length=50)
    drop_state: str | None = Field(default=None, max_length=50)
    tariff_factor: Decimal = Field(max_digits=10, decimal_places=4)
    created_by: str = Field(max_length=255)
    created_at: datetime = Field(default_factory=lambda: datetime.now(timezone.utc).replace(tzinfo=None))


class DriverTariffConfigResponse(SQLModel):
    uuid: uuid_lib.UUID
    version: int
    pickup_state: str | None
    drop_state: str | None
    tariff_factor: Decimal
    created_by: str
    created_at: datetime

    @classmethod
    def from_orm_row(cls, row: DriverTariffConfig) -> "DriverTariffConfigResponse":
        return cls(
            uuid=row.uuid,
            version=row.version,
            pickup_state=row.pickup_state,
            drop_state=row.drop_state,
            tariff_factor=row.tariff_factor,
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
    pickup_state: str | None = Field(default=None, max_length=50)
    drop_state: str | None = Field(default=None, max_length=50)
    tariff_factor: Decimal

    @field_validator("tariff_factor")
    @classmethod
    def tariff_factor_must_be_positive(cls, v: Decimal) -> Decimal:
        if v <= 0:
            raise ValueError("tariff_factor must be greater than 0")
        return v


class UpdateRequest(SQLModel):
    tariff_factor: Decimal

    @field_validator("tariff_factor")
    @classmethod
    def tariff_factor_must_be_positive(cls, v: Decimal) -> Decimal:
        if v <= 0:
            raise ValueError("tariff_factor must be greater than 0")
        return v


class ResolveRequest(SQLModel):
    pickup_state: str
    drop_state: str
    # When resolving, the load explicitly has a pickup and drop state.
