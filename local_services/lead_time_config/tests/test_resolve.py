import pytest
from httpx import AsyncClient


@pytest.mark.asyncio
async def test_resolve_config_success(client: AsyncClient, clean_table, auth_token: str):
    # Retrieve a token for 'predictor' to test the resolve endpoint correctly
    # For testing simpler paths we just use the default margin-configurator from the fixture,
    # but let's assume margin-configurator lacks predictor.
    # So we generate predictor token here.
    import os

    import httpx

    CASDOOR_URL = os.environ.get("CASDOOR_URL", "http://localhost:8000")
    CLIENT_ID = "transport-deluxe-client"
    CLIENT_SECRET = "transport-deluxe-secret"

    async with httpx.AsyncClient() as ac:
        await ac.post(
            f"{CASDOOR_URL}/api/login/oauth/access_token",
            data={
                "grant_type": "password",
                "client_id": CLIENT_ID,
                "client_secret": CLIENT_SECRET,
                "username": "test-predictor",
                "password": "test123",
                "scope": "openid profile",
            },
            headers={"Content-Type": "application/x-www-form-urlencoded"},
            timeout=15.0,
        )

    # 1. Provide Config rules using the configurator
    configs = [
        {"min_days": 0, "max_days": 1, "configuration_factor": "0.20"},  # Urgent (0-1)
        {"min_days": 2, "max_days": 5, "configuration_factor": "0.05"},  # Standard (2-5)
        {"min_days": 6, "max_days": None, "configuration_factor": "0.00"},  # Standard (6+)
    ]
    for cfg in configs:
        resp = await client.post("/lead-time-configs/", json=cfg, headers={"Authorization": f"Bearer {auth_token}"})
        assert resp.status_code == 201

    # 2. Test resolutions
    # A) 1 day
    resolve_resp = await client.post("/lead-time-configs/resolve", json={"days_to_shipment": 1})
    assert resolve_resp.status_code == 200
    assert resolve_resp.json()["configuration_factor"] == "0.2000"

    # B) 3 days
    resolve_resp = await client.post("/lead-time-configs/resolve", json={"days_to_shipment": 3})
    assert resolve_resp.status_code == 200
    assert resolve_resp.json()["configuration_factor"] == "0.0500"

    # C) 10 days
    resolve_resp = await client.post("/lead-time-configs/resolve", json={"days_to_shipment": 10})
    assert resolve_resp.status_code == 200
    assert resolve_resp.json()["configuration_factor"] == "0.0000"


@pytest.mark.asyncio
async def test_resolve_config_no_match(client: AsyncClient, clean_table, auth_token: str):
    import os

    import httpx

    CASDOOR_URL = os.environ.get("CASDOOR_URL", "http://localhost:8000")
    CLIENT_ID = "transport-deluxe-client"
    CLIENT_SECRET = "transport-deluxe-secret"

    async with httpx.AsyncClient() as ac:
        await ac.post(
            f"{CASDOOR_URL}/api/login/oauth/access_token",
            data={
                "grant_type": "password",
                "client_id": CLIENT_ID,
                "client_secret": CLIENT_SECRET,
                "username": "test-predictor",
                "password": "test123",
                "scope": "openid profile",
            },
            headers={"Content-Type": "application/x-www-form-urlencoded"},
            timeout=15.0,
        )

    # Just create a rule for 5-10
    cfg = {"min_days": 5, "max_days": 10, "configuration_factor": "0.10"}
    resp = await client.post("/lead-time-configs/", json=cfg, headers={"Authorization": f"Bearer {auth_token}"})
    assert resp.status_code == 201

    # Request for 2 days
    resolve_resp = await client.post("/lead-time-configs/resolve", json={"days_to_shipment": 2})
    assert resolve_resp.status_code == 400
    assert "No active lead time configuration found" in resolve_resp.json()["messages"][0]
