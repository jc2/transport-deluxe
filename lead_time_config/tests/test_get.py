import pytest
from httpx import AsyncClient


@pytest.mark.asyncio
async def test_get_config_success(client: AsyncClient, clean_table, auth_token: str):
    # Step 1: Create
    payload = {"min_days": 2, "max_days": 5, "configuration_factor": "0.15"}

    create_resp = await client.post(
        "/lead-time-configs/", json=payload, headers={"Authorization": f"Bearer {auth_token}"}
    )

    assert create_resp.status_code == 201
    created_data = create_resp.json()
    config_uuid = created_data["uuid"]

    # Step 2: Get
    get_resp = await client.get(f"/lead-time-configs/{config_uuid}", headers={"Authorization": f"Bearer {auth_token}"})

    assert get_resp.status_code == 200
    get_data = get_resp.json()
    assert get_data["uuid"] == config_uuid
    assert get_data["min_days"] == 2
    assert get_data["max_days"] == 5
    assert get_data["configuration_factor"] == "0.1500"
    assert get_data["version"] == 1


@pytest.mark.asyncio
async def test_get_config_not_found(client: AsyncClient, clean_table, auth_token: str):
    import uuid

    random_uuid = str(uuid.uuid4())

    get_resp = await client.get(f"/lead-time-configs/{random_uuid}", headers={"Authorization": f"Bearer {auth_token}"})

    assert get_resp.status_code == 404
    assert get_resp.json()["messages"] == ["No active configuration found for this UUID"]
