import pytest

ENDPOINT = "/base-margin-configs"

VALID_PAYLOAD = {
    "customer": {"name": "AuthTestCo"},
    "margin_percent": 0.10,
}


@pytest.mark.asyncio
async def test_create_requires_valid_auth(client, auth_token, clean_table):
    """Verifica que un token válido con el rol correcto permite crear una configuración."""
    headers = {"Authorization": f"Bearer {auth_token}"}
    response = await client.post(ENDPOINT, json=VALID_PAYLOAD, headers=headers)
    assert response.status_code == 201


@pytest.mark.asyncio
async def test_list_requires_valid_auth(client, auth_token, clean_table):
    """Verifica que un token válido con el rol correcto permite listar configuraciones."""
    headers = {"Authorization": f"Bearer {auth_token}"}
    response = await client.get(ENDPOINT, headers=headers)
    assert response.status_code == 200


@pytest.mark.asyncio
async def test_delete_requires_valid_auth(client, auth_token, clean_table):
    """Verifica que un token válido con el rol correcto permite eliminar una configuración."""
    headers = {"Authorization": f"Bearer {auth_token}"}

    create_response = await client.post(ENDPOINT, json=VALID_PAYLOAD, headers=headers)
    assert create_response.status_code == 201
    uuid = create_response.json()["uuid"]

    delete_response = await client.delete(f"{ENDPOINT}/{uuid}", headers=headers)
    assert delete_response.status_code == 204
