import uuid
from decimal import Decimal
from typing import Annotated, Any, Optional

from fastmcp.server.dependencies import get_access_token

from src.modules.fuel_cost_config.exceptions import ConfigNotFoundError, DuplicateConfigError
from src.modules.fuel_cost_config.mcp_server import mcp
from src.modules.fuel_cost_config.models import CreateRequest, Customer, ResolveRequest, TruckType, UpdateRequest
from src.modules.fuel_cost_config.service import (
    create_fuel_cost_config,
    delete_fuel_cost_config,
    get_fuel_cost_config,
    list_fuel_cost_configs,
    resolve_fuel_cost_config,
    update_fuel_cost_config,
)


def _current_user() -> str:
    token = get_access_token()
    if token:
        username: str = token.claims.get("preferred_username") or token.claims.get("name") or token.client_id
        return username
    return "mcp-agent"


@mcp.tool(annotations={"idempotentHint": True})
async def set_fuel_cost_config(
    truck_type: Annotated[
        str,
        "Required. The truck type for this fuel cost rule. Must be one of: 'Flatbed', 'Reefer', 'Dryvan'.",
    ],
    fuel_cost_per_km: Annotated[
        float,
        "Required. Fuel cost per kilometre in USD (e.g., 0.45 means $0.45/km). Must be greater than 0.",
    ],
    uuid_str: Annotated[
        Optional[str], "Provide the UUID to update an existing configuration. Omit to create a new one."
    ] = None,
    customer_name: Annotated[Optional[str], "Exact customer name. Required if customer_subname is provided."] = None,
    customer_subname: Annotated[
        Optional[str], "Optional sub-account or division name for the customer. Requires customer_name."
    ] = None,
) -> dict[str, Any]:
    """Create or update a fuel cost configuration rule for a specific customer and truck type.

    A fuel cost rule defines how much fuel costs per kilometre for a given truck type,
    optionally scoped to a specific customer or sub-account.

    Specificity hierarchy (most specific wins during resolve):
    1. customer_name + customer_subname + truck_type  (most specific)
    2. customer_name + truck_type
    3. truck_type only (system-level baseline)

    If 'uuid_str' is provided, the existing rule will be versioned with the new fuel_cost_per_km.
    If 'uuid_str' is omitted, a new rule will be created.
    """
    customer = None
    if customer_name or customer_subname:
        customer = Customer(name=customer_name or "", subname=customer_subname)

    try:
        current_user = _current_user()
        if uuid_str:
            uid = uuid.UUID(uuid_str)
            req_update = UpdateRequest(fuel_cost_per_km=Decimal(str(fuel_cost_per_km)))
            result = await update_fuel_cost_config(uid, req_update, created_by=current_user)
            return {"result": "Updated successfully", "config": result.model_dump(mode="json")}

        req_create = CreateRequest(
            customer=customer,
            truck_type=TruckType(truck_type),
            fuel_cost_per_km=Decimal(str(fuel_cost_per_km)),
        )
        result = await create_fuel_cost_config(req_create, created_by=current_user)
        return {"result": "Created successfully", "config": result.model_dump(mode="json")}
    except (ConfigNotFoundError, DuplicateConfigError) as e:
        return {"error": str(e)}
    except ValueError as e:
        return {"error": str(e), "message": "Validation failed checking constraints."}
    except Exception as e:
        return {"error": str(e)}


@mcp.tool(annotations={"destructiveHint": True})
async def delete_fuel_cost_config_tool(
    uuid_str: Annotated[str, "The UUID of the fuel cost configuration to delete."],
) -> dict[str, Any]:
    """Permanently delete a fuel cost configuration. This action cannot be undone."""
    try:
        await delete_fuel_cost_config(uuid.UUID(uuid_str))
        return {"result": f"Configuration {uuid_str} deleted successfully"}
    except ConfigNotFoundError as e:
        return {"error": str(e)}
    except ValueError:
        return {"error": "Invalid UUID format"}


@mcp.tool(annotations={"readOnlyHint": True})
async def resolve_applicable_fuel_cost(
    truck_type: Annotated[
        str,
        "REQUIRED. The truck type of the load. Must be one of: 'Flatbed', 'Reefer', 'Dryvan'.",
    ],
    customer_name: Annotated[
        str, "REQUIRED. Exact customer name. If the load has no customer assigned, pass an empty string ''."
    ] = "",
    customer_subname: Annotated[Optional[str], "Optional. Customer sub-account or division."] = None,
) -> dict[str, Any]:
    """Resolve and find the applicable fuel cost per km for a specific load context.

    Use this tool when you need to look up the correct fuel cost to apply to a shipment.
    The engine uses a specificity priority to find the most accurate match:
    1. customer + subname + truck_type (most specific)
    2. customer + truck_type
    3. truck_type only (system baseline)

    Always provide the full known customer context so the most specific rule is found.
    """
    customer = None
    if customer_name:
        customer = Customer(name=customer_name, subname=customer_subname)

    req = ResolveRequest(customer=customer, truck_type=TruckType(truck_type))
    try:
        result = await resolve_fuel_cost_config(req)
        return {"match_found": True, "config": result.model_dump(mode="json")}
    except ConfigNotFoundError:
        return {"match_found": False, "message": "No matching fuel cost configuration found."}
    except ValueError as e:
        return {"error": str(e)}


@mcp.tool(annotations={"readOnlyHint": True})
async def get_all_configs_tool(
    customer_name: Annotated[Optional[str], "Filter by exact customer name"] = None,
    customer_subname: Annotated[Optional[str], "Filter by customer sub-account"] = None,
    truck_type: Annotated[Optional[str], "Filter by truck type ('Flatbed', 'Reefer', 'Dryvan')"] = None,
) -> list[dict[str, Any]]:
    """Retrieve a list of active fuel cost configurations, optionally filtered by customer or truck type.

    Returns the latest version of each distinct configuration matching the applied filters.
    """
    try:
        truck_type_val = TruckType(truck_type).value if truck_type else None
        configs = await list_fuel_cost_configs(
            customer_name=customer_name,
            customer_subname=customer_subname,
            truck_type=truck_type_val,
        )
        return [c.model_dump(mode="json") for c in configs]
    except ValueError as e:
        return [{"error": str(e)}]


@mcp.tool(annotations={"readOnlyHint": True})
async def get_config_tool(
    uuid_str: Annotated[str, "The UUID of the fuel cost configuration to retrieve."],
) -> dict[str, Any]:
    """Retrieve the latest version of a specific fuel cost configuration by UUID."""
    try:
        result = await get_fuel_cost_config(uuid.UUID(uuid_str))
        return result.model_dump(mode="json")
    except ConfigNotFoundError as e:
        return {"error": str(e)}
    except ValueError:
        return {"error": "Invalid UUID format"}
