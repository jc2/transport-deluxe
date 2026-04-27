import uuid
from decimal import Decimal
from unittest.mock import patch

import httpx
import pytest


@pytest.mark.asyncio
async def test_estimate_happy_path(client, auth_token, clean_table):
    correlation_id = str(uuid.uuid4())
    headers = {"Authorization": f"Bearer {auth_token}", "x-correlation-id": correlation_id}

    payload = {
        "load": {
            "route": {
                "pickup": {"country": "US", "state": "CA", "city": "Beverly Hills", "postal_code": "90210"},
                "drop": {"country": "US", "state": "NY", "city": "New York", "postal_code": "10001"},
            },
            "customer": {"name": "Acme Corp", "subname": "West Coast"},
            "truck_type": "Reefer",
            "ship_date": "2026-05-01",
        }
    }

    # Mocking external services
    mock_nominatim_resp = [{"lat": "34.0901", "lon": "-118.4065"}]
    mock_valhalla_resp = {"trip": {"summary": {"length": 4500.5, "time": 162000}}}
    mock_fuel_config_resp = {
        "uuid": str(uuid.uuid4()),
        "version": 1,
        "fuel_cost_per_km": "0.50",
        "truck_type": "Reefer",
    }
    mock_tariff_config_resp = {"uuid": str(uuid.uuid4()), "version": 1, "tariff_factor": "0.50"}

    orig_get = httpx.AsyncClient.get
    orig_post = httpx.AsyncClient.post

    async def mock_get_async(self, url, **kwargs):
        if "nominatim" in str(url) or "localhost" in str(url):
            return httpx.Response(200, json=mock_nominatim_resp, request=httpx.Request("GET", url))
        return await orig_get(self, url, **kwargs)

    async def mock_post_async(self, url, **kwargs):
        u = str(url)
        if "stadiamaps" in u:
            return httpx.Response(200, json=mock_valhalla_resp, request=httpx.Request("POST", url))
        if "fuel-cost-configs" in u:
            return httpx.Response(200, json=mock_fuel_config_resp, request=httpx.Request("POST", url))
        if "driver-tariff-configs" in u:
            return httpx.Response(200, json=mock_tariff_config_resp, request=httpx.Request("POST", url))
        return await orig_post(self, url, **kwargs)

    with patch("httpx.AsyncClient.get", new=mock_get_async), patch("httpx.AsyncClient.post", new=mock_post_async):
        response = await client.post("/costing/estimate", json=payload, headers=headers)
        data = response.json()

        assert data["correlation_id"] == correlation_id
        # Check enriched load
        assert data["load"]["distance_km"] == 4501
        assert data["load"]["route"]["pickup"]["latitude"] == 34.0901
        assert data["load"]["route"]["drop"]["latitude"] == 34.0901  # Mocking gives same for both

        # 4501 * 0.5 = 2250.5 (Base)
        # 2250.5 * 0.5 = 1125.25 (Tariff)
        # Total = 3375.75
        assert Decimal(str(data["all_in_cost"])) == Decimal("3375.75")
        assert len(data["adjustments"]) == 2

    # Verify audit persistence
    from sqlmodel import select
    from sqlmodel.ext.asyncio.session import AsyncSession
    from src.modules.costing.models import CostingAudit
    from src.tools.db import engine

    async with AsyncSession(engine) as session:
        statement = select(CostingAudit).where(CostingAudit.correlation_id == uuid.UUID(correlation_id))
        results = await session.exec(statement)
        audits = results.all()

        assert len(audits) > 0
        step_names = [a.step_name for a in audits]
        assert "distance_km" in step_names
        assert "all_in_cost" in step_names
        assert str(audits[0].correlation_id) == correlation_id
