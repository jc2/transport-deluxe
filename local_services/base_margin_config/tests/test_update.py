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
        json={"customer": {"name": "Acme Inc."}, "pickup": {"country": "US"}, "margin_percent": 0.25},
        headers=headers,
    )
    assert update_resp.status_code == 200, update_resp.text
    data = update_resp.json()
    assert data["version"] == 2
    assert data["margin_percent"] == 0.25
    assert data["customer_name"] == "Acme Inc."
    assert data["pickup_country"] == "US"

    get_resp = await client.get(f"/base-margin-configs/{uuid}", headers=headers)
    assert get_resp.status_code == 200
    g_data = get_resp.json()
    assert g_data["margin_percent"] == 0.25
    assert g_data["version"] == 2
    assert g_data["customer_name"] == "Acme Inc."
    assert g_data["pickup_country"] == "US"


@pytest.mark.asyncio
async def test_update_not_found(client, auth_token, clean_table):
    headers = {"Authorization": f"Bearer {auth_token}"}
    update_resp = await client.put(
        "/base-margin-configs/00000000-0000-0000-0000-000000000000",
        json={"customer": {"name": "Acme Inc."}, "margin_percent": 0.25},
        headers=headers,
    )
    assert update_resp.status_code == 404
