import uuid
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
        },
        "all_in_cost": "1000.00",
    }

    mock_base_margin_resp = {
        "id": str(uuid.uuid4()),
        "version": 1,
        "margin_percent": 0.15,
    }

    mock_lead_time_resp = {
        "id": str(uuid.uuid4()),
        "version": 1,
        "configuration_factor": 1.2,
    }

    orig_post = httpx.AsyncClient.post

    async def mock_post_async(self, url, **kwargs):
        u = str(url)
        if "base-margin-configs" in u:
            return httpx.Response(200, json=mock_base_margin_resp, request=httpx.Request("POST", url))
        if "lead-time-configs" in u:
            return httpx.Response(200, json=mock_lead_time_resp, request=httpx.Request("POST", url))
        return await orig_post(self, url, **kwargs)

    with patch("httpx.AsyncClient.post", new=mock_post_async):
        response = await client.post("/margin/estimate", json=payload, headers=headers)

        assert response.status_code == 200
        data = response.json()

        assert data["correlation_id"] == correlation_id

        initial_margin = (1000.0 * 0.15) / (1 - 0.15)

        assert "all_in_margin" in data
        assert abs(float(data["all_in_margin"]) - (initial_margin + initial_margin * 1.2)) < 0.01
        assert len(data["adjustments"]) == 2

    # Verify audit persistence
    from sqlmodel import select
    from sqlmodel.ext.asyncio.session import AsyncSession
    from src.modules.margin.models import MarginAudit
    from src.tools.db import engine

    async with AsyncSession(engine) as session:
        statement = select(MarginAudit).where(MarginAudit.correlation_id == uuid.UUID(correlation_id))
        results = await session.exec(statement)
        audits = results.all()

        assert len(audits) > 0
        step_names = [a.step_name for a in audits]
        assert "base_margin_config" in step_names
        assert "initial_base_margin" in step_names
        assert "lead_time_adjustment" in step_names
        assert "all_in_margin" in step_names
