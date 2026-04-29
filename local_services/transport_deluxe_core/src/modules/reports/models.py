import uuid as uuid_lib
from datetime import datetime, timezone
from typing import Any

from pydantic import ConfigDict
from sqlmodel import JSON, Column, Field, SQLModel


class CostingAudit(SQLModel, table=True):
    __tablename__ = "costing_audit"
    __table_args__ = {"schema": "costing_engine", "extend_existing": True}

    id: int | None = Field(default=None, primary_key=True)
    correlation_id: uuid_lib.UUID = Field(index=True)
    step_name: str = Field(max_length=255)
    step_type: str = Field(max_length=50)
    input: dict[str, Any] = Field(default_factory=dict, sa_column=Column(JSON))
    output: Any = Field(default=None, sa_column=Column(JSON))
    timestamp: datetime = Field(default_factory=lambda: datetime.now(timezone.utc).replace(tzinfo=None))

    model_config = ConfigDict(arbitrary_types_allowed=True)


class MarginAudit(SQLModel, table=True):
    __tablename__ = "margin_audit"
    __table_args__ = {"schema": "margin_engine", "extend_existing": True}

    id: int | None = Field(default=None, primary_key=True)
    correlation_id: uuid_lib.UUID = Field(index=True)
    step_name: str = Field(max_length=255)
    step_type: str = Field(max_length=50)
    input: dict[str, Any] = Field(default_factory=dict, sa_column=Column(JSON))
    output: Any = Field(default=None, sa_column=Column(JSON))
    timestamp: datetime = Field(default_factory=lambda: datetime.now(timezone.utc).replace(tzinfo=None))

    model_config = ConfigDict(arbitrary_types_allowed=True)


class PricingAudit(SQLModel, table=True):
    __tablename__ = "pricing_audit"
    __table_args__ = {"schema": "pricing_engine", "extend_existing": True}

    id: int | None = Field(default=None, primary_key=True)
    correlation_id: uuid_lib.UUID = Field(index=True)
    step_name: str = Field(max_length=255)
    step_type: str = Field(max_length=50)
    input: dict[str, Any] = Field(default_factory=dict, sa_column=Column(JSON))
    output: Any = Field(default=None, sa_column=Column(JSON))
    timestamp: datetime = Field(default_factory=lambda: datetime.now(timezone.utc).replace(tzinfo=None))

    model_config = ConfigDict(arbitrary_types_allowed=True)


class BreakdownRow(SQLModel):
    engine: str
    correlation_id: uuid_lib.UUID
    step_name: str
    step_type: str
    input: Any
    output: Any
    timestamp: datetime


class BreakdownResponse(SQLModel):
    correlation_id: uuid_lib.UUID
    rows: list[BreakdownRow]
