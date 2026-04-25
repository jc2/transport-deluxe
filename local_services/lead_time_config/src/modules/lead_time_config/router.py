import logging
import uuid as uuid_lib
from typing import Annotated

from fastapi import APIRouter, Depends, Query
from sqlmodel.ext.asyncio.session import AsyncSession

from src.modules.lead_time_config import service
from src.modules.lead_time_config.models import (
    CreateRequest,
    LeadTimeConfigResponse,
    PaginatedResponse,
    ResolveRequest,
    UpdateRequest,
)
from src.tools.auth import require_role
from src.tools.db import get_session

logger = logging.getLogger(__name__)
router = APIRouter(tags=["Lead Time Configuration"])


@router.get(
    "/",
    response_model=PaginatedResponse[LeadTimeConfigResponse],
)
async def list_configs(
    session: Annotated[AsyncSession, Depends(get_session)],
    uuid: uuid_lib.UUID | None = Query(None, description="Filter by configuration UUID"),
    page: int = Query(1, ge=1, description="Page number"),
    page_size: int = Query(10, ge=1, le=100, description="Items per page"),
    user_info: dict = Depends(require_role("margin-configurator")),  # type: ignore[type-arg]
) -> PaginatedResponse[LeadTimeConfigResponse]:
    return await service.list_configs(
        session=session,
        uuid=uuid,
        page=page,
        page_size=page_size,
    )


@router.get(
    "/{uuid}",
    response_model=LeadTimeConfigResponse,
)
async def get_config(
    uuid: uuid_lib.UUID,
    session: Annotated[AsyncSession, Depends(get_session)],
    user_info: dict = Depends(require_role("margin-configurator")),  # type: ignore[type-arg]
) -> LeadTimeConfigResponse:
    return await service.get_config(session=session, uuid=uuid)


@router.post(
    "/",
    response_model=LeadTimeConfigResponse,
    status_code=201,
)
async def create_config(
    request: CreateRequest,
    session: Annotated[AsyncSession, Depends(get_session)],
    user_info: dict = Depends(require_role("margin-configurator")),  # type: ignore[type-arg]
) -> LeadTimeConfigResponse:
    created_by = user_info.get("preferred_username", "unknown")
    return await service.create_config(
        session=session,
        request=request,
        created_by=created_by,
    )


@router.patch(
    "/{uuid}",
    response_model=LeadTimeConfigResponse,
)
async def update_config(
    uuid: uuid_lib.UUID,
    request: UpdateRequest,
    session: Annotated[AsyncSession, Depends(get_session)],
    user_info: dict = Depends(require_role("margin-configurator")),  # type: ignore[type-arg]
) -> LeadTimeConfigResponse:
    created_by = user_info.get("preferred_username", "unknown")
    return await service.update_config(
        session=session,
        uuid=uuid,
        request=request,
        created_by=created_by,
    )


@router.post(
    "/resolve",
    response_model=LeadTimeConfigResponse,
)
async def resolve_config(
    request: ResolveRequest,
    session: Annotated[AsyncSession, Depends(get_session)],
) -> LeadTimeConfigResponse:
    return await service.resolve_config(session=session, request=request)
