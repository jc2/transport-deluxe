import pytest


@pytest.mark.asyncio
async def test_create_full_route(client, auth_token, clean_table) -> None:
    headers = {"Authorization": f"Bearer {auth_token}"}
    response = await client.post(
        "/driver-tariff-configs",
        json={"pickup_state": "TX", "drop_state": "CA", "tariff_factor": "1.50"},
        headers=headers,
    )
    assert response.status_code == 201
    data = response.json()
    assert data["version"] == 1
    assert data["pickup_state"] == "TX"
    assert data["drop_state"] == "CA"
    assert str(data["tariff_factor"]) == "1.5000"


@pytest.mark.asyncio
async def test_create_origin_default(client, auth_token, clean_table) -> None:
    headers = {"Authorization": f"Bearer {auth_token}"}
    response = await client.post(
        "/driver-tariff-configs",
        json={"pickup_state": "TX", "drop_state": None, "tariff_factor": "1.20"},
        headers=headers,
    )
    assert response.status_code == 201
    data = response.json()
    assert data["pickup_state"] == "TX"
    assert data["drop_state"] is None


@pytest.mark.asyncio
async def test_create_dest_default(client, auth_token, clean_table) -> None:
    headers = {"Authorization": f"Bearer {auth_token}"}
    response = await client.post(
        "/driver-tariff-configs",
        json={"pickup_state": None, "drop_state": "CA", "tariff_factor": "1.10"},
        headers=headers,
    )
    assert response.status_code == 201
    data = response.json()
    assert data["pickup_state"] is None
    assert data["drop_state"] == "CA"


@pytest.mark.asyncio
async def test_create_409_on_duplicate_active(client, auth_token, clean_table) -> None:
    headers = {"Authorization": f"Bearer {auth_token}"}
    await client.post(
        "/driver-tariff-configs",
        json={"pickup_state": "TX", "drop_state": "CA", "tariff_factor": "1.50"},
        headers=headers,
    )

    response = await client.post(
        "/driver-tariff-configs",
        json={"pickup_state": "TX", "drop_state": "CA", "tariff_factor": "1.55"},
        headers=headers,
    )
    assert response.status_code == 409


@pytest.mark.asyncio
async def test_create_400_on_zero_factor(client, auth_token, clean_table) -> None:
    headers = {"Authorization": f"Bearer {auth_token}"}
    response = await client.post(
        "/driver-tariff-configs",
        json={"pickup_state": "TX", "drop_state": "CA", "tariff_factor": "0"},
        headers=headers,
    )
    assert response.status_code == 422


@pytest.mark.asyncio
async def test_create_400_on_negative_factor(client, auth_token, clean_table) -> None:
    headers = {"Authorization": f"Bearer {auth_token}"}
    response = await client.post(
        "/driver-tariff-configs",
        json={"pickup_state": "TX", "drop_state": "CA", "tariff_factor": "-0.10"},
        headers=headers,
    )
    assert response.status_code == 422


@pytest.mark.asyncio
async def test_create_201_on_no_states(client, auth_token, clean_table) -> None:
    headers = {"Authorization": f"Bearer {auth_token}"}
    response = await client.post(
        "/driver-tariff-configs",
        json={"pickup_state": None, "drop_state": None, "tariff_factor": "1.00"},
        headers=headers,
    )
    assert response.status_code == 201


@pytest.mark.asyncio
async def test_create_created_by_from_jwt(client, auth_token, clean_table) -> None:
    headers = {"Authorization": f"Bearer {auth_token}"}
    response = await client.post(
        "/driver-tariff-configs",
        json={"pickup_state": "TX", "drop_state": "CA", "tariff_factor": "1.50"},
        headers=headers,
    )
    assert response.status_code == 201
    data = response.json()
    assert data["created_by"] == "test-cost-configurator"


@pytest.mark.asyncio
async def test_create_401_without_token(client, clean_table) -> None:
    response = await client.post(
        "/driver-tariff-configs",
        json={"pickup_state": "TX", "drop_state": "CA", "tariff_factor": "1.50"},
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
        "/driver-tariff-configs",
        json={"pickup_state": "TX", "drop_state": "CA", "tariff_factor": "1.50"},
        headers={"Authorization": f"Bearer {wrong_token}"},
    )
    assert response.status_code == 403
