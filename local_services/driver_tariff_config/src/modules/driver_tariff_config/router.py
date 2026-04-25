import uuid as uuid_lib
from typing import Annotated, Any

from fastapi import APIRouter, Depends, Query, Response
from sqlmodel.ext.asyncio.session import AsyncSession

from src.modules.driver_tariff_config import service
from src.modules.driver_tariff_config.models import (
    CreateRequest,
    DriverTariffConfigResponse,
    PaginatedResponse,
    ResolveRequest,
    UpdateRequest,
)
from src.tools.auth import verify_jwt
from src.tools.db import get_session

router = APIRouter()

SessionDep = Annotated[AsyncSession, Depends(get_session)]
JwtDep = Annotated[dict[str, Any], Depends(verify_jwt)]


@router.get("", response_model=PaginatedResponse[DriverTariffConfigResponse])
async def list_configs(
    session: SessionDep,
    _jwt: JwtDep,
    page: Annotated[int, Query(ge=1)] = 1,
    page_size: Annotated[int, Query(ge=1, le=100)] = 20,
    pickup_state: Annotated[str | None, Query()] = None,
    drop_state: Annotated[str | None, Query()] = None,
    uuid: Annotated[uuid_lib.UUID | None, Query()] = None,
) -> PaginatedResponse[DriverTariffConfigResponse]:
    return await service.list_configs(
        session=session,
        pickup_state=pickup_state,
        drop_state=drop_state,
        uuid=uuid,
        page=page,
        page_size=page_size,
    )


@router.get("/{uuid}", response_model=DriverTariffConfigResponse)
async def get_config(
    uuid: uuid_lib.UUID,
    session: SessionDep,
    _jwt: JwtDep,
) -> DriverTariffConfigResponse:
    return await service.get_config(session=session, uuid=uuid)


@router.post("", response_model=DriverTariffConfigResponse, status_code=201)
async def create_config(
    request: CreateRequest,
    session: SessionDep,
    jwt: JwtDep,
) -> DriverTariffConfigResponse:
    created_by = getattr(jwt, "get", lambda k, d: d)("name", "unknown") if isinstance(jwt, dict) else "unknown"
    return await service.create_config(session=session, request=request, created_by=created_by)


@router.put("/{uuid}", response_model=DriverTariffConfigResponse)
async def update_config(
    uuid: uuid_lib.UUID,
    request: UpdateRequest,
    session: SessionDep,
    jwt: JwtDep,
) -> DriverTariffConfigResponse:
    created_by = getattr(jwt, "get", lambda k, d: d)("name", "unknown") if isinstance(jwt, dict) else "unknown"
    return await service.update_config(session=session, uuid=uuid, request=request, created_by=created_by)


@router.delete("/{uuid}", status_code=204)
async def deactivate_config(
    uuid: uuid_lib.UUID,
    session: SessionDep,
    _jwt: JwtDep,
) -> Response:
    await service.deactivate_config(session=session, uuid=uuid)
    return Response(status_code=204)


@router.post("/resolve", response_model=DriverTariffConfigResponse)
async def resolve_config(
    request: ResolveRequest,
    session: SessionDep,
) -> DriverTariffConfigResponse:
    return await service.resolve_config(session=session, request=request)
