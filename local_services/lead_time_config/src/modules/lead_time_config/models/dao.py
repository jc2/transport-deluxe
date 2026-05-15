import uuid as uuid_lib
from datetime import datetime, timezone
from decimal import Decimal

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
