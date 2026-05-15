import pytest
from httpx import AsyncClient


@pytest.mark.asyncio
async def test_update_config_success(client: AsyncClient, clean_table, auth_token: str):
    # Step 1: Create
    payload = {"min_days": 2, "max_days": 5, "configuration_factor": "0.05"}

    create_resp = await client.post(
        "/lead-time-configs", json=payload, headers={"Authorization": f"Bearer {auth_token}"}
    )

    assert create_resp.status_code == 201
    created_data = create_resp.json()
    config_uuid = created_data["uuid"]

    # Step 2: Update
    update_payload = {"configuration_factor": "0.10"}

    update_resp = await client.put(
        f"/lead-time-configs/{config_uuid}", json=update_payload, headers={"Authorization": f"Bearer {auth_token}"}
    )

    assert update_resp.status_code == 200
    updated_data = update_resp.json()
    assert updated_data["uuid"] == config_uuid
    assert updated_data["version"] == 2
    assert updated_data["configuration_factor"] == "0.1000"
    assert updated_data["min_days"] == 2
    assert updated_data["max_days"] == 5

    # Check history
    get_resp = await client.get(f"/lead-time-configs/{config_uuid}", headers={"Authorization": f"Bearer {auth_token}"})
    assert get_resp.status_code == 200
    get_data = get_resp.json()
    assert get_data["version"] == 2


@pytest.mark.asyncio
async def test_update_min_days(client: AsyncClient, clean_table, auth_token: str):
    create_resp = await client.post(
        "/lead-time-configs",
        json={"min_days": 2, "max_days": 8, "configuration_factor": "0.05"},
        headers={"Authorization": f"Bearer {auth_token}"},
    )
    assert create_resp.status_code == 201
    config_uuid = create_resp.json()["uuid"]

    update_resp = await client.put(
        f"/lead-time-configs/{config_uuid}",
        json={"min_days": 4},
        headers={"Authorization": f"Bearer {auth_token}"},
    )
    assert update_resp.status_code == 200
    data = update_resp.json()
    assert data["min_days"] == 4
    assert data["max_days"] == 8
    assert data["configuration_factor"] == "0.0500"
    assert data["version"] == 2


@pytest.mark.asyncio
async def test_update_max_days(client: AsyncClient, clean_table, auth_token: str):
    create_resp = await client.post(
        "/lead-time-configs",
        json={"min_days": 2, "max_days": 5, "configuration_factor": "0.05"},
        headers={"Authorization": f"Bearer {auth_token}"},
    )
    assert create_resp.status_code == 201
    config_uuid = create_resp.json()["uuid"]

    update_resp = await client.put(
        f"/lead-time-configs/{config_uuid}",
        json={"max_days": 10},
        headers={"Authorization": f"Bearer {auth_token}"},
    )
    assert update_resp.status_code == 200
    data = update_resp.json()
    assert data["min_days"] == 2
    assert data["max_days"] == 10
    assert data["configuration_factor"] == "0.0500"
    assert data["version"] == 2


@pytest.mark.asyncio
async def test_update_min_and_max_days(client: AsyncClient, clean_table, auth_token: str):
    create_resp = await client.post(
        "/lead-time-configs",
        json={"min_days": 2, "max_days": 5, "configuration_factor": "0.05"},
        headers={"Authorization": f"Bearer {auth_token}"},
    )
    assert create_resp.status_code == 201
    config_uuid = create_resp.json()["uuid"]

    update_resp = await client.put(
        f"/lead-time-configs/{config_uuid}",
        json={"min_days": 10, "max_days": 20, "configuration_factor": "0.12"},
        headers={"Authorization": f"Bearer {auth_token}"},
    )
    assert update_resp.status_code == 200
    data = update_resp.json()
    assert data["min_days"] == 10
    assert data["max_days"] == 20
    assert data["configuration_factor"] == "0.1200"
    assert data["version"] == 2


@pytest.mark.asyncio
async def test_update_range_overlap_rejected(client: AsyncClient, clean_table, auth_token: str):
    await client.post(
        "/lead-time-configs",
        json={"min_days": 0, "max_days": 3, "configuration_factor": "0.05"},
        headers={"Authorization": f"Bearer {auth_token}"},
    )
    create_resp2 = await client.post(
        "/lead-time-configs",
        json={"min_days": 4, "max_days": 7, "configuration_factor": "0.10"},
        headers={"Authorization": f"Bearer {auth_token}"},
    )
    config2_uuid = create_resp2.json()["uuid"]

    # Attempt to move config2's range so it overlaps config1
    update_resp = await client.put(
        f"/lead-time-configs/{config2_uuid}",
        json={"min_days": 3},
        headers={"Authorization": f"Bearer {auth_token}"},
    )
    assert update_resp.status_code == 409


@pytest.mark.asyncio
async def test_update_invalid_range_rejected(client: AsyncClient, clean_table, auth_token: str):
    create_resp = await client.post(
        "/lead-time-configs",
        json={"min_days": 2, "max_days": 5, "configuration_factor": "0.05"},
        headers={"Authorization": f"Bearer {auth_token}"},
    )
    assert create_resp.status_code == 201
    config_uuid = create_resp.json()["uuid"]

    # Update min_days to be greater than existing max_days
    update_resp = await client.put(
        f"/lead-time-configs/{config_uuid}",
        json={"min_days": 10},
        headers={"Authorization": f"Bearer {auth_token}"},
    )
    assert update_resp.status_code == 422
