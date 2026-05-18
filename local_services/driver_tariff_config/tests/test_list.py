import pytest


@pytest.mark.asyncio
async def test_list_returns_latest_versions(client, auth_token, clean_table) -> None:
    headers = {"Authorization": f"Bearer {auth_token}"}

    # Create 3 configs
    for state in ["TX", "CA", "NY"]:
        await client.post(
            "/driver-tariff-configs",
            json={"pickup_state": state, "drop_state": None, "tariff_factor": "1.20"},
            headers=headers,
        )

    resp = await client.get("/driver-tariff-configs", headers=headers)
    assert resp.status_code == 200
    data = resp.json()
    assert isinstance(data, list)
    assert len(data) == 3
    # Each item should have version == 1 (no updates yet)
    assert all(item["version"] == 1 for item in data)


@pytest.mark.asyncio
async def test_list_filter_by_pickup_state(client, auth_token, clean_table) -> None:
    headers = {"Authorization": f"Bearer {auth_token}"}

    await client.post(
        "/driver-tariff-configs",
        json={"pickup_state": "TX", "drop_state": "CA", "tariff_factor": "1.50"},
        headers=headers,
    )
    await client.post(
        "/driver-tariff-configs",
        json={"pickup_state": "NY", "drop_state": "FL", "tariff_factor": "1.30"},
        headers=headers,
    )

    resp = await client.get("/driver-tariff-configs?pickup_state=TX", headers=headers)
    assert resp.status_code == 200
    data = resp.json()
    assert len(data) == 1
    assert data[0]["pickup_state"] == "TX"


@pytest.mark.asyncio
async def test_list_without_token_returns_401(client, clean_table) -> None:
    response = await client.get("/driver-tariff-configs")
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

    response = await client.get("/driver-tariff-configs", headers={"Authorization": f"Bearer {wrong_token}"})
    assert response.status_code == 403
