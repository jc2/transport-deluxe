import pytest


@pytest.mark.asyncio
async def test_resolve_no_auth_succeeds(client, auth_token, clean_table) -> None:
    headers = {"Authorization": f"Bearer {auth_token}"}
    await client.post(
        "/fuel-cost-configs",
        json={"customer": None, "truck_type": "Reefer", "fuel_cost_per_km": "0.65"},
        headers=headers,
    )

    response = await client.post("/fuel-cost-configs/resolve", json={"customer": None, "truck_type": "Reefer"})
    assert response.status_code == 200
    data = response.json()
    assert data["truck_type"] == "Reefer"


@pytest.mark.asyncio
async def test_resolve_customer_subname_wins(client, auth_token, clean_table) -> None:
    headers = {"Authorization": f"Bearer {auth_token}"}
    await client.post(
        "/fuel-cost-configs",
        json={"customer": None, "truck_type": "Reefer", "fuel_cost_per_km": "0.65"},
        headers=headers,
    )
    await client.post(
        "/fuel-cost-configs",
        json={
            "customer": {"name": "Acme", "subname": None},
            "truck_type": "Reefer",
            "fuel_cost_per_km": "0.60",
        },
        headers=headers,
    )
    await client.post(
        "/fuel-cost-configs",
        json={
            "customer": {"name": "Acme", "subname": "West"},
            "truck_type": "Reefer",
            "fuel_cost_per_km": "0.55",
        },
        headers=headers,
    )

    response = await client.post(
        "/fuel-cost-configs/resolve",
        json={"customer": {"name": "Acme", "subname": "West"}, "truck_type": "Reefer"},
    )
    assert response.status_code == 200
    data = response.json()
    assert data["customer"]["name"] == "Acme"
    assert data["customer"]["subname"] == "West"
    assert str(data["fuel_cost_per_km"]) == "0.5500"


@pytest.mark.asyncio
async def test_resolve_customer_name_fallback_when_no_subname_match(client, auth_token, clean_table) -> None:
    headers = {"Authorization": f"Bearer {auth_token}"}
    await client.post(
        "/fuel-cost-configs",
        json={"customer": None, "truck_type": "Reefer", "fuel_cost_per_km": "0.65"},
        headers=headers,
    )
    await client.post(
        "/fuel-cost-configs",
        json={
            "customer": {"name": "Acme", "subname": None},
            "truck_type": "Reefer",
            "fuel_cost_per_km": "0.60",
        },
        headers=headers,
    )

    response = await client.post(
        "/fuel-cost-configs/resolve",
        json={"customer": {"name": "Acme", "subname": "East"}, "truck_type": "Reefer"},
    )
    assert response.status_code == 200
    data = response.json()
    assert data["customer"]["name"] == "Acme"
    assert data["customer"]["subname"] is None
    assert str(data["fuel_cost_per_km"]) == "0.6000"


@pytest.mark.asyncio
async def test_resolve_system_fallback(client, auth_token, clean_table) -> None:
    headers = {"Authorization": f"Bearer {auth_token}"}
    await client.post(
        "/fuel-cost-configs",
        json={"customer": None, "truck_type": "Reefer", "fuel_cost_per_km": "0.65"},
        headers=headers,
    )

    response = await client.post(
        "/fuel-cost-configs/resolve",
        json={"customer": {"name": "Unknown", "subname": None}, "truck_type": "Reefer"},
    )
    assert response.status_code == 200
    data = response.json()
    assert data["customer"] is None
    assert str(data["fuel_cost_per_km"]) == "0.6500"


@pytest.mark.asyncio
async def test_resolve_400_when_no_match(client, clean_table) -> None:
    response = await client.post("/fuel-cost-configs/resolve", json={"customer": None, "truck_type": "Flatbed"})
    assert response.status_code == 400
    body = response.json()
    assert body["status"] == 400
    assert "messages" in body


@pytest.mark.asyncio
async def test_resolve_returns_highest_version_on_tie(client, auth_token, clean_table) -> None:
    headers = {"Authorization": f"Bearer {auth_token}"}
    create_resp = await client.post(
        "/fuel-cost-configs",
        json={"customer": None, "truck_type": "Dryvan", "fuel_cost_per_km": "0.50"},
        headers=headers,
    )
    config_uuid = create_resp.json()["uuid"]

    await client.put(
        f"/fuel-cost-configs/{config_uuid}",
        json={"fuel_cost_per_km": "0.55"},
        headers=headers,
    )

    response = await client.post("/fuel-cost-configs/resolve", json={"customer": None, "truck_type": "Dryvan"})
    assert response.status_code == 200
    data = response.json()
    assert data["version"] == 2
    assert str(data["fuel_cost_per_km"]) == "0.5500"
