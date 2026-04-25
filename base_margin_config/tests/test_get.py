import pytest


@pytest.mark.asyncio
async def test_get_config(client, auth_token, clean_table):
    headers = {"Authorization": f"Bearer {auth_token}"}
    create_resp = await client.post(
        "/base-margin-configs",
        json={"customer": {"name": "Acme"}, "margin_percent": 0.1},
        headers=headers,
    )
    uuid = create_resp.json()["uuid"]

    get_resp = await client.get(f"/base-margin-configs/{uuid}", headers=headers)
    assert get_resp.status_code == 200
    assert get_resp.json()["uuid"] == uuid
    assert get_resp.json()["margin_percent"] == 0.1


@pytest.mark.asyncio
async def test_get_not_found(client, auth_token, clean_table):
    headers = {"Authorization": f"Bearer {auth_token}"}
    get_resp = await client.get("/base-margin-configs/00000000-0000-0000-0000-000000000000", headers=headers)
    assert get_resp.status_code == 404
