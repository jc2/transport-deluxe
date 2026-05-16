import pytest


@pytest.mark.asyncio
async def test_list_returns_active_configs(client, auth_token, clean_table) -> None:
    headers = {"Authorization": f"Bearer {auth_token}"}
    await client.post(
        "/fuel-cost-configs",
        json={"customer": None, "truck_type": "Dryvan", "fuel_cost_per_km": "0.50"},
        headers=headers,
    )
    await client.post(
        "/fuel-cost-configs",
        json={"customer": None, "truck_type": "Reefer", "fuel_cost_per_km": "0.65"},
        headers=headers,
    )

    response = await client.get("/fuel-cost-configs", headers=headers)
    assert response.status_code == 200
    data = response.json()
    assert isinstance(data, list)
    assert len(data) >= 2


@pytest.mark.asyncio
async def test_list_filter_by_truck_type(client, auth_token, clean_table) -> None:
    headers = {"Authorization": f"Bearer {auth_token}"}
    await client.post(
        "/fuel-cost-configs",
        json={"customer": None, "truck_type": "Reefer", "fuel_cost_per_km": "0.65"},
        headers=headers,
    )
    await client.post(
        "/fuel-cost-configs",
        json={"customer": None, "truck_type": "Dryvan", "fuel_cost_per_km": "0.50"},
        headers=headers,
    )

    response = await client.get("/fuel-cost-configs?truck_type=Reefer", headers=headers)
    assert response.status_code == 200
    data = response.json()
    assert isinstance(data, list)
    assert all(item["truck_type"] == "Reefer" for item in data)


@pytest.mark.asyncio
async def test_list_filter_by_customer_name(client, auth_token, clean_table) -> None:
    headers = {"Authorization": f"Bearer {auth_token}"}
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
        json={"customer": None, "truck_type": "Reefer", "fuel_cost_per_km": "0.65"},
        headers=headers,
    )

    response = await client.get("/fuel-cost-configs?customer_name=Acme", headers=headers)
    assert response.status_code == 200
    data = response.json()
    assert isinstance(data, list)
    assert len(data) >= 1
    assert all(item["customer"]["name"] == "Acme" for item in data)


@pytest.mark.asyncio
async def test_list_returns_latest_version_per_uuid(client, auth_token, clean_table) -> None:
    headers = {"Authorization": f"Bearer {auth_token}"}
    create_resp = await client.post(
        "/fuel-cost-configs",
        json={"customer": None, "truck_type": "Flatbed", "fuel_cost_per_km": "0.40"},
        headers=headers,
    )
    assert create_resp.status_code == 201
    config_uuid = create_resp.json()["uuid"]

    await client.put(
        f"/fuel-cost-configs/{config_uuid}",
        json={"fuel_cost_per_km": "0.45"},
        headers=headers,
    )

    response = await client.get("/fuel-cost-configs?truck_type=Flatbed", headers=headers)
    assert response.status_code == 200
    data = response.json()
    # Should return only 1 entry (latest version) for this uuid
    flatbed_entries = [item for item in data if item["uuid"] == config_uuid]
    assert len(flatbed_entries) == 1
    assert flatbed_entries[0]["version"] == 2


@pytest.mark.asyncio
async def test_list_without_token_returns_401(client, clean_table) -> None:
    response = await client.get("/fuel-cost-configs")
    assert response.status_code == 401


@pytest.mark.asyncio
async def test_list_with_wrong_role_returns_403(client, clean_table) -> None:
    import os

    import httpx

    casdoor_url = os.environ.get("CASDOOR_URL", "http://localhost:8000")
    client_secret = os.environ.get("CASDOOR_CLIENT_SECRET", "transport-deluxe-secret")
    async with httpx.AsyncClient() as http:
        resp = await http.post(
            f"{casdoor_url}/api/login/oauth/access_token",
            data={
                "grant_type": "password",
                "client_id": "transport-deluxe-client",
                "client_secret": client_secret,
                "username": "test-margin-configurator",
                "password": "test123",
                "scope": "openid profile",
            },
            headers={"Content-Type": "application/x-www-form-urlencoded"},
            timeout=15.0,
        )
    wrong_token = resp.json()["access_token"]

    response = await client.get("/fuel-cost-configs", headers={"Authorization": f"Bearer {wrong_token}"})
    assert response.status_code == 403
