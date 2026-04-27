import uuid as uuid_lib
from datetime import date, datetime, timezone
from decimal import Decimal
from enum import Enum
from typing import Any, Optional

from pydantic import ConfigDict
from sqlmodel import JSON, Column, Field, SQLModel


class TruckType(str, Enum):
    FLATBED = "Flatbed"
    REEFER = "Reefer"
    DRYVAN = "Dryvan"


class Customer(SQLModel):
    name: str = Field(max_length=255)
    subname: Optional[str] = Field(default=None, max_length=255)


class Stop(SQLModel):
    country: str = Field(max_length=255)
    state: str = Field(max_length=255)
    city: str = Field(max_length=255)
    postal_code: str = Field(max_length=255)
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


class MarginRequest(SQLModel):
    load: Load
    all_in_cost: Decimal


class StepType(str, Enum):
    ENRICHING = "enriching"
    FETCH_CONFIGURATION = "fetch_configuration"
    CALCULATE_ADJUSTMENT = "calculate_adjustment"
    EQUATION = "equation"


class MarginAudit(SQLModel, table=True):
    __tablename__ = "margin_audit"
    __table_args__ = {"extend_existing": True}

    id: int | None = Field(default=None, primary_key=True)
    correlation_id: uuid_lib.UUID = Field(index=True)
    step_name: str = Field(max_length=255)
    step_type: str = Field(max_length=50)
    input: dict[str, Any] = Field(default_factory=dict, sa_column=Column(JSON))
    output: Any = Field(default=None, sa_column=Column(JSON))
    timestamp: datetime = Field(default_factory=lambda: datetime.now(timezone.utc).replace(tzinfo=None))

    model_config = ConfigDict(arbitrary_types_allowed=True)


class MarginAdjustment(SQLModel):
    name: str
    amount: Decimal
    config_uuid: uuid_lib.UUID | None = None
    config_version: int | None = None


class MarginResponse(SQLModel):
    correlation_id: uuid_lib.UUID
    load: Load
    adjustments: list[MarginAdjustment]
    all_in_cost: Decimal
    all_in_margin: Decimal
