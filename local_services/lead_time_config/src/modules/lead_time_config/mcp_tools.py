import uuid
from decimal import Decimal
from typing import Annotated, Any

from fastmcp.server.dependencies import get_access_token

from src.modules.lead_time_config.exceptions import ConfigNotFoundError, DuplicateConfigError, OverlappingConfigError
from src.modules.lead_time_config.mcp_server import mcp
from src.modules.lead_time_config.models import CreateRequest, ResolveRequest, UpdateRequest
from src.modules.lead_time_config.service import (
    create_lead_time_config,
    delete_lead_time_config,
    get_lead_time_config,
    list_lead_time_configs,
    resolve_lead_time_config,
    update_lead_time_config,
)


def _current_user() -> str:
    token = get_access_token()
    if token:
        username: str = token.claims.get("preferred_username") or token.claims.get("name") or token.client_id
        return username
    return "mcp-agent"


@mcp.tool(annotations={"idempotentHint": True})
async def set_lead_time_config(
    configuration_factor: Annotated[
        float,
        "Required. The adjustment factor to apply, as a decimal (e.g. 0.05 = 5%).",
    ],
    min_days: Annotated[
        int | None,
        "Minimum days for this lead time range. Required when creating;"
        " optional when updating (omit to keep current value).",
    ] = None,
    max_days: Annotated[
        int | None,
        "Maximum days for this lead time range (inclusive). Omit or set null"
        " for unbounded (e.g. '6+' days). Optional when updating.",
    ] = None,
    uuid_str: Annotated[
        str | None,
        "UUID of an existing configuration to update. Omit to create a new rule.",
    ] = None,
) -> dict[str, Any]:
    """
    Create or update a lead time configuration rule.

    **Creating a new rule** (uuid_str omitted):
    - Provide `min_days`, `max_days` (optional, omit for unbounded), and `configuration_factor`.
    - The day range must not overlap any existing active rule.

    **Updating an existing rule** (uuid_str provided):
    - Provide only the fields you want to change: `min_days`, `max_days`, and/or `configuration_factor`.
    - Any omitted field retains its current value.
    - If `min_days` or `max_days` change, the new range must not overlap any other active rule.
    - A new version is created; previous versions are preserved for audit.
    """
    try:
        if uuid_str:
            update_data: dict[str, Any] = {}
            if min_days is not None:
                update_data["min_days"] = min_days
            if max_days is not None:
                update_data["max_days"] = max_days
            update_data["configuration_factor"] = Decimal(str(configuration_factor))
            update_req = UpdateRequest(**update_data)
            config = await update_lead_time_config(uuid.UUID(uuid_str), update_req, _current_user())
            return {"result": f"Configuration {uuid_str} successfully updated", "config": config.model_dump()}
        else:
            if min_days is None:
                return {"result": "error", "message": "min_days is required when creating a new configuration"}
            create_req = CreateRequest(
                min_days=min_days, max_days=max_days, configuration_factor=Decimal(str(configuration_factor))
            )
            config = await create_lead_time_config(create_req, _current_user())
            return {"result": "Configuration successfully created", "config": config.model_dump()}
    except (DuplicateConfigError, OverlappingConfigError, ConfigNotFoundError) as exc:
        return {"result": "error", "message": str(exc)}
    except Exception as exc:
        return {"result": "error", "message": f"Unexpected error: {str(exc)}"}


@mcp.tool(annotations={"destructiveHint": True})
async def delete_lead_time_config_tool(
    uuid_str: Annotated[str, "The UUID of the configuration to delete."],
) -> dict[str, Any]:
    """Permanently delete a lead time configuration."""
    try:
        await delete_lead_time_config(uuid.UUID(uuid_str))
        return {"result": f"Configuration {uuid_str} successfully deleted"}
    except ConfigNotFoundError as exc:
        return {"result": "error", "message": str(exc)}
    except Exception as exc:
        return {"result": "error", "message": f"Unexpected error: {str(exc)}"}


@mcp.tool(annotations={"readOnlyHint": True})
async def get_all_configs_tool(
    min_days: Annotated[int | None, "Filter by exact min_days"] = None,
    max_days: Annotated[int | None, "Filter by exact max_days"] = None,
) -> list[dict[str, Any]]:
    """Retrieve a list of active lead time configurations, optionally filtered."""
    configs = await list_lead_time_configs(
        min_days=min_days,
        max_days=max_days,
    )
    return [c.model_dump() for c in configs]


@mcp.tool(annotations={"readOnlyHint": True})
async def get_config_tool(
    uuid_str: Annotated[str, "The unique UUID of the configuration record to retrieve"],
) -> dict[str, Any]:
    """Retrieve a single lead time configuration record identified by its UUID."""
    try:
        config = await get_lead_time_config(uuid.UUID(uuid_str))
        return config.model_dump()
    except ConfigNotFoundError as exc:
        return {"result": "error", "message": str(exc)}
    except Exception as exc:
        return {"result": "error", "message": f"Unexpected error: {str(exc)}"}


@mcp.tool(annotations={"readOnlyHint": True})
async def resolve_applicable_lead_time(
    days_to_shipment: Annotated[int, "The number of days until the shipment."],
) -> dict[str, Any]:
    """
    Resolve and find the applicable lead time configuration for a specific shipment timeline.
    """
    try:
        resolve_req = ResolveRequest(days_to_shipment=days_to_shipment)
        match = await resolve_lead_time_config(resolve_req)

        if match:
            return {"match_found": True, "config": match.model_dump()}

        return {
            "match_found": False,
            "message": f"No active lead time configuration found for {days_to_shipment} days to shipment.",
        }
    except Exception as exc:
        return {"result": "error", "message": str(exc)}
