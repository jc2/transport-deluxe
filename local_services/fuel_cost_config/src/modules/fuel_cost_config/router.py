import uuid as uuid_lib
from typing import Annotated

from fastapi import APIRouter, Depends, Query, status

from ...tools.auth import VerifiedJwt
from .models import CreateRequest, FuelCostConfigResponse, ResolveRequest, TruckType, UpdateRequest
from .service import (
    create_fuel_cost_config,
    delete_fuel_cost_config,
    get_fuel_cost_config,
    list_fuel_cost_configs,
    resolve_fuel_cost_config,
    update_fuel_cost_config,
)


class ListFilterParams:
    def __init__(
        self,
        customer_name: str | None = Query(None),
        customer_subname: str | None = Query(None),
        truck_type: TruckType | None = Query(None),
    ):
        self.customer_name = customer_name
        self.customer_subname = customer_subname
        self.truck_type = truck_type


router = APIRouter(tags=["Fuel Cost Configuration"])


@router.post("", response_model=FuelCostConfigResponse, status_code=status.HTTP_201_CREATED)
async def create_config(req: CreateRequest, jwt: VerifiedJwt) -> FuelCostConfigResponse:
    created_by = jwt.get("preferred_username") or jwt.get("name") or jwt["sub"]
    return await create_fuel_cost_config(req, created_by)


@router.get("", response_model=list[FuelCostConfigResponse])
async def list_configs(
    jwt: VerifiedJwt, filters: Annotated[ListFilterParams, Depends()]
) -> list[FuelCostConfigResponse]:
    return await list_fuel_cost_configs(
        customer_name=filters.customer_name,
        customer_subname=filters.customer_subname,
        truck_type=filters.truck_type.value if filters.truck_type else None,
    )


@router.get("/{uuid}", response_model=FuelCostConfigResponse)
async def get_config(uuid: uuid_lib.UUID, jwt: VerifiedJwt) -> FuelCostConfigResponse:
    return await get_fuel_cost_config(uuid)


@router.put("/{uuid}", response_model=FuelCostConfigResponse)
async def update_config(uuid: uuid_lib.UUID, req: UpdateRequest, jwt: VerifiedJwt) -> FuelCostConfigResponse:
    created_by = jwt.get("preferred_username") or jwt.get("name") or jwt["sub"]
    return await update_fuel_cost_config(uuid, req, created_by)


@router.delete("/{uuid}", status_code=status.HTTP_204_NO_CONTENT)
async def delete_config(uuid: uuid_lib.UUID, jwt: VerifiedJwt) -> None:
    await delete_fuel_cost_config(uuid)


@router.post("/resolve", response_model=FuelCostConfigResponse)
async def resolve_config(req: ResolveRequest) -> FuelCostConfigResponse:
    return await resolve_fuel_cost_config(req)
