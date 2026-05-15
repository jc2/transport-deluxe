import pytest
from httpx import AsyncClient


@pytest.mark.asyncio
async def test_auth_requires_token(client: AsyncClient) -> None:
    response = await client.get("/lead-time-configs")
    assert response.status_code == 401
