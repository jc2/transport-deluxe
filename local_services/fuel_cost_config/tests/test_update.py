import pytest


@pytest.mark.asyncio
async def test_update_creates_new_version(client, auth_token, clean_table) -> None:
    headers = {"Authorization": f"Bearer {auth_token}"}
    create_resp = await client.post(
        "/fuel-cost-configs",
        json={"customer": None, "truck_type": "reefer", "fuel_cost_per_km": "0.65"},
        headers=headers,
    )
    config_uuid = create_resp.json()["uuid"]

    update_resp = await client.put(
        f"/fuel-cost-configs/{config_uuid}",
        json={"fuel_cost_per_km": "0.70"},
        headers=headers,
    )
    assert update_resp.status_code == 200
    data = update_resp.json()
    assert data["version"] == 2
    assert data["uuid"] == config_uuid
    assert str(data["fuel_cost_per_km"]) == "0.7000"


@pytest.mark.asyncio
async def test_update_404_unknown_uuid(client, auth_token, clean_table) -> None:
    headers = {"Authorization": f"Bearer {auth_token}"}
    response = await client.put(
        "/fuel-cost-configs/00000000-0000-0000-0000-000000000000",
        json={"fuel_cost_per_km": "0.50"},
        headers=headers,
    )
    assert response.status_code == 404


@pytest.mark.asyncio
async def test_update_401_without_token(client, clean_table) -> None:
    response = await client.put(
        "/fuel-cost-configs/00000000-0000-0000-0000-000000000000",
        json={"fuel_cost_per_km": "0.50"},
    )
    assert response.status_code == 401


@pytest.mark.asyncio
async def test_update_created_by_from_jwt(client, auth_token, clean_table) -> None:
    headers = {"Authorization": f"Bearer {auth_token}"}
    create_resp = await client.post(
        "/fuel-cost-configs",
        json={"customer": None, "truck_type": "dryvan", "fuel_cost_per_km": "0.50"},
        headers=headers,
    )
    config_uuid = create_resp.json()["uuid"]

    update_resp = await client.put(
        f"/fuel-cost-configs/{config_uuid}",
        json={"fuel_cost_per_km": "0.55"},
        headers=headers,
    )
    assert update_resp.status_code == 200
    assert update_resp.json()["created_by"] == "test-cost-configurator"
