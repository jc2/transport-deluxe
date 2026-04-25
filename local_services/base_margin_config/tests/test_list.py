import pytest


@pytest.mark.asyncio
async def test_list_configs(client, auth_token, clean_table):
    headers = {"Authorization": f"Bearer {auth_token}"}
    await client.post("/base-margin-configs", json={"customer": {"name": "A"}, "margin_percent": 0.1}, headers=headers)
    await client.post("/base-margin-configs", json={"customer": {"name": "B"}, "margin_percent": 0.2}, headers=headers)

    resp = await client.get("/base-margin-configs", headers=headers)
    assert resp.status_code == 200
    assert len(resp.json()) == 2
