import pytest


@pytest.mark.asyncio
async def test_list_configs(client, auth_token, clean_table):
    headers = {"Authorization": f"Bearer {auth_token}"}
    await client.post(
        "/base-margin-configs",
        json={"customer": {"name": "A"}, "pickup": {"country": "US", "state": "CA"}, "margin_percent": 0.1},
        headers=headers,
    )
    await client.post(
        "/base-margin-configs",
        json={"customer": {"name": "B"}, "pickup": {"country": "US", "state": "TX"}, "margin_percent": 0.2},
        headers=headers,
    )
    await client.post("/base-margin-configs", json={"drop": {"country": "MX"}, "margin_percent": 0.3}, headers=headers)

    # Test get all
    resp = await client.get("/base-margin-configs", headers=headers)
    assert resp.status_code == 200
    assert len(resp.json()) == 3

    # Test filter by customer_name
    resp = await client.get("/base-margin-configs?customer_name=A", headers=headers)
    assert resp.status_code == 200
    data = resp.json()
    assert len(data) == 1
    assert data[0]["customer_name"] == "A"

    # Test filter by pickup_country
    resp = await client.get("/base-margin-configs?pickup_country=US", headers=headers)
    assert resp.status_code == 200
    assert len(resp.json()) == 2

    # Test filter by pickup_state
    resp = await client.get("/base-margin-configs?pickup_state=TX", headers=headers)
    assert resp.status_code == 200
    data = resp.json()
    assert len(data) == 1
    assert data[0]["customer_name"] == "B"

    # Test filter by drop_country
    resp = await client.get("/base-margin-configs?drop_country=MX", headers=headers)
    assert resp.status_code == 200
    data = resp.json()
    assert len(data) == 1
    assert data[0]["margin_percent"] == 0.3
