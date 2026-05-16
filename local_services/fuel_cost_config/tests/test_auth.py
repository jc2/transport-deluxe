import pytest

ENDPOINT = "/fuel-cost-configs"

VALID_PAYLOAD = {
    "customer": None,
    "truck_type": "Dryvan",
    "fuel_cost_per_km": "0.50",
}


@pytest.mark.asyncio
async def test_create_requires_valid_auth(client, auth_token, clean_table):
    """A valid token with the correct role allows creating a configuration."""
    headers = {"Authorization": f"Bearer {auth_token}"}
    response = await client.post(ENDPOINT, json=VALID_PAYLOAD, headers=headers)
    assert response.status_code == 201


@pytest.mark.asyncio
async def test_list_requires_valid_auth(client, auth_token, clean_table):
    """A valid token with the correct role allows listing configurations."""
    headers = {"Authorization": f"Bearer {auth_token}"}
    response = await client.get(ENDPOINT, headers=headers)
    assert response.status_code == 200


@pytest.mark.asyncio
async def test_create_401_without_token(client, clean_table):
    """Creating without a token returns 401."""
    response = await client.post(ENDPOINT, json=VALID_PAYLOAD)
    assert response.status_code == 401


@pytest.mark.asyncio
async def test_list_401_without_token(client, clean_table):
    """Listing without a token returns 401."""
    response = await client.get(ENDPOINT)
    assert response.status_code == 401


@pytest.mark.asyncio
async def test_delete_requires_valid_auth(client, auth_token, clean_table):
    """A valid token with the correct role allows deleting a configuration."""
    headers = {"Authorization": f"Bearer {auth_token}"}

    create_response = await client.post(ENDPOINT, json=VALID_PAYLOAD, headers=headers)
    assert create_response.status_code == 201
    uuid = create_response.json()["uuid"]

    delete_response = await client.delete(f"{ENDPOINT}/{uuid}", headers=headers)
    assert delete_response.status_code == 204
