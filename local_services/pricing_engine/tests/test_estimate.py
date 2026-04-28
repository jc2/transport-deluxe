import uuid
from unittest.mock import patch

import httpx
import pytest

pytestmark = pytest.mark.asyncio


async def test_price_success(async_client: httpx.AsyncClient):
    correlation_id = str(uuid.uuid4())

    payload = {
        "load": {
            "route": {
                "pickup": {"country": "USA", "state": "NY", "city": "New York", "postal_code": "10001"},
                "drop": {"country": "USA", "state": "CA", "city": "Los Angeles", "postal_code": "90001"},
            },
            "customer": {"name": "Test Customer"},
            "truck_type": "Reefer",
            "ship_date": "2026-04-27",
            "distance_km": 4000.0,
        }
    }

    mock_costing_resp = {
        "correlation_id": correlation_id,
        "load": payload["load"],
        "adjustments": [],
        "all_in_cost": 1500.50,
    }

    mock_margin_resp = {
        "correlation_id": correlation_id,
        "load": payload["load"],
        "adjustments": [],
        "all_in_cost": 1500.50,
        "all_in_margin": 300.00,
    }

    orig_post = httpx.AsyncClient.post

    async def mock_post_async(self, url, **kwargs):
        u = str(url)
        if "costing-engine" in u:
            return httpx.Response(200, json=mock_costing_resp, request=httpx.Request("POST", url))
        if "margin-engine" in u:
            return httpx.Response(200, json=mock_margin_resp, request=httpx.Request("POST", url))
        return await orig_post(self, url, **kwargs)

    with patch("httpx.AsyncClient.post", new=mock_post_async):
        response = await async_client.post(
            "/price/estimate", json=payload, headers={"x-correlation-id": correlation_id}
        )

        assert response.status_code == 200, response.text
        data = response.json()

        assert data["correlation_id"] == correlation_id
        assert float(data["all_in_rate"]) == 1800.50
        assert len(data["adjustments"]) == 2
        assert data["adjustments"][0]["name"] == "All In Cost Adjustment"
        assert float(data["adjustments"][0]["amount"]) == 1500.50
        assert data["adjustments"][1]["name"] == "All In Margin Adjustment"
        assert float(data["adjustments"][1]["amount"]) == 300.00
        assert float(data["all_in_cost"]) == 1500.50
        assert float(data["all_in_margin"]) == 300.00
