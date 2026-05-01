import uuid
from typing import Annotated, Any, Optional

from fastapi import HTTPException
from sqlmodel.ext.asyncio.session import AsyncSession
from src.modules.base_margin_config.mcp_server import mcp
from src.modules.base_margin_config.models import CreateRequest, Customer, ResolveRequest, Stop, UpdateRequest
from src.modules.base_margin_config.service import (
    create_base_margin_config,
    delete_base_margin_config,
    get_base_margin_config,
    list_base_margin_configs,
    resolve_base_margin_config,
    update_base_margin_config,
)
from src.tools.db import engine


@mcp.tool(annotations={"idempotentHint": True})  # type: ignore
async def set_base_margin_config(
    margin_percent: Annotated[
        float,
        "Required. The margin to apply, as a decimal percentage (e.g., 0.125 means 12.5%). Must be >= 0 and <= 0.99.",
    ],
    uuid_str: Annotated[
        Optional[str], "Provide the UUID to update an existing configuration. Omit to create a new one."
    ] = None,
    customer_name: Annotated[Optional[str], "Exact customer name. Required if customer_subname is provided."] = None,
    customer_subname: Annotated[
        Optional[str], "Optional sub-account or division name for the customer. Requires customer_name."
    ] = None,
    pickup_country: Annotated[
        Optional[str],
        "Pickup ISO 3166-1 alpha-2 country code (e.g., 'US', 'MX'). Required if pickup_state is provided.",
    ] = None,
    pickup_state: Annotated[
        Optional[str], "Pickup state or region. Requires pickup_country. Required if pickup_city is provided."
    ] = None,
    pickup_city: Annotated[
        Optional[str], "Pickup city. Requires pickup_state. Required if pickup_postal_code is provided."
    ] = None,
    pickup_postal_code: Annotated[Optional[str], "Pickup postal code. Requires pickup_city."] = None,
    drop_country: Annotated[
        Optional[str], "Drop ISO 3166-1 alpha-2 country code (e.g., 'US', 'MX'). Required if drop_state is provided."
    ] = None,
    drop_state: Annotated[
        Optional[str], "Drop state or region. Requires drop_country. Required if drop_city is provided."
    ] = None,
    drop_city: Annotated[
        Optional[str], "Drop city. Requires drop_state. Required if drop_postal_code is provided."
    ] = None,
    drop_postal_code: Annotated[Optional[str], "Drop postal code. Requires drop_city."] = None,
) -> dict[str, Any]:
    """Create or update a base margin configuration rule for a specific customer or lane.

    Validation Rules:
    1. Geographic hierarchies must be respected. E.g., You cannot specify a `pickup_state` without a
       `pickup_country`, or a `pickup_city` without a `pickup_state`.
    2. Customer hierarchy: `customer_subname` requires `customer_name`.
    3. At least one root factor must be provided: `customer_name`, `pickup_country`, or `drop_country`.
       The configuration cannot be completely empty.

    If 'uuid_str' is provided, the existing rule will be updated with the new parameters.
    If 'uuid_str' is omitted, a new rule will be created.
    """
    async with AsyncSession(engine, expire_on_commit=False) as session:
        customer = None
        if customer_name or customer_subname:
            customer = Customer(name=customer_name or "", subname=customer_subname)

        pickup = None
        if pickup_country or pickup_state or pickup_city or pickup_postal_code:
            pickup = Stop(
                country=pickup_country or "",
                state=pickup_state or "",
                city=pickup_city or "",
                postal_code=pickup_postal_code or "",
            )

        drop = None
        if drop_country or drop_state or drop_city or drop_postal_code:
            drop = Stop(
                country=drop_country or "",
                state=drop_state or "",
                city=drop_city or "",
                postal_code=drop_postal_code or "",
            )

        try:
            if uuid_str:
                uid = uuid.UUID(uuid_str)
                req_update = UpdateRequest(customer=customer, pickup=pickup, drop=drop, margin_percent=margin_percent)
                result_update = await update_base_margin_config(session, uid, req_update, created_by="mcp-agent")
                return {"result": "Updated successfully", "config": result_update.model_dump(mode="json")}

            req_create = CreateRequest(customer=customer, pickup=pickup, drop=drop, margin_percent=margin_percent)
            result_create = await create_base_margin_config(session, req_create, created_by="mcp-agent")
            return {"result": "Created successfully", "config": result_create.model_dump(mode="json")}
        except ValueError as e:
            return {"error": str(e), "message": "Validation failed checking constraints."}
        except HTTPException as e:
            return {"error": e.detail, "status_code": e.status_code}
        except Exception as e:
            return {"error": str(e)}


@mcp.tool(annotations={"destructiveHint": True})  # type: ignore
async def delete_base_margin_config_tool(
    uuid_str: Annotated[str, "The UUID of the configuration to delete."],
) -> dict[str, Any]:
    """Permanently delete a base margin configuration. This action cannot be undone."""
    async with AsyncSession(engine, expire_on_commit=False) as session:
        try:
            await delete_base_margin_config(session, uuid.UUID(uuid_str))
            return {"result": f"Configuration {uuid_str} deleted successfully"}
        except HTTPException as e:
            return {"error": e.detail, "status_code": e.status_code}
        except ValueError:
            return {"error": "Invalid UUID format"}


