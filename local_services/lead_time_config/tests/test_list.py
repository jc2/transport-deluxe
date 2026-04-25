import pytest
from httpx import AsyncClient


@pytest.mark.asyncio
async def test_list_configs_success(client: AsyncClient, clean_table, auth_token: str):
    # Create configurations
    configs = [
        {"min_days": 0, "max_days": 1, "configuration_factor": "0.20"},  # Urgent (0-1)
        {"min_days": 2, "max_days": 5, "configuration_factor": "0.05"},  # Standard (2-5)
    ]
    for cfg in configs:
        resp = await client.post("/lead-time-configs/", json=cfg, headers={"Authorization": f"Bearer {auth_token}"})
        assert resp.status_code == 201

    # Get list
    list_resp = await client.get(
        "/lead-time-configs/?page=1&page_size=10", headers={"Authorization": f"Bearer {auth_token}"}
    )

    assert list_resp.status_code == 200
    list_data = list_resp.json()
    assert list_data["total"] == 2
    assert len(list_data["data"]) == 2


@pytest.mark.asyncio
async def test_list_configs_pagination(client: AsyncClient, clean_table, auth_token: str):
    # Create multiple items using separate config to avoid collision
    for i in range(15):
        payload = {"min_days": i * 10, "max_days": i * 10 + 5, "configuration_factor": "0.10"}
        await client.post("/lead-time-configs/", json=payload, headers={"Authorization": f"Bearer {auth_token}"})

    list_resp = await client.get(
        "/lead-time-configs/?page=2&page_size=10", headers={"Authorization": f"Bearer {auth_token}"}
    )

    assert list_resp.status_code == 200
    list_data = list_resp.json()
    assert list_data["page"] == 2
    assert list_data["page_size"] == 10
    assert list_data["total"] == 15
    assert len(list_data["data"]) == 5
