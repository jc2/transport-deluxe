import pytest


@pytest.mark.asyncio
async def test_get_by_uuid(client, auth_token, clean_table) -> None:
    headers = {"Authorization": f"Bearer {auth_token}"}
    post_response = await client.post(
        "/driver-tariff-configs",
        json={"pickup_state": "TX", "drop_state": "CA", "tariff_factor": "1.50"},
        headers=headers,
    )
    assert post_response.status_code == 201
    uuid = post_response.json()["uuid"]

    get_response = await client.get(f"/driver-tariff-configs/{uuid}", headers=headers)
    assert get_response.status_code == 200
    data = get_response.json()
    assert data["uuid"] == uuid
    assert str(data["tariff_factor"]) == "1.5000"


@pytest.mark.asyncio
async def test_get_401_without_token(client, clean_table) -> None:
    response = await client.get("/driver-tariff-configs/00000000-0000-0000-0000-000000000000")
    assert response.status_code == 401


@pytest.mark.asyncio
async def test_get_404_on_missing(client, auth_token, clean_table) -> None:
    headers = {"Authorization": f"Bearer {auth_token}"}
    import uuid

    dummy_uuid = str(uuid.uuid4())
    get_response = await client.get(f"/driver-tariff-configs/{dummy_uuid}", headers=headers)
    assert get_response.status_code == 404
