import pytest


@pytest.mark.asyncio
async def test_resolve_hierarchy(client, auth_token, clean_table) -> None:
    headers = {"Authorization": f"Bearer {auth_token}"}

    # 1. Create a dest default (CA)
    await client.post(
        "/driver-tariff-configs",
        json={"pickup_state": None, "drop_state": "CA", "tariff_factor": "1.10"},
        headers=headers,
    )

    # 2. Create an origin default (TX)
    await client.post(
        "/driver-tariff-configs",
        json={"pickup_state": "TX", "drop_state": None, "tariff_factor": "1.20"},
        headers=headers,
    )

    # 3. Create a specific route (TX -> CA)
    await client.post(
        "/driver-tariff-configs",
        json={"pickup_state": "TX", "drop_state": "CA", "tariff_factor": "1.50"},
        headers=headers,
    )

    # Test Specific Route Win
    resp = await client.post(
        "/driver-tariff-configs/resolve",
        json={
            "load": {
                "route": {
                    "pickup": {"country": "USA", "state": "TX", "city": "Austin", "postal_code": "78701"},
                    "drop": {"country": "USA", "state": "CA", "city": "LA", "postal_code": "90001"},
                },
                "customer": {"name": "Acme", "subname": None},
                "truck_type": "Dryvan",
                "ship_date": "2024-05-01",
            }
        },
        headers=headers,
    )
    assert resp.status_code == 200
    assert str(resp.json()["tariff_factor"]) == "1.5000"

    # Test Origin Default Win (TX -> AZ)
    resp = await client.post(
        "/driver-tariff-configs/resolve",
        json={
            "load": {
                "route": {
                    "pickup": {"country": "USA", "state": "TX", "city": "Austin", "postal_code": "78701"},
                    "drop": {"country": "USA", "state": "AZ", "city": "Phoenix", "postal_code": "85001"},
                },
                "customer": {"name": "Acme", "subname": None},
                "truck_type": "Dryvan",
                "ship_date": "2024-05-01",
            }
        },
        headers=headers,
    )
    assert resp.status_code == 200
    assert str(resp.json()["tariff_factor"]) == "1.2000"

    # Test Dest Default Win (NY -> CA)
    resp = await client.post(
        "/driver-tariff-configs/resolve",
        json={
            "load": {
                "route": {
                    "pickup": {"country": "USA", "state": "NY", "city": "NY", "postal_code": "10001"},
                    "drop": {"country": "USA", "state": "CA", "city": "LA", "postal_code": "90001"},
                },
                "customer": {"name": "Acme", "subname": None},
                "truck_type": "Dryvan",
                "ship_date": "2024-05-01",
            }
        },
        headers=headers,
    )
    assert resp.status_code == 200
    assert str(resp.json()["tariff_factor"]) == "1.1000"

    # Test 404 No Match - before global wildcard
    # Actually wait. Let's create the global wildcard and see if it matches NY -> FL
    resp_create = await client.post(
        "/driver-tariff-configs",
        json={"pickup_state": None, "drop_state": None, "tariff_factor": "1.01"},
        headers=headers,
    )
    assert resp_create.status_code == 201

    resp = await client.post(
        "/driver-tariff-configs/resolve",
        json={
            "load": {
                "route": {
                    "pickup": {"country": "USA", "state": "NY", "city": "NY", "postal_code": "10001"},
                    "drop": {"country": "USA", "state": "FL", "city": "Miami", "postal_code": "33101"},
                },
                "customer": {"name": "Acme", "subname": None},
                "truck_type": "Dryvan",
                "ship_date": "2024-05-01",
            }
        },
        headers=headers,
    )
    assert resp.status_code == 200
    assert str(resp.json()["tariff_factor"]) == "1.0100"
