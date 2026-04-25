import pytest
from httpx import AsyncClient


@pytest.mark.asyncio
async def test_update_config_success(client: AsyncClient, clean_table, auth_token: str):
    # Step 1: Create
    payload = {"min_days": 2, "max_days": 5, "configuration_factor": "0.05"}

    create_resp = await client.post(
        "/lead-time-configs/", json=payload, headers={"Authorization": f"Bearer {auth_token}"}
    )

    assert create_resp.status_code == 201
    created_data = create_resp.json()
    config_uuid = created_data["uuid"]

    # Step 2: Update
    update_payload = {"configuration_factor": "0.10"}

    update_resp = await client.patch(
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
