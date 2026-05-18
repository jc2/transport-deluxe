import uuid as uuid_lib
from typing import Annotated

from fastapi import APIRouter, Depends, Query, Response
from src.modules.driver_tariff_config.models import (
    CreateRequest,
    DriverTariffConfigResponse,
    ResolveRequest,
    UpdateRequest,
)
from src.modules.driver_tariff_config.service import (
    create_driver_tariff_config,
    delete_driver_tariff_config,
    get_driver_tariff_config,
    list_driver_tariff_configs,
    resolve_driver_tariff_config,
    update_driver_tariff_config,
)
from src.tools.auth import VerifiedJwt

router = APIRouter()


class ListFilterParams:
    def __init__(
        self,
        pickup_state: Annotated[str | None, Query(description="Filter by pickup state")] = None,
        drop_state: Annotated[str | None, Query(description="Filter by drop state")] = None,
    ) -> None:
        self.pickup_state = pickup_state
        self.drop_state = drop_state


@router.get("", response_model=list[DriverTariffConfigResponse])
async def list_configs(
    _jwt: VerifiedJwt,
    filters: Annotated[ListFilterParams, Depends()],
) -> list[DriverTariffConfigResponse]:
    return await list_driver_tariff_configs(
        pickup_state=filters.pickup_state,
        drop_state=filters.drop_state,
    )


@router.get("/{uuid}", response_model=DriverTariffConfigResponse)
async def get_config(
    uuid: uuid_lib.UUID,
    _jwt: VerifiedJwt,
) -> DriverTariffConfigResponse:
    return await get_driver_tariff_config(uuid)


@router.post("", response_model=DriverTariffConfigResponse, status_code=201)
async def create_config(
    request: CreateRequest,
    jwt: VerifiedJwt,
) -> DriverTariffConfigResponse:
    created_by = jwt.get("preferred_username") or jwt.get("name") or jwt["sub"]
    return await create_driver_tariff_config(request, created_by=created_by)


@router.put("/{uuid}", response_model=DriverTariffConfigResponse)
async def update_config(
    uuid: uuid_lib.UUID,
    request: UpdateRequest,
    jwt: VerifiedJwt,
) -> DriverTariffConfigResponse:
    created_by = jwt.get("preferred_username") or jwt.get("name") or jwt["sub"]
    return await update_driver_tariff_config(uuid, request, created_by=created_by)


@router.delete("/{uuid}", status_code=204)
async def delete_config(
    uuid: uuid_lib.UUID,
    _jwt: VerifiedJwt,
) -> Response:
    await delete_driver_tariff_config(uuid)
    return Response(status_code=204)


@router.post("/resolve", response_model=DriverTariffConfigResponse)
async def resolve_config(
    request: ResolveRequest,
) -> DriverTariffConfigResponse:
    return await resolve_driver_tariff_config(request)
