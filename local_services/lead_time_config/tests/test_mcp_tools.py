from fastmcp import Client


async def test_set_lead_time_config(mcp_client: Client):
    result = await mcp_client.call_tool(
        "set_lead_time_config",
        {"min_days": 1, "max_days": 3, "configuration_factor": 0.05},
    )
    assert result.data["result"] == "Configuration successfully created"
    assert result.data["config"]["min_days"] == 1
    assert result.data["config"]["max_days"] == 3
    assert result.data["config"]["version"] == 1

    uid = result.data["config"]["uuid"]

    result_update = await mcp_client.call_tool(
        "set_lead_time_config",
        {
            "uuid_str": uid,
            "min_days": 1,
            "max_days": 4,
            "configuration_factor": 0.10,
        },
    )
    assert "successfully updated" in result_update.data["result"]
    assert result_update.data["config"]["min_days"] == 1
    assert result_update.data["config"]["max_days"] == 4
    assert result_update.data["config"]["version"] == 2


async def test_delete_lead_time_config_tool(mcp_client: Client):
    create_result = await mcp_client.call_tool(
        "set_lead_time_config",
        {"min_days": 10, "max_days": 15, "configuration_factor": 0.05},
    )
    uid = create_result.data["config"]["uuid"]

    result = await mcp_client.call_tool("delete_lead_time_config_tool", {"uuid_str": uid})
    assert "successfully deleted" in result.data["result"]


async def test_resolve_applicable_lead_time(mcp_client: Client):
    await mcp_client.call_tool(
        "set_lead_time_config",
        {"min_days": 5, "max_days": 8, "configuration_factor": 0.05},
    )

    result = await mcp_client.call_tool(
        "resolve_applicable_lead_time",
        {"days_to_shipment": 6},
    )
    assert result.data["match_found"] is True
    assert result.data["config"]["min_days"] == 5


async def test_get_all_configs_tool(mcp_client: Client):
    await mcp_client.call_tool(
        "set_lead_time_config",
        {"min_days": 100, "max_days": 103, "configuration_factor": 0.05},
    )
    await mcp_client.call_tool(
        "set_lead_time_config",
        {"min_days": 200, "max_days": 205, "configuration_factor": 0.10},
    )

    result = await mcp_client.call_tool("get_all_configs_tool", {})
    # Depending on how the test table cleans up, we might have more, let's just assert greater than 1
    assert len(result.data) >= 2


async def test_get_config_tool(mcp_client: Client):
    create_result = await mcp_client.call_tool(
        "set_lead_time_config",
        {"min_days": 300, "max_days": 303, "configuration_factor": 0.18},
    )
    uid = create_result.data["config"]["uuid"]

    result = await mcp_client.call_tool("get_config_tool", {"uuid_str": uid})
    assert result.data["min_days"] == 300
    assert result.data["uuid"] == uid
