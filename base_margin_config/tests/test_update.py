import pytest


@pytest.mark.asyncio
async def test_update_config(client, auth_token, clean_table):
    headers = {"Authorization": f"Bearer {auth_token}"}
    create_resp = await client.post(
        "/base-margin-configs",
        json={"customer": {"name": "Acme"}, "margin_percent": 0.1},
        headers=headers,
    )
    assert create_resp.status_code == 201
    uuid = create_resp.json()["uuid"]
    assert create_resp.json()["version"] == 1

    update_resp = await client.put(
        f"/base-margin-configs/{uuid}",
        json={"margin_percent": 0.25},
        headers=headers,
    )
    assert update_resp.status_code == 200
    assert update_resp.json()["version"] == 2
    assert update_resp.json()["margin_percent"] == 0.25

    get_resp = await client.get(f"/base-margin-configs/{uuid}", headers=headers)
    assert get_resp.status_code == 200
    assert get_resp.json()["margin_percent"] == 0.25
    assert get_resp.json()["version"] == 2


@pytest.mark.asyncio
async def test_update_not_found(client, auth_token, clean_table):
    headers = {"Authorization": f"Bearer {auth_token}"}
    update_resp = await client.put(
        "/base-margin-configs/00000000-0000-0000-0000-000000000000",
        json={"margin_percent": 0.25},
        headers=headers,
    )
    assert update_resp.status_code == 404
