from fastmcp import Client


async def test_set_driver_tariff_config_create(mcp_client: Client):
    result = await mcp_client.call_tool(
        "set_driver_tariff_config",
        {"tariff_factor": 1.25, "pickup_state": "TX", "drop_state": "CA"},
    )
    assert result.data["result"] == "Created successfully"
    assert result.data["config"]["pickup_state"] == "TX"
    assert result.data["config"]["drop_state"] == "CA"
    assert result.data["config"]["version"] == 1


async def test_set_driver_tariff_config_update(mcp_client: Client):
    create_result = await mcp_client.call_tool(
        "set_driver_tariff_config",
        {"tariff_factor": 1.20, "pickup_state": "TX"},
    )
    assert create_result.data["result"] == "Created successfully"
    uid = create_result.data["config"]["uuid"]

    update_result = await mcp_client.call_tool(
        "set_driver_tariff_config",
        {"uuid_str": uid, "tariff_factor": 1.35},
    )
    assert update_result.data["result"] == "Updated successfully"
    assert update_result.data["config"]["version"] == 2


async def test_delete_driver_tariff_config_tool(mcp_client: Client):
    create_result = await mcp_client.call_tool(
        "set_driver_tariff_config",
        {"tariff_factor": 1.10, "drop_state": "FL"},
    )
    uid = create_result.data["config"]["uuid"]

    result = await mcp_client.call_tool("delete_driver_tariff_config_tool", {"uuid_str": uid})
    assert "deleted successfully" in result.data["result"]


async def test_resolve_applicable_tariff(mcp_client: Client):
    # Global fallback
    await mcp_client.call_tool(
        "set_driver_tariff_config",
        {"tariff_factor": 1.00},
    )
    # Exact match TX -> CA
    await mcp_client.call_tool(
        "set_driver_tariff_config",
        {"tariff_factor": 1.50, "pickup_state": "TX", "drop_state": "CA"},
    )

    result = await mcp_client.call_tool(
        "resolve_applicable_tariff",
        {"pickup_state": "TX", "drop_state": "CA"},
    )
    assert result.data["match_found"] is True
    assert str(result.data["config"]["tariff_factor"]) == "1.5000"


async def test_get_all_tariff_configs_tool(mcp_client: Client):
    await mcp_client.call_tool(
        "set_driver_tariff_config",
        {"tariff_factor": 1.25, "pickup_state": "TX", "drop_state": "CA"},
    )
    await mcp_client.call_tool(
        "set_driver_tariff_config",
        {"tariff_factor": 1.10, "pickup_state": "NY"},
    )

    result = await mcp_client.call_tool("get_all_tariff_configs_tool", {})
    assert len(result.data) == 2


async def test_get_all_tariff_configs_tool_filter_by_pickup(mcp_client: Client):
    await mcp_client.call_tool(
        "set_driver_tariff_config",
        {"tariff_factor": 1.25, "pickup_state": "TX", "drop_state": "CA"},
    )
    await mcp_client.call_tool(
        "set_driver_tariff_config",
        {"tariff_factor": 1.10, "pickup_state": "NY"},
    )

    result = await mcp_client.call_tool("get_all_tariff_configs_tool", {"pickup_state": "TX"})
    assert all(c["pickup_state"] == "TX" for c in result.data)


async def test_get_tariff_config_tool(mcp_client: Client):
    create_result = await mcp_client.call_tool(
        "set_driver_tariff_config",
        {"tariff_factor": 1.30, "pickup_state": "WA", "drop_state": "OR"},
    )
    uid = create_result.data["config"]["uuid"]

    result = await mcp_client.call_tool("get_tariff_config_tool", {"uuid_str": uid})
    assert result.data["uuid"] == uid
    assert result.data["pickup_state"] == "WA"
