from fastmcp import Client


async def test_set_fuel_cost_config_create(mcp_client: Client):
    result = await mcp_client.call_tool(
        "set_fuel_cost_config",
        {"truck_type": "Dryvan", "fuel_cost_per_km": 0.50},
    )
    assert result.data["result"] == "Created successfully"
    assert result.data["config"]["truck_type"] == "Dryvan"
    assert result.data["config"]["version"] == 1


async def test_set_fuel_cost_config_update(mcp_client: Client):
    create_result = await mcp_client.call_tool(
        "set_fuel_cost_config",
        {"truck_type": "Reefer", "fuel_cost_per_km": 0.65},
    )
    assert create_result.data["result"] == "Created successfully"
    uid = create_result.data["config"]["uuid"]

    update_result = await mcp_client.call_tool(
        "set_fuel_cost_config",
        {"uuid_str": uid, "truck_type": "Reefer", "fuel_cost_per_km": 0.70},
    )
    assert update_result.data["result"] == "Updated successfully"
    assert update_result.data["config"]["version"] == 2


async def test_delete_fuel_cost_config_tool(mcp_client: Client):
    create_result = await mcp_client.call_tool(
        "set_fuel_cost_config",
        {"truck_type": "Flatbed", "fuel_cost_per_km": 0.40, "customer_name": "DELETE-ME"},
    )
    uid = create_result.data["config"]["uuid"]

    result = await mcp_client.call_tool("delete_fuel_cost_config_tool", {"uuid_str": uid})
    assert "deleted successfully" in result.data["result"]


async def test_resolve_applicable_fuel_cost(mcp_client: Client):
    await mcp_client.call_tool(
        "set_fuel_cost_config",
        {"truck_type": "Reefer", "fuel_cost_per_km": 0.65},
    )
    await mcp_client.call_tool(
        "set_fuel_cost_config",
        {"truck_type": "Reefer", "fuel_cost_per_km": 0.60, "customer_name": "ACME"},
    )

    result = await mcp_client.call_tool(
        "resolve_applicable_fuel_cost",
        {"truck_type": "Reefer", "customer_name": "ACME"},
    )
    assert result.data["match_found"] is True
    assert result.data["config"]["customer"]["name"] == "ACME"


async def test_get_all_configs_tool(mcp_client: Client):
    await mcp_client.call_tool(
        "set_fuel_cost_config",
        {"truck_type": "Dryvan", "fuel_cost_per_km": 0.50},
    )
    await mcp_client.call_tool(
        "set_fuel_cost_config",
        {"truck_type": "Reefer", "fuel_cost_per_km": 0.65},
    )

    result = await mcp_client.call_tool("get_all_configs_tool", {})
    assert len(result.data) == 2


async def test_get_all_configs_tool_filter_by_truck_type(mcp_client: Client):
    await mcp_client.call_tool(
        "set_fuel_cost_config",
        {"truck_type": "Dryvan", "fuel_cost_per_km": 0.50},
    )
    await mcp_client.call_tool(
        "set_fuel_cost_config",
        {"truck_type": "Reefer", "fuel_cost_per_km": 0.65},
    )

    result = await mcp_client.call_tool("get_all_configs_tool", {"truck_type": "Reefer"})
    assert all(c["truck_type"] == "Reefer" for c in result.data)


async def test_get_config_tool(mcp_client: Client):
    create_result = await mcp_client.call_tool(
        "set_fuel_cost_config",
        {"truck_type": "Flatbed", "fuel_cost_per_km": 0.45, "customer_name": "INITECH"},
    )
    uid = create_result.data["config"]["uuid"]

    result = await mcp_client.call_tool("get_config_tool", {"uuid_str": uid})
    assert result.data["uuid"] == uid
    assert result.data["truck_type"] == "Flatbed"
