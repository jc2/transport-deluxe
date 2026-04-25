import pytest


@pytest.mark.asyncio
async def test_get_returns_latest_active_version(client, auth_token, clean_table) -> None:
    headers = {"Authorization": f"Bearer {auth_token}"}
    create_resp = await client.post(
        "/fuel-cost-configs",
        json={"customer": None, "truck_type": "reefer", "fuel_cost_per_km": "0.65"},
        headers=headers,
    )
    config_uuid = create_resp.json()["uuid"]
    await client.put(
        f"/fuel-cost-configs/{config_uuid}",
        json={"fuel_cost_per_km": "0.70"},
        headers=headers,
    )

    response = await client.get(f"/fuel-cost-configs/{config_uuid}", headers=headers)
    assert response.status_code == 200
    data = response.json()
    assert data["version"] == 2
    assert str(data["fuel_cost_per_km"]) == "0.7000"


@pytest.mark.asyncio
async def test_get_401_without_token(client, clean_table) -> None:
    response = await client.get("/fuel-cost-configs/00000000-0000-0000-0000-000000000000")
    assert response.status_code == 401


@pytest.mark.asyncio
async def test_get_404_unknown_uuid(client, auth_token, clean_table) -> None:
    headers = {"Authorization": f"Bearer {auth_token}"}
    response = await client.get("/fuel-cost-configs/00000000-0000-0000-0000-000000000000", headers=headers)
    assert response.status_code == 404
