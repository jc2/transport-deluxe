import uuid as uuid_lib
from typing import Annotated

from fastapi import APIRouter, Depends, Query, status

from ...tools.auth import VerifiedJwt
from .models import BaseMarginConfigResponse, CreateRequest, ResolveRequest, UpdateRequest
from .service import (
    create_base_margin_config,
    delete_base_margin_config,
    get_base_margin_config,
    list_base_margin_configs,
    resolve_base_margin_config,
    update_base_margin_config,
)


class ListFilterParams:
    def __init__(
        self,
        customer_name: str | None = Query(None),
        customer_subname: str | None = Query(None),
        pickup_country: str | None = Query(None),
        pickup_state: str | None = Query(None),
        pickup_city: str | None = Query(None),
        pickup_postal_code: str | None = Query(None),
        drop_country: str | None = Query(None),
        drop_state: str | None = Query(None),
        drop_city: str | None = Query(None),
        drop_postal_code: str | None = Query(None),
    ):
        self.customer_name = customer_name
        self.customer_subname = customer_subname
        self.pickup_country = pickup_country
        self.pickup_state = pickup_state
        self.pickup_city = pickup_city
        self.pickup_postal_code = pickup_postal_code
        self.drop_country = drop_country
        self.drop_state = drop_state
        self.drop_city = drop_city
        self.drop_postal_code = drop_postal_code


router = APIRouter(tags=["Base Margin Configuration"])


@router.post("", response_model=BaseMarginConfigResponse, status_code=status.HTTP_201_CREATED)
async def create_config(req: CreateRequest, jwt: VerifiedJwt) -> BaseMarginConfigResponse:
    created_by = jwt.get("preferred_username") or jwt.get("name") or jwt["sub"]
    return await create_base_margin_config(req, created_by)


@router.get("", response_model=list[BaseMarginConfigResponse])
async def list_configs(
    jwt: VerifiedJwt, filters: Annotated[ListFilterParams, Depends()]
) -> list[BaseMarginConfigResponse]:
    return await list_base_margin_configs(
        customer_name=filters.customer_name,
        customer_subname=filters.customer_subname,
        pickup_country=filters.pickup_country,
        pickup_state=filters.pickup_state,
        pickup_city=filters.pickup_city,
        pickup_postal_code=filters.pickup_postal_code,
        drop_country=filters.drop_country,
        drop_state=filters.drop_state,
        drop_city=filters.drop_city,
        drop_postal_code=filters.drop_postal_code,
    )


@router.get("/{uuid}", response_model=BaseMarginConfigResponse)
async def get_config(uuid: uuid_lib.UUID, jwt: VerifiedJwt) -> BaseMarginConfigResponse:
    return await get_base_margin_config(uuid)


@router.put("/{uuid}", response_model=BaseMarginConfigResponse)
async def update_config(uuid: uuid_lib.UUID, req: UpdateRequest, jwt: VerifiedJwt) -> BaseMarginConfigResponse:
    created_by = jwt.get("preferred_username") or jwt.get("name") or jwt["sub"]
    return await update_base_margin_config(uuid, req, created_by)


@router.delete("/{uuid}", status_code=status.HTTP_204_NO_CONTENT)
async def delete_config(uuid: uuid_lib.UUID, jwt: VerifiedJwt) -> None:
    await delete_base_margin_config(uuid)


@router.post("/resolve", response_model=BaseMarginConfigResponse)
async def resolve_config(req: ResolveRequest) -> BaseMarginConfigResponse:
    return await resolve_base_margin_config(req)
