import uuid as uuid_lib
from datetime import datetime
from decimal import Decimal
from typing import Generic, TypeVar

from pydantic import BaseModel, field_validator, model_validator

from .dao import LeadTimeConfig


class LeadTimeConfigResponse(BaseModel):
    uuid: uuid_lib.UUID
    version: int
    min_days: int
    max_days: int | None
    configuration_factor: Decimal
    created_by: str
    created_at: datetime

    @classmethod
    def from_dao(cls, row: LeadTimeConfig) -> "LeadTimeConfigResponse":
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


class PaginatedResponse(BaseModel, Generic[T]):
    data: list[T]
    page: int
    page_size: int
    total: int
    total_pages: int


class CreateRequest(BaseModel):
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


class UpdateRequest(BaseModel):
    min_days: int | None = None
    max_days: int | None = None
    configuration_factor: Decimal | None = None

    @model_validator(mode="after")
    def validate_update(self) -> "UpdateRequest":
        if not self.model_fields_set:
            raise ValueError("At least one field must be provided for update")
        if self.min_days is not None and self.min_days < 0:
            raise ValueError("min_days cannot be negative")
        if (
            "min_days" in self.model_fields_set
            and "max_days" in self.model_fields_set
            and self.min_days is not None
            and self.max_days is not None
            and self.min_days > self.max_days
        ):
            raise ValueError("min_days cannot be greater than max_days")
        return self


class ResolveRequest(BaseModel):
    days_to_shipment: int
