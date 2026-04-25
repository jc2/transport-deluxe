import uuid as uuid_lib
from collections.abc import Sequence
from typing import Annotated

from fastapi import APIRouter, Depends, HTTPException, status
from sqlmodel.ext.asyncio.session import AsyncSession

from ...tools.auth import VerifiedJwt
from ...tools.db import get_session
from .models import (
    BaseMarginConfig,
    CreateRequest,
    ResolveRequest,
    UpdateRequest,
)
from .service import (
    create_base_margin_config,
    delete_base_margin_config,
    get_base_margin_config,
    list_base_margin_configs,
    resolve_base_margin_config,
    update_base_margin_config,
)

AsyncSessionDep = Annotated[AsyncSession, Depends(get_session)]


router = APIRouter(tags=["Base Margin Configuration"])


@router.post("", response_model=BaseMarginConfig, status_code=status.HTTP_201_CREATED)
async def create_config(req: CreateRequest, session: AsyncSessionDep, jwt: VerifiedJwt) -> BaseMarginConfig:
    created_by = jwt.get("preferred_username") or jwt.get("name", "api_user")
    return await create_base_margin_config(session, req, created_by)


@router.get("", response_model=list[BaseMarginConfig])
async def list_configs(session: AsyncSessionDep, jwt: VerifiedJwt) -> Sequence[BaseMarginConfig]:
    return await list_base_margin_configs(session)


@router.get("/{uuid}", response_model=BaseMarginConfig)
async def get_config(uuid: uuid_lib.UUID, session: AsyncSessionDep, jwt: VerifiedJwt) -> BaseMarginConfig:
    return await get_base_margin_config(session, uuid)


@router.put("/{uuid}", response_model=BaseMarginConfig)
async def update_config(
    uuid: uuid_lib.UUID, req: UpdateRequest, session: AsyncSessionDep, jwt: VerifiedJwt
) -> BaseMarginConfig:
    created_by = jwt.get("preferred_username") or jwt.get("name", "api_user")
    return await update_base_margin_config(session, uuid, req, created_by)


@router.delete("/{uuid}", status_code=status.HTTP_204_NO_CONTENT)
async def delete_config(uuid: uuid_lib.UUID, session: AsyncSessionDep, jwt: VerifiedJwt) -> None:
    await delete_base_margin_config(session, uuid)


@router.post("/resolve", response_model=BaseMarginConfig)
async def resolve_config(req: ResolveRequest, session: AsyncSessionDep) -> BaseMarginConfig:
    config = await resolve_base_margin_config(session, req)
    if not config:
        raise HTTPException(status_code=404, detail="No matching configuration found.")
    return config
