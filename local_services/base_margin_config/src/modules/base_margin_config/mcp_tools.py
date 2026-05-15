import uuid
from typing import Annotated, Any, Optional

from fastmcp.server.dependencies import get_access_token  # type: ignore[import-not-found]
from src.modules.base_margin_config.exceptions import ConfigNotFoundError, DuplicateConfigError
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


def _current_user() -> str:
    token = get_access_token()
    if token:
        username: str = token.claims.get("preferred_username") or token.claims.get("name") or token.client_id
        return username
    return "mcp-agent"


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
        current_user = _current_user()
        if uuid_str:
            uid = uuid.UUID(uuid_str)
            req_update = UpdateRequest(customer=customer, pickup=pickup, drop=drop, margin_percent=margin_percent)
            result = await update_base_margin_config(uid, req_update, created_by=current_user)
            return {"result": "Updated successfully", "config": result.model_dump(mode="json")}

        req_create = CreateRequest(customer=customer, pickup=pickup, drop=drop, margin_percent=margin_percent)
        result = await create_base_margin_config(req_create, created_by=current_user)
        return {"result": "Created successfully", "config": result.model_dump(mode="json")}
    except (ConfigNotFoundError, DuplicateConfigError) as e:
        return {"error": str(e)}
    except ValueError as e:
        return {"error": str(e), "message": "Validation failed checking constraints."}
    except Exception as e:
        return {"error": str(e)}


@mcp.tool(annotations={"destructiveHint": True})  # type: ignore
async def delete_base_margin_config_tool(
    uuid_str: Annotated[str, "The UUID of the configuration to delete."],
) -> dict[str, Any]:
    """Permanently delete a base margin configuration. This action cannot be undone."""
    try:
        await delete_base_margin_config(uuid.UUID(uuid_str))
        return {"result": f"Configuration {uuid_str} deleted successfully"}
    except ConfigNotFoundError as e:
        return {"error": str(e)}
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
    try:
        result = await resolve_base_margin_config(req)
        return {"match_found": True, "config": result.model_dump(mode="json")}
    except ConfigNotFoundError:
        return {"match_found": False, "message": "No matching margin configuration found."}


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
    configs = await list_base_margin_configs(
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
    try:
        config = await get_base_margin_config(uuid.UUID(uuid_str))
        return config.model_dump(mode="json")
    except ConfigNotFoundError as e:
        return {"error": str(e)}
    except ValueError:
        return {"error": "Invalid UUID format"}
