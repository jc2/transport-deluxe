import pytest
from httpx import AsyncClient


@pytest.mark.asyncio
async def test_create_config_success(client: AsyncClient, clean_table, auth_token: str):
    payload = {"min_days": 0, "max_days": 1, "configuration_factor": "0.2000"}

    response = await client.post("/lead-time-configs/", json=payload, headers={"Authorization": f"Bearer {auth_token}"})

    assert response.status_code == 201
    data = response.json()
    assert data["min_days"] == 0
    assert data["max_days"] == 1
    assert data["configuration_factor"] == "0.2000"
    assert data["version"] == 1


@pytest.mark.asyncio
async def test_create_config_invalid_range(client: AsyncClient, clean_table, auth_token: str):
    payload = {"min_days": 5, "max_days": 3, "configuration_factor": "0.05"}

    response = await client.post("/lead-time-configs/", json=payload, headers={"Authorization": f"Bearer {auth_token}"})

    assert response.status_code == 422
    data = response.json()
    assert "min_days cannot be greater than max_days" in data["detail"][0]["msg"]


@pytest.mark.asyncio
async def test_create_config_duplicate(client: AsyncClient, clean_table, auth_token: str):
    payload = {"min_days": 6, "max_days": None, "configuration_factor": "0.00"}

    # First request
    await client.post("/lead-time-configs/", json=payload, headers={"Authorization": f"Bearer {auth_token}"})

    # Second request
    response2 = await client.post(
        "/lead-time-configs/", json=payload, headers={"Authorization": f"Bearer {auth_token}"}
    )

    assert response2.status_code == 409
    data = response2.json()
    assert "already exists for this min/max combination" in data["messages"][0]
