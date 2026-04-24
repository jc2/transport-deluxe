import pytest


@pytest.mark.asyncio
async def test_create_system_level(client, auth_token, clean_table) -> None:
    headers = {"Authorization": f"Bearer {auth_token}"}
    response = await client.post(
        "/fuel-cost-configs",
        json={"customer": None, "truck_type": "dryvan", "fuel_cost_per_km": "0.50"},
        headers=headers,
    )
    assert response.status_code == 201
    data = response.json()
    assert data["version"] == 1
    assert data["customer"] is None
    assert data["truck_type"] == "dryvan"
    assert str(data["fuel_cost_per_km"]) == "0.5000"


@pytest.mark.asyncio
async def test_create_customer_level(client, auth_token, clean_table) -> None:
    headers = {"Authorization": f"Bearer {auth_token}"}
    response = await client.post(
        "/fuel-cost-configs",
        json={
            "customer": {"name": "Acme", "subname": None},
            "truck_type": "reefer",
            "fuel_cost_per_km": "0.60",
        },
        headers=headers,
    )
    assert response.status_code == 201
    data = response.json()
    assert data["customer"]["name"] == "Acme"
    assert data["customer"]["subname"] is None


@pytest.mark.asyncio
async def test_create_subcustomer_level(client, auth_token, clean_table) -> None:
    headers = {"Authorization": f"Bearer {auth_token}"}
    response = await client.post(
        "/fuel-cost-configs",
        json={
            "customer": {"name": "Acme", "subname": "East"},
            "truck_type": "flatbed",
            "fuel_cost_per_km": "0.45",
        },
        headers=headers,
    )
    assert response.status_code == 201
    data = response.json()
    assert data["customer"]["name"] == "Acme"
    assert data["customer"]["subname"] == "East"


@pytest.mark.asyncio
async def test_create_409_on_duplicate_active(client, auth_token, clean_table) -> None:
    headers = {"Authorization": f"Bearer {auth_token}"}
    await client.post(
        "/fuel-cost-configs",
        json={"customer": None, "truck_type": "dryvan", "fuel_cost_per_km": "0.50"},
        headers=headers,
    )

    response = await client.post(
        "/fuel-cost-configs",
        json={"customer": None, "truck_type": "dryvan", "fuel_cost_per_km": "0.55"},
        headers=headers,
    )
    assert response.status_code == 409


@pytest.mark.asyncio
async def test_create_400_on_zero_fuel_cost(client, auth_token, clean_table) -> None:
    headers = {"Authorization": f"Bearer {auth_token}"}
    response = await client.post(
        "/fuel-cost-configs",
        json={"customer": None, "truck_type": "reefer", "fuel_cost_per_km": "0"},
        headers=headers,
    )
    assert response.status_code == 422


@pytest.mark.asyncio
async def test_create_400_on_negative_fuel_cost(client, auth_token, clean_table) -> None:
    headers = {"Authorization": f"Bearer {auth_token}"}
    response = await client.post(
        "/fuel-cost-configs",
        json={"customer": None, "truck_type": "reefer", "fuel_cost_per_km": "-0.10"},
        headers=headers,
    )
    assert response.status_code == 422


@pytest.mark.asyncio
async def test_create_400_on_invalid_truck_type(client, auth_token, clean_table) -> None:
    headers = {"Authorization": f"Bearer {auth_token}"}
    response = await client.post(
        "/fuel-cost-configs",
        json={"customer": None, "truck_type": "helicopter", "fuel_cost_per_km": "0.50"},
        headers=headers,
    )
    assert response.status_code == 422


@pytest.mark.asyncio
async def test_create_created_by_from_jwt(client, auth_token, clean_table) -> None:
    headers = {"Authorization": f"Bearer {auth_token}"}
    response = await client.post(
        "/fuel-cost-configs",
        json={"customer": None, "truck_type": "flatbed", "fuel_cost_per_km": "0.40"},
        headers=headers,
    )
    assert response.status_code == 201
    data = response.json()
    assert data["created_by"] == "test-cost-configurator"


@pytest.mark.asyncio
async def test_create_401_without_token(client, clean_table) -> None:
    response = await client.post(
        "/fuel-cost-configs",
        json={"customer": None, "truck_type": "dryvan", "fuel_cost_per_km": "0.50"},
    )
    assert response.status_code == 401


@pytest.mark.asyncio
async def test_create_403_wrong_role(client, clean_table) -> None:
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

    response = await client.post(
        "/fuel-cost-configs",
        json={"customer": None, "truck_type": "dryvan", "fuel_cost_per_km": "0.50"},
        headers={"Authorization": f"Bearer {wrong_token}"},
    )
    assert response.status_code == 403
