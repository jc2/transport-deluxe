import pytest


@pytest.mark.asyncio
async def test_list_returns_active_configs_with_pagination(client, auth_token, clean_table) -> None:
    headers = {"Authorization": f"Bearer {auth_token}"}
    payload = {"customer": None, "truck_type": "dryvan", "fuel_cost_per_km": "0.50"}
    await client.post("/fuel-cost-configs", json=payload, headers=headers)
    await client.post(
        "/fuel-cost-configs",
        json={"customer": None, "truck_type": "reefer", "fuel_cost_per_km": "0.65"},
        headers=headers,
    )

    response = await client.get("/fuel-cost-configs", headers=headers)
    assert response.status_code == 200
    data = response.json()
    assert "data" in data
    assert "page" in data
    assert "page_size" in data
    assert "total" in data
    assert "total_pages" in data
    assert data["total"] >= 2


@pytest.mark.asyncio
async def test_list_filter_by_truck_type(client, auth_token, clean_table) -> None:
    headers = {"Authorization": f"Bearer {auth_token}"}
    await client.post(
        "/fuel-cost-configs",
        json={"customer": None, "truck_type": "reefer", "fuel_cost_per_km": "0.65"},
        headers=headers,
    )
    await client.post(
        "/fuel-cost-configs",
        json={"customer": None, "truck_type": "dryvan", "fuel_cost_per_km": "0.50"},
        headers=headers,
    )

    response = await client.get("/fuel-cost-configs?truck_type=reefer", headers=headers)
    assert response.status_code == 200
    data = response.json()
    assert all(item["truck_type"] == "reefer" for item in data["data"])


@pytest.mark.asyncio
async def test_list_filter_by_customer_name(client, auth_token, clean_table) -> None:
    headers = {"Authorization": f"Bearer {auth_token}"}
    await client.post(
        "/fuel-cost-configs",
        json={
            "customer": {"name": "Acme", "subname": None},
            "truck_type": "reefer",
            "fuel_cost_per_km": "0.60",
        },
        headers=headers,
    )
    await client.post(
        "/fuel-cost-configs",
        json={"customer": None, "truck_type": "reefer", "fuel_cost_per_km": "0.65"},
        headers=headers,
    )

    response = await client.get("/fuel-cost-configs?customer_name=Acme", headers=headers)
    assert response.status_code == 200
    data = response.json()
    assert len(data["data"]) >= 1
    assert all(item["customer"]["name"] == "Acme" for item in data["data"])


@pytest.mark.asyncio
async def test_list_include_inactive_with_uuid_returns_history_version_asc(client, auth_token, clean_table) -> None:
    headers = {"Authorization": f"Bearer {auth_token}"}
    create_resp = await client.post(
        "/fuel-cost-configs",
        json={"customer": None, "truck_type": "flatbed", "fuel_cost_per_km": "0.40"},
        headers=headers,
    )
    assert create_resp.status_code == 201
    config_uuid = create_resp.json()["uuid"]

    await client.put(
        f"/fuel-cost-configs/{config_uuid}",
        json={"fuel_cost_per_km": "0.45"},
        headers=headers,
    )

    response = await client.get(f"/fuel-cost-configs?uuid={config_uuid}", headers=headers)
    assert response.status_code == 200
    data = response.json()
    assert data["total"] == 2
    versions = [item["version"] for item in data["data"]]
    assert versions == sorted(versions)


@pytest.mark.asyncio
async def test_list_without_token_returns_401(client, clean_table) -> None:
    response = await client.get("/fuel-cost-configs")
    assert response.status_code == 401


@pytest.mark.asyncio
async def test_list_with_wrong_role_returns_403(client, clean_table) -> None:
    import os

    import httpx

    casdoor_url = os.environ.get("CASDOOR_URL", "http://localhost:8000")
    async with httpx.AsyncClient() as http:
        resp = await http.post(
            f"{casdoor_url}/api/login/oauth/access_token",
            data={
                "grant_type": "password",
                "client_id": "transport-deluxe-client",
                "client_secret": "transport-deluxe-secret",
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
