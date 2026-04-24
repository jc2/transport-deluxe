import pytest


@pytest.mark.asyncio
async def test_list_pagination(client, auth_token, clean_table) -> None:
    headers = {"Authorization": f"Bearer {auth_token}"}

    # Create 5 items
    for i in range(5):
        await client.post(
            "/driver-tariff-configs",
            json={"pickup_state": f"ST{i}", "drop_state": "CA", "tariff_factor": f"1.{i}0"},
            headers=headers,
        )

    # list page 1
    resp1 = await client.get("/driver-tariff-configs?page=1&page_size=2", headers=headers)
    data1 = resp1.json()
    assert len(data1["data"]) == 2
    assert data1["page"] == 1
    assert data1["total"] == 5

    # list page 3
    resp3 = await client.get("/driver-tariff-configs?page=3&page_size=2", headers=headers)
    data3 = resp3.json()
    assert len(data3["data"]) == 1
    assert data3["page"] == 3


@pytest.mark.asyncio
async def test_list_include_inactive_with_uuid_returns_history_version_asc(client, auth_token, clean_table) -> None:
    headers = {"Authorization": f"Bearer {auth_token}"}
    create_resp = await client.post(
        "/driver-tariff-configs",
        json={"pickup_state": "TX", "drop_state": "CA", "tariff_factor": "1.50"},
        headers=headers,
    )
    assert create_resp.status_code == 201
    config_uuid = create_resp.json()["uuid"]

    await client.put(
        f"/driver-tariff-configs/{config_uuid}",
        json={"tariff_factor": "1.60"},
        headers=headers,
    )

    response = await client.get(f"/driver-tariff-configs?uuid={config_uuid}", headers=headers)
    assert response.status_code == 200
    data = response.json()
    assert data["total"] == 2
    versions = [item["version"] for item in data["data"]]
    assert versions == sorted(versions)


@pytest.mark.asyncio
async def test_list_without_token_returns_401(client, clean_table) -> None:
    response = await client.get("/driver-tariff-configs")
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

    response = await client.get("/driver-tariff-configs", headers={"Authorization": f"Bearer {wrong_token}"})
    assert response.status_code == 403