@mcp.tool(annotations={"readOnlyHint": True})  # type: ignore
async def resolve_applicable_margin(
    customer_name: Annotated[
        str, "REQUIRED. Exact customer name. If the load has no customer assigned, pass an empty string ''."
    ],
    pickup_country: Annotated[str, "REQUIRED. Pickup ISO 3166-1 alpha-2 country code, e.g. 'US' or 'MX'."],
    pickup_state: Annotated[str, "REQUIRED. Pickup state or region."],
    pickup_city: Annotated[str, "REQUIRED. Pickup city."],
    drop_country: Annotated[str, "REQUIRED. Drop ISO 3166-1 alpha-2 country code, e.g. 'US' or 'MX'."],
    drop_state: Annotated[str, "REQUIRED. Drop state or region."],
    drop_city: Annotated[str, "REQUIRED. Drop city."],
    customer_subname: Annotated[Optional[str], "Optional. Customer sub-account or division."] = None,
    pickup_postal_code: Annotated[Optional[str], "Optional. Pickup postal code."] = None,
    drop_postal_code: Annotated[Optional[str], "Optional. Drop postal code."] = None,
) -> dict[str, Any]:
    """Resolve and find the applicable Base Margin percentage for a specific load context.

    Use this tool when you need to calculate or look up the correct base margin to apply on a shipment/load.
    Unlike configurations which can be generic, the REAL WORLD LOAD always has specific geographical points
    and a customer. Therefore, you MUST provide the full known context of the load (customer name, full pickup
    geography, full drop geography).

    Do NOT omit parameters if the load has them; the underlying engine uses a priority weight system based
    on all these data points to find the most accurate margin match.
    """
    async with AsyncSession(engine, expire_on_commit=False) as session:
        # A real load evaluation must construct Customer, Pickup Stop and Drop Stop
        customer = Customer(name=customer_name, subname=customer_subname)
        pickup = Stop(
            country=pickup_country,
            state=pickup_state,
            city=pickup_city,
            postal_code=pickup_postal_code or "",
        )
        drop = Stop(
            country=drop_country,
            state=drop_state,
            city=drop_city,
            postal_code=drop_postal_code or "",
        )

        req = ResolveRequest(customer=customer, pickup=pickup, drop=drop)
        result = await resolve_base_margin_config(session, req)
        if result:
            return {"match_found": True, "config": result.model_dump(mode="json")}
        return {"match_found": False, "message": "No matching margin configuration found logic."}


@mcp.tool(annotations={"readOnlyHint": True})  # type: ignore
async def get_all_configs_tool(
    customer_name: Annotated[Optional[str], "Filter by exact customer name"] = None,
    customer_subname: Annotated[Optional[str], "Filter by customer sub-account"] = None,
    pickup_country: Annotated[Optional[str], "Filter by pickup country"] = None,
    pickup_state: Annotated[Optional[str], "Filter by pickup state"] = None,
    pickup_city: Annotated[Optional[str], "Filter by pickup city"] = None,
    pickup_postal_code: Annotated[Optional[str], "Filter by pickup postal code"] = None,
    drop_country: Annotated[Optional[str], "Filter by drop country"] = None,
    drop_state: Annotated[Optional[str], "Filter by drop state"] = None,
    drop_city: Annotated[Optional[str], "Filter by drop city"] = None,
    drop_postal_code: Annotated[Optional[str], "Filter by drop postal code"] = None,
) -> list[dict[str, Any]]:
    """Retrieve a list of active base margin configurations, optionally filtered by customer or location parameters.

    Returns the latest version of distinct configurations matching the applied filters.
    """
    async with AsyncSession(engine, expire_on_commit=False) as session:
        configs = await list_base_margin_configs(
            session,
            customer_name=customer_name,
            customer_subname=customer_subname,
            pickup_country=pickup_country,
            pickup_state=pickup_state,
            pickup_city=pickup_city,
            pickup_postal_code=pickup_postal_code,
            drop_country=drop_country,
            drop_state=drop_state,
            drop_city=drop_city,
            drop_postal_code=drop_postal_code,
        )
        return [c.model_dump(mode="json") for c in configs]


@mcp.tool(annotations={"readOnlyHint": True})  # type: ignore
async def get_config_tool(
    uuid_str: Annotated[str, "The unique UUID of the base margin configuration record to retrieve"],
) -> dict[str, Any]:
    """Retrieve a single base margin configuration record identified by its UUID.
    Useful for inspecting the specifics of an existing rule version.
    """
    async with AsyncSession(engine, expire_on_commit=False) as session:
        try:
            config = await get_base_margin_config(session, uuid.UUID(uuid_str))
            if config:
                return config.model_dump(mode="json")
            return {}
        except HTTPException as e:
            return {"error": e.detail, "status_code": e.status_code}
        except ValueError:
            return {"error": "Invalid UUID format"}
