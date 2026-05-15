import logging
import uuid as uuid_lib
from collections.abc import Sequence
from typing import Annotated

from fastapi import APIRouter, Depends, Query, status

from src.modules.lead_time_config.models import (
    CreateRequest,
    LeadTimeConfigResponse,
    ResolveRequest,
    UpdateRequest,
)
from src.modules.lead_time_config.service import (
    create_lead_time_config,
    delete_lead_time_config,
    get_lead_time_config,
    list_lead_time_configs,
    resolve_lead_time_config,
    update_lead_time_config,
)
from src.tools.auth import VerifiedJwt

logger = logging.getLogger(__name__)


class ListFilterParams:
    def __init__(
        self,
        min_days: int | None = Query(None),
        max_days: int | None = Query(None),
    ):
        self.min_days = min_days
        self.max_days = max_days


router = APIRouter(tags=["Lead Time Configuration"])


@router.post("", response_model=LeadTimeConfigResponse, status_code=status.HTTP_201_CREATED)
async def create_config(req: CreateRequest, jwt: VerifiedJwt) -> LeadTimeConfigResponse:
    created_by = jwt.get("preferred_username") or jwt.get("name") or jwt["sub"]
    return await create_lead_time_config(req, created_by)


@router.get("", response_model=list[LeadTimeConfigResponse])
async def list_configs(
    jwt: VerifiedJwt, filters: Annotated[ListFilterParams, Depends()]
) -> Sequence[LeadTimeConfigResponse]:
    return await list_lead_time_configs(
        min_days=filters.min_days,
        max_days=filters.max_days,
    )


@router.get("/{uuid}", response_model=LeadTimeConfigResponse)
async def get_config(uuid: uuid_lib.UUID, jwt: VerifiedJwt) -> LeadTimeConfigResponse:
    return await get_lead_time_config(uuid)


@router.put("/{uuid}", response_model=LeadTimeConfigResponse)
async def update_config(uuid: uuid_lib.UUID, req: UpdateRequest, jwt: VerifiedJwt) -> LeadTimeConfigResponse:
    created_by = jwt.get("preferred_username") or jwt.get("name") or jwt["sub"]
    return await update_lead_time_config(uuid, req, created_by)


@router.delete("/{uuid}", status_code=status.HTTP_204_NO_CONTENT)
async def delete_config(uuid: uuid_lib.UUID, jwt: VerifiedJwt) -> None:
    await delete_lead_time_config(uuid)


@router.post("/resolve", response_model=LeadTimeConfigResponse)
async def resolve_config(req: ResolveRequest) -> LeadTimeConfigResponse:
    match = await resolve_lead_time_config(req)
    return match
