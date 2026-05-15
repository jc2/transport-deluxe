import uuid as uuid_lib
from datetime import datetime

from pydantic import BaseModel, field_validator, model_validator

from .dao import BaseMarginConfig, Customer, Stop


class BaseMarginConfigResponse(BaseModel):
    uuid: uuid_lib.UUID
    version: int
    customer: Customer | None
    pickup: Stop | None
    drop: Stop | None
    margin_percent: float
    created_by: str
    created_at: datetime

    @classmethod
    def from_dao(cls, row: BaseMarginConfig) -> "BaseMarginConfigResponse":
        customer = None
        if row.customer_name is not None or row.customer_subname is not None:
            customer = Customer(name=row.customer_name or "", subname=row.customer_subname)

        pickup = None
        if row.pickup_country or row.pickup_state or row.pickup_city or row.pickup_postal_code:
            pickup = Stop(
                country=row.pickup_country or "",
                state=row.pickup_state or "",
                city=row.pickup_city or "",
                postal_code=row.pickup_postal_code or "",
            )

        drop = None
        if row.drop_country or row.drop_state or row.drop_city or row.drop_postal_code:
            drop = Stop(
                country=row.drop_country or "",
                state=row.drop_state or "",
                city=row.drop_city or "",
                postal_code=row.drop_postal_code or "",
            )

        return cls(
            uuid=row.uuid,
            version=row.version,
            customer=customer,
            pickup=pickup,
            drop=drop,
            margin_percent=row.margin_percent,
            created_by=row.created_by,
            created_at=row.created_at,
        )


class BaseMarginConfigRequest(BaseModel):
    customer: Customer | None = None
    pickup: Stop | None = None
    drop: Stop | None = None
    margin_percent: float

    @field_validator("margin_percent")
    @classmethod
    def margin_must_be_valid(cls, v: float) -> float:
        if v < 0 or v > 0.99:
            raise ValueError("margin_percent must be between 0 and 0.99")
        return v

    @model_validator(mode="after")
    def subname_requires_name(self) -> "BaseMarginConfigRequest":
        if self.customer is not None and self.customer.subname is not None and self.customer.name is None:
            raise ValueError("customer.subname requires customer.name to be set")
        return self

    @model_validator(mode="after")
    def check_at_least_one_field(self) -> "BaseMarginConfigRequest":
        has_cust = self.customer and (self.customer.name or self.customer.subname)
        has_pickup = self.pickup and (
            self.pickup.country or self.pickup.state or self.pickup.city or self.pickup.postal_code
        )
        has_drop = self.drop and (self.drop.country or self.drop.state or self.drop.city or self.drop.postal_code)

        if not (has_cust or has_pickup or has_drop):
            raise ValueError(
                "At least one attribute (Customer or Geolocation) must be specified. "
                "A configuration cannot have all fields empty."
            )
        return self


class CreateRequest(BaseMarginConfigRequest):
    pass


class UpdateRequest(BaseMarginConfigRequest):
    pass


class ResolveRequest(BaseModel):
    customer: Customer | None = None
    pickup: Stop | None = None
    drop: Stop | None = None
