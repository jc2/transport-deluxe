import uuid as uuid_lib
from datetime import datetime, timezone
from decimal import Decimal
from typing import Generic, TypeVar

from pydantic import field_validator, model_validator
from sqlmodel import Field, SQLModel


class LeadTimeConfig(SQLModel, table=True):
    __tablename__ = "lead_time_config"

    uuid: uuid_lib.UUID = Field(sa_column_kwargs={"primary_key": True})
    version: int = Field(sa_column_kwargs={"primary_key": True})
    min_days: int = Field()
    max_days: int | None = Field(default=None)
    configuration_factor: Decimal = Field(max_digits=5, decimal_places=4)
    created_by: str = Field(max_length=255)
    created_at: datetime = Field(default_factory=lambda: datetime.now(timezone.utc).replace(tzinfo=None))


class LeadTimeConfigResponse(SQLModel):
    uuid: uuid_lib.UUID
    version: int
    min_days: int
    max_days: int | None
    configuration_factor: Decimal
    created_by: str
    created_at: datetime

    @classmethod
    def from_orm_row(cls, row: LeadTimeConfig) -> "LeadTimeConfigResponse":
        return cls(
            uuid=row.uuid,
            version=row.version,
            min_days=row.min_days,
            max_days=row.max_days,
            configuration_factor=row.configuration_factor,
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
    min_days: int
    max_days: int | None = None
    configuration_factor: Decimal

    @field_validator("min_days")
    @classmethod
    def validate_min_days(cls, v: int) -> int:
        if v < 0:
            raise ValueError("min_days cannot be negative")
        return v

    @model_validator(mode="after")
    def validate_range(self) -> "CreateRequest":
        if self.max_days is not None and self.min_days > self.max_days:
            raise ValueError("min_days cannot be greater than max_days")
        return self


class UpdateRequest(SQLModel):
    configuration_factor: Decimal


class ResolveRequest(SQLModel):
    days_to_shipment: int
