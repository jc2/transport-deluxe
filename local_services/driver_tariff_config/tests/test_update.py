import pytest


@pytest.mark.asyncio
async def test_update_success(client, auth_token, clean_table) -> None:
    headers = {"Authorization": f"Bearer {auth_token}"}

    create_resp = await client.post(
        "/driver-tariff-configs",
        json={"pickup_state": "TX", "drop_state": "CA", "tariff_factor": "1.50"},
        headers=headers,
    )
    uuid = create_resp.json()["uuid"]

    update_resp = await client.put(
        f"/driver-tariff-configs/{uuid}",
        json={"tariff_factor": "1.75"},
        headers=headers,
    )
    assert update_resp.status_code == 200
    data = update_resp.json()
    assert data["version"] == 2
    assert str(data["tariff_factor"]) == "1.7500"

    get_resp = await client.get(f"/driver-tariff-configs/{uuid}", headers=headers)
    assert get_resp.json()["version"] == 2


@pytest.mark.asyncio
async def test_update_404_unknown_uuid(client, auth_token, clean_table) -> None:
    headers = {"Authorization": f"Bearer {auth_token}"}
    import uuid

    dummy_uuid = str(uuid.uuid4())
    response = await client.put(
        f"/driver-tariff-configs/{dummy_uuid}",
        json={"tariff_factor": "1.75"},
        headers=headers,
    )
    assert response.status_code == 404


@pytest.mark.asyncio
async def test_update_401_without_token(client, clean_table) -> None:
    import uuid

    dummy_uuid = str(uuid.uuid4())
    response = await client.put(
        f"/driver-tariff-configs/{dummy_uuid}",
        json={"tariff_factor": "1.75"},
    )
    assert response.status_code == 401


@pytest.mark.asyncio
async def test_update_created_by_from_jwt(client, auth_token, clean_table) -> None:
    headers = {"Authorization": f"Bearer {auth_token}"}
    create_resp = await client.post(
        "/driver-tariff-configs",
        json={"pickup_state": "TX", "drop_state": "CA", "tariff_factor": "1.50"},
        headers=headers,
    )
    config_uuid = create_resp.json()["uuid"]

    update_resp = await client.put(
        f"/driver-tariff-configs/{config_uuid}",
        json={"tariff_factor": "1.55"},
        headers=headers,
    )
    assert update_resp.status_code == 200
    assert update_resp.json()["created_by"] == "test-cost-configurator"
