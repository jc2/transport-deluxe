import pytest
from httpx import AsyncClient


@pytest.mark.asyncio
async def test_min_days_range(client: AsyncClient, auth_token: str) -> None:
    # Test that min_days < 0 is rejected via Pydantic validator
    payload = {"min_days": -1, "max_days": 5, "configuration_factor": 0.05}
    response = await client.post("/lead-time-configs", json=payload, headers={"Authorization": f"Bearer {auth_token}"})
    assert response.status_code == 422
    assert "min_days cannot be negative" in response.text
