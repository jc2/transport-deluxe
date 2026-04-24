import uuid as uuid_lib
from typing import Annotated, Any

from fastapi import APIRouter, Depends, Query, Response
from sqlmodel.ext.asyncio.session import AsyncSession

from src.modules.fuel_cost_config import service
from src.modules.fuel_cost_config.models import (
    CreateRequest,
    FuelCostConfigResponse,
    PaginatedResponse,
    ResolveRequest,
    TruckType,
    UpdateRequest,
)
from src.tools.auth import verify_jwt
from src.tools.db import get_session

router = APIRouter()

SessionDep = Annotated[AsyncSession, Depends(get_session)]
JwtDep = Annotated[dict[str, Any], Depends(verify_jwt)]


@router.get("", response_model=PaginatedResponse[FuelCostConfigResponse])
async def list_configs(
    session: SessionDep,
    _jwt: JwtDep,
    page: Annotated[int, Query(ge=1)] = 1,
    page_size: Annotated[int, Query(ge=1, le=100)] = 20,
    customer_name: Annotated[str | None, Query()] = None,
    customer_subname: Annotated[str | None, Query()] = None,
    truck_type: Annotated[TruckType | None, Query()] = None,
    uuid: Annotated[uuid_lib.UUID | None, Query()] = None,
) -> PaginatedResponse[FuelCostConfigResponse]:
    return await service.list_configs(
        session=session,
        customer_name=customer_name,
        customer_subname=customer_subname,
        truck_type=truck_type,
        uuid=uuid,
        page=page,
        page_size=page_size,
    )


@router.get("/{uuid}", response_model=FuelCostConfigResponse)
async def get_config(
    uuid: uuid_lib.UUID,
    session: SessionDep,
    _jwt: JwtDep,
) -> FuelCostConfigResponse:
    return await service.get_config(session=session, uuid=uuid)


@router.post("", response_model=FuelCostConfigResponse, status_code=201)
async def create_config(
    request: CreateRequest,
    session: SessionDep,
    jwt: JwtDep,
) -> FuelCostConfigResponse:
    created_by = jwt.get("name", "unknown")
    return await service.create_config(session=session, request=request, created_by=created_by)


@router.put("/{uuid}", response_model=FuelCostConfigResponse)
async def update_config(
    uuid: uuid_lib.UUID,
    request: UpdateRequest,
    session: SessionDep,
    jwt: JwtDep,
) -> FuelCostConfigResponse:
    created_by = jwt.get("name", "unknown")
    return await service.update_config(session=session, uuid=uuid, request=request, created_by=created_by)


@router.delete("/{uuid}", status_code=204)
async def deactivate_config(
    uuid: uuid_lib.UUID,
    session: SessionDep,
    _jwt: JwtDep,
) -> Response:
    await service.deactivate_config(session=session, uuid=uuid)
    return Response(status_code=204)


@router.post("/resolve", response_model=FuelCostConfigResponse)
async def resolve_config(
    request: ResolveRequest,
    session: SessionDep,
) -> FuelCostConfigResponse:
    return await service.resolve_config(session=session, request=request)
