from fastmcp import Client


async def test_set_base_margin_config(mcp_client: Client):
    result = await mcp_client.call_tool(
        "set_base_margin_config",
        {"margin_percent": 0.15, "customer_name": "ACME", "pickup_country": "MX", "drop_country": "US"},
    )
    assert result.data["result"] == "Created successfully"
    assert result.data["config"]["margin_percent"] == 0.15
    assert result.data["config"]["version"] == 1

    uid = result.data["config"]["uuid"]

    result_update = await mcp_client.call_tool(
        "set_base_margin_config",
        {
            "uuid_str": uid,
            "margin_percent": 0.20,
            "customer_name": "ACME",
            "pickup_country": "MX",
            "drop_country": "US",
        },
    )
    assert result_update.data["result"] == "Updated successfully"
    assert result_update.data["config"]["margin_percent"] == 0.20
    assert result_update.data["config"]["version"] == 2


async def test_delete_base_margin_config_tool(mcp_client: Client):
    create_result = await mcp_client.call_tool(
        "set_base_margin_config",
        {"margin_percent": 0.10, "customer_name": "DELETE-ME", "pickup_country": "MX", "drop_country": "US"},
    )
    uid = create_result.data["config"]["uuid"]

    result = await mcp_client.call_tool("delete_base_margin_config_tool", {"uuid_str": uid})
    assert "deleted successfully" in result.data["result"]


async def test_resolve_applicable_margin(mcp_client: Client):
    await mcp_client.call_tool(
        "set_base_margin_config",
        {"margin_percent": 0.12, "customer_name": "ACME", "pickup_country": "MX", "drop_country": "US"},
    )

    result = await mcp_client.call_tool(
        "resolve_applicable_margin",
        {
            "customer_name": "ACME",
            "pickup_country": "MX",
            "pickup_state": "Jalisco",
            "pickup_city": "Guadalajara",
            "drop_country": "US",
            "drop_state": "Texas",
            "drop_city": "Houston",
        },
    )
    assert result.data["match_found"] is True
    assert result.data["config"]["margin_percent"] == 0.12


async def test_get_all_configs_tool(mcp_client: Client):
    await mcp_client.call_tool(
        "set_base_margin_config",
        {"margin_percent": 0.10, "customer_name": "ACME", "pickup_country": "MX", "drop_country": "US"},
    )
    await mcp_client.call_tool(
        "set_base_margin_config",
        {"margin_percent": 0.20, "customer_name": "GLOBEX", "pickup_country": "US", "drop_country": "MX"},
    )

    result = await mcp_client.call_tool("get_all_configs_tool", {})
    assert len(result.data) == 2


async def test_get_config_tool(mcp_client: Client):
    create_result = await mcp_client.call_tool(
        "set_base_margin_config",
        {"margin_percent": 0.18, "customer_name": "INITECH", "pickup_country": "US", "drop_country": "MX"},
    )
    uid = create_result.data["config"]["uuid"]

    result = await mcp_client.call_tool("get_config_tool", {"uuid_str": uid})
    assert result.data["margin_percent"] == 0.18
    assert result.data["uuid"] == uid
