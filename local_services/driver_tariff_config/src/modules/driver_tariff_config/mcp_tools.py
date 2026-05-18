import uuid
from decimal import Decimal
from typing import Annotated, Any, Optional

from fastmcp.server.dependencies import get_access_token
from src.modules.driver_tariff_config.exceptions import ConfigNotFoundError, DuplicateConfigError
from src.modules.driver_tariff_config.mcp_server import mcp
from src.modules.driver_tariff_config.models import CreateRequest, Load, ResolveRequest, Route, Stop, UpdateRequest
from src.modules.driver_tariff_config.service import (
    create_driver_tariff_config,
    delete_driver_tariff_config,
    get_driver_tariff_config,
    list_driver_tariff_configs,
    resolve_driver_tariff_config,
    update_driver_tariff_config,
)


def _current_user() -> str:
    token = get_access_token()
    if token:
        username: str = token.claims.get("preferred_username") or token.claims.get("name") or token.client_id
        return username
    return "mcp-agent"


@mcp.tool(annotations={"idempotentHint": True})
async def set_driver_tariff_config(
    tariff_factor: Annotated[
        float,
        "Required. The tariff multiplier factor (e.g., 1.25 means 25% surcharge). Must be greater than 0.",
    ],
    uuid_str: Annotated[
        Optional[str], "Provide the UUID to update an existing configuration. Omit to create a new one."
    ] = None,
    pickup_state: Annotated[
        Optional[str],
        "Optional. The pickup state code (e.g., 'TX'). Null means any pickup state.",
    ] = None,
    drop_state: Annotated[
        Optional[str],
        "Optional. The drop/delivery state code (e.g., 'CA'). Null means any drop state.",
    ] = None,
) -> dict[str, Any]:
    """Create or update a driver tariff configuration rule.

    A tariff rule defines a multiplier factor applied to driver costs for a given route.
    Rules can be scoped by pickup and/or drop state, with a hierarchy:

    Specificity hierarchy (most specific wins during resolve):
    1. pickup_state + drop_state  (exact route match)
    2. pickup_state only          (origin default — applies to all destinations from this state)
    3. drop_state only            (destination default — applies to all origins to this state)
    4. neither (global fallback)  (applies to any route)

    If 'uuid_str' is provided, the existing rule will be versioned with the new tariff_factor.
    If 'uuid_str' is omitted, a new rule will be created.
    """
    try:
        current_user = _current_user()
        factor = Decimal(str(tariff_factor))
        if uuid_str:
            uid = uuid.UUID(uuid_str)
            req_update = UpdateRequest(tariff_factor=factor)
            result = await update_driver_tariff_config(uid, req_update, created_by=current_user)
            return {"result": "Updated successfully", "config": result.model_dump(mode="json")}

        req_create = CreateRequest(
            pickup_state=pickup_state,
            drop_state=drop_state,
            tariff_factor=factor,
        )
        result = await create_driver_tariff_config(req_create, created_by=current_user)
        return {"result": "Created successfully", "config": result.model_dump(mode="json")}
    except (ConfigNotFoundError, DuplicateConfigError) as e:
        return {"error": str(e)}
    except ValueError as e:
        return {"error": str(e), "message": "Validation failed checking constraints."}
    except Exception as e:
        return {"error": str(e)}


@mcp.tool(annotations={"destructiveHint": True})
async def delete_driver_tariff_config_tool(
    uuid_str: Annotated[str, "The UUID of the driver tariff configuration to delete."],
) -> dict[str, Any]:
    """Permanently delete a driver tariff configuration. This action cannot be undone."""
    try:
        await delete_driver_tariff_config(uuid.UUID(uuid_str))
        return {"result": f"Configuration {uuid_str} deleted successfully"}
    except ConfigNotFoundError as e:
        return {"error": str(e)}
    except ValueError:
        return {"error": "Invalid UUID format"}


@mcp.tool(annotations={"readOnlyHint": True})
async def resolve_applicable_tariff(
    pickup_state: Annotated[
        str,
        "REQUIRED. The pickup state code of the route (e.g., 'TX'). Pass empty string '' if unknown.",
    ] = "",
    drop_state: Annotated[
        str,
        "REQUIRED. The drop/delivery state code of the route (e.g., 'CA'). Pass empty string '' if unknown.",
    ] = "",
) -> dict[str, Any]:
    """Resolve and find the applicable driver tariff factor for a specific route.

    Use this tool when you need to look up the correct tariff multiplier for a shipment route.
    The engine uses a specificity priority to find the most accurate match:
    1. Exact route (pickup_state + drop_state)
    2. Origin default (pickup_state only)
    3. Destination default (drop_state only)
    4. Global fallback (no state restrictions)

    Always provide the full known route context so the most specific rule is found.
    """
    # Build a minimal Load to satisfy the ResolveRequest schema
    stop_defaults = {"country": "", "city": "", "postal_code": ""}
    pickup_stop = Stop(state=pickup_state, **stop_defaults)
    drop_stop = Stop(state=drop_state, **stop_defaults)
    from datetime import date

    from src.modules.driver_tariff_config.models import Customer, TruckType

    req = ResolveRequest(
        load=Load(
            route=Route(pickup=pickup_stop, drop=drop_stop),
            customer=Customer(name=""),
            truck_type=TruckType.DRYVAN,
            ship_date=date.today(),
        )
    )
    try:
        result = await resolve_driver_tariff_config(req)
        return {"match_found": True, "config": result.model_dump(mode="json")}
    except ConfigNotFoundError:
        return {"match_found": False, "message": "No matching driver tariff configuration found."}
    except ValueError as e:
        return {"error": str(e)}


@mcp.tool(annotations={"readOnlyHint": True})
async def get_all_tariff_configs_tool(
    pickup_state: Annotated[Optional[str], "Filter by pickup state code (e.g., 'TX')"] = None,
    drop_state: Annotated[Optional[str], "Filter by drop/delivery state code (e.g., 'CA')"] = None,
) -> list[dict[str, Any]]:
    """Retrieve a list of active driver tariff configurations, optionally filtered by route states.

    Returns the latest version of each distinct configuration matching the applied filters.
    """
    try:
        configs = await list_driver_tariff_configs(
            pickup_state=pickup_state,
            drop_state=drop_state,
        )
        return [c.model_dump(mode="json") for c in configs]
    except Exception as e:
        return [{"error": str(e)}]


@mcp.tool(annotations={"readOnlyHint": True})
async def get_tariff_config_tool(
    uuid_str: Annotated[str, "The UUID of the driver tariff configuration to retrieve."],
) -> dict[str, Any]:
    """Retrieve the latest version of a specific driver tariff configuration by UUID."""
    try:
        result = await get_driver_tariff_config(uuid.UUID(uuid_str))
        return result.model_dump(mode="json")
    except ConfigNotFoundError as e:
        return {"error": str(e)}
    except ValueError:
        return {"error": "Invalid UUID format"}
