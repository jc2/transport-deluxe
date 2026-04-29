import uuid
from datetime import datetime, timezone

import pytest
from sqlmodel.ext.asyncio.session import AsyncSession
from src.modules.reports.models import CostingAudit, MarginAudit, PricingAudit


async def _seed_rows(test_db, correlation_id: uuid.UUID) -> None:
    async with AsyncSession(test_db, expire_on_commit=False) as session:
        session.add(
            CostingAudit(
                correlation_id=correlation_id,
                step_name="distance_km",
                step_type="enriching",
                input={"pickup": {}, "drop": {}},
                output=4501.0,
                timestamp=datetime.now(timezone.utc).replace(tzinfo=None),
            )
        )
        session.add(
            CostingAudit(
                correlation_id=correlation_id,
                step_name="all_in_cost",
                step_type="equation",
                input={"distance_km": 4501.0},
                output=3375.75,
                timestamp=datetime.now(timezone.utc).replace(tzinfo=None),
            )
        )
        session.add(
            MarginAudit(
                correlation_id=correlation_id,
                step_name="initial_base_margin",
                step_type="equation",
                input={"all_in_cost": 3375.75},
                output=750.0,
                timestamp=datetime.now(timezone.utc).replace(tzinfo=None),
            )
        )
        session.add(
            PricingAudit(
                correlation_id=correlation_id,
                step_name="price",
                step_type="equation",
                input={"all_in_cost": 3375.75, "all_in_margin": 750.0},
                output=4125.75,
                timestamp=datetime.now(timezone.utc).replace(tzinfo=None),
            )
        )
        await session.commit()


@pytest.mark.asyncio
async def test_breakdown_happy_path(client, clean_tables, test_db):
    correlation_id = uuid.uuid4()
    await _seed_rows(test_db, correlation_id)

    response = await client.get(f"/reports/breakdown/{correlation_id}")
    assert response.status_code == 200

    data = response.json()
    assert data["correlation_id"] == str(correlation_id)
    assert len(data["rows"]) == 4

    engines = {row["engine"] for row in data["rows"]}
    assert engines == {"costing", "margin", "pricing"}

    assert all("id" not in row for row in data["rows"])


@pytest.mark.asyncio
async def test_breakdown_not_found(client, clean_tables):
    unknown_id = uuid.uuid4()
    response = await client.get(f"/reports/breakdown/{unknown_id}")
    assert response.status_code == 404

    data = response.json()
    assert data["status"] == 404
    assert len(data["messages"]) > 0


@pytest.mark.asyncio
async def test_breakdown_filter_single_engine(client, clean_tables, test_db):
    correlation_id = uuid.uuid4()
    await _seed_rows(test_db, correlation_id)

    response = await client.get(f"/reports/breakdown/{correlation_id}?engine=costing")
    assert response.status_code == 200

    data = response.json()
    assert all(row["engine"] == "costing" for row in data["rows"])
    assert len(data["rows"]) == 2


@pytest.mark.asyncio
async def test_breakdown_filter_multiple_engines(client, clean_tables, test_db):
    correlation_id = uuid.uuid4()
    await _seed_rows(test_db, correlation_id)

    response = await client.get(f"/reports/breakdown/{correlation_id}?engine=costing&engine=margin")
    assert response.status_code == 200

    data = response.json()
    engines = {row["engine"] for row in data["rows"]}
    assert engines == {"costing", "margin"}
    assert "pricing" not in engines


@pytest.mark.asyncio
async def test_breakdown_filter_step_type(client, clean_tables, test_db):
    correlation_id = uuid.uuid4()
    await _seed_rows(test_db, correlation_id)

    response = await client.get(f"/reports/breakdown/{correlation_id}?step_type=enriching")
    assert response.status_code == 200

    data = response.json()
    assert all(row["step_type"] == "enriching" for row in data["rows"])
    assert len(data["rows"]) == 1


@pytest.mark.asyncio
async def test_breakdown_filter_multiple_step_types(client, clean_tables, test_db):
    correlation_id = uuid.uuid4()
    await _seed_rows(test_db, correlation_id)

    response = await client.get(f"/reports/breakdown/{correlation_id}?step_type=enriching&step_type=equation")
    assert response.status_code == 200

    data = response.json()
    step_types = {row["step_type"] for row in data["rows"]}
    assert step_types == {"enriching", "equation"}
    assert len(data["rows"]) == 4


@pytest.mark.asyncio
async def test_breakdown_filter_engine_and_step_type_combined(client, clean_tables, test_db):
    correlation_id = uuid.uuid4()
    await _seed_rows(test_db, correlation_id)

    response = await client.get(f"/reports/breakdown/{correlation_id}?engine=costing&step_type=equation")
    assert response.status_code == 200

    data = response.json()
    assert all(row["engine"] == "costing" and row["step_type"] == "equation" for row in data["rows"])
    assert len(data["rows"]) == 1


@pytest.mark.asyncio
async def test_breakdown_invalid_engine_returns_400(client, clean_tables):
    correlation_id = uuid.uuid4()
    response = await client.get(f"/reports/breakdown/{correlation_id}?engine=unknown_engine")
    assert response.status_code == 400

    data = response.json()
    assert data["status"] == 400
    assert len(data["messages"]) > 0
