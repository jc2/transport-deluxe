import pytest


@pytest.mark.asyncio
async def test_create_success(client, auth_token, clean_table):
    headers = {"Authorization": f"Bearer {auth_token}"}
    response = await client.post(
        "/base-margin-configs",
        json={
            "customer": {"name": "Acme", "subname": None},
            "pickup": {"country": "US", "state": "CA", "city": "LA", "postal_code": "90210"},
            "margin_percent": 0.15,
        },
        headers=headers,
    )
    assert response.status_code == 201
    data = response.json()
    assert data["customer_name"] == "Acme"
    assert data["customer_subname"] is None
    assert data["pickup_country"] == "US"
    assert data["margin_percent"] == 0.15


@pytest.mark.asyncio
async def test_create_all_null_fails(client, auth_token, clean_table):
    headers = {"Authorization": f"Bearer {auth_token}"}
    # No customer, no pickup, no drop. margin_percent is present but that's not enough.
    response = await client.post(
        "/base-margin-configs",
        json={"margin_percent": 0.2},
        headers=headers,
    )
    assert response.status_code == 422


@pytest.mark.asyncio
async def test_create_duplicate_fails(client, auth_token, clean_table):
    headers = {"Authorization": f"Bearer {auth_token}"}
    payload = {
        "customer": {"name": "Acme"},
        "pickup": {"country": "US", "state": "CA", "city": "LA", "postal_code": "90210"},
        "margin_percent": 0.1,
    }
    r1 = await client.post("/base-margin-configs", json=payload, headers=headers)
    assert r1.status_code == 201

    r2 = await client.post("/base-margin-configs", json=payload, headers=headers)
    assert r2.status_code == 409


@pytest.mark.asyncio
async def test_create_invalid_margin(client, auth_token, clean_table):
    headers = {"Authorization": f"Bearer {auth_token}"}
    response = await client.post(
        "/base-margin-configs",
        json={
            "customer": {"name": "Acme"},
            "pickup": {"country": "US", "state": "CA", "city": "LA", "postal_code": "90210"},
            "margin_percent": 1.5,
        },
        headers=headers,
    )
    assert response.status_code == 422


@pytest.mark.asyncio
async def test_create_created_by_from_jwt(client, auth_token, clean_table) -> None:
    headers = {"Authorization": f"Bearer {auth_token}"}
    response = await client.post(
        "/base-margin-configs",
        json={
            "customer": {"name": "Acme"},
            "pickup": {"country": "US", "state": "CA", "city": "LA", "postal_code": "90210"},
            "margin_percent": 0.15,
        },
        headers=headers,
    )
    assert response.status_code == 201
    data = response.json()
    assert data["created_by"] == "test-margin-configurator"


@pytest.mark.asyncio
async def test_create_401_without_token(client, clean_table) -> None:
    response = await client.post(
        "/base-margin-configs",
        json={"customer": {"name": "Acme"}, "margin_percent": 0.15},
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
                "username": "test-cost-configurator",  # User without the margin-configurator role
                "password": "test123",
                "scope": "openid profile",
            },
            headers={"Content-Type": "application/x-www-form-urlencoded"},
            timeout=15.0,
        )
    wrong_token = resp.json()["access_token"]

    response = await client.post(
        "/base-margin-configs",
        json={"customer": {"name": "Acme"}, "margin_percent": 0.15},
        headers={"Authorization": f"Bearer {wrong_token}"},
    )
    assert response.status_code == 403
