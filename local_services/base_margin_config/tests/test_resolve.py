import pytest


@pytest.mark.asyncio
async def test_resolve_hierarchy(client, auth_token, clean_table):
    headers = {"Authorization": f"Bearer {auth_token}"}

    # Lowest specificity: Single Point Country (Weight: 100_000 + 1)
    await client.post(
        "/base-margin-configs",
        json={"pickup": {"country": "US", "state": "", "city": "", "postal_code": ""}, "margin_percent": 0.10},
        headers=headers,
    )

    # Higher specificity: Cross-Customer Route State (Weight: 1_000_000 + 10 + 10)
    await client.post(
        "/base-margin-configs",
        json={
            "pickup": {"country": "US", "state": "TX", "city": "", "postal_code": ""},
            "drop": {"country": "US", "state": "CA", "city": "", "postal_code": ""},
            "margin_percent": 0.15,
        },
        headers=headers,
    )

    # Higher specificity: Customer + Single Point (Weight: 100_000_000 + 20)
    await client.post(
        "/base-margin-configs",
        json={
            "customer": {"name": "Acme"},
            "pickup": {"country": "US", "state": "TX", "city": "", "postal_code": ""},
            "margin_percent": 0.20,
        },
        headers=headers,
    )

    # Highest specificity: Customer Subname + Route (Weight: 110_000_000 + ...)
    await client.post(
        "/base-margin-configs",
        json={
            "customer": {"name": "Acme", "subname": "Sub1"},
            "pickup": {"country": "US", "state": "TX", "city": "", "postal_code": ""},
            "drop": {"country": "US", "state": "CA", "city": "", "postal_code": ""},
            "margin_percent": 0.25,
        },
        headers=headers,
    )

    # 1. Broad match should hit 0.10
    resp = await client.post(
        "/base-margin-configs/resolve",
        json={"pickup": {"country": "US", "state": "NY", "city": "", "postal_code": ""}},
        headers=headers,
    )
    assert resp.status_code == 200
    assert resp.json()["margin_percent"] == 0.10

    # Also test unauthenticated route access
    resp_unauth = await client.post(
        "/base-margin-configs/resolve",
        json={"pickup": {"country": "US", "state": "NY", "city": "", "postal_code": ""}},
    )
    assert resp_unauth.status_code == 200
    assert resp_unauth.json()["margin_percent"] == 0.10

    # 2. Route should hit 0.15
    resp2 = await client.post(
        "/base-margin-configs/resolve",
        json={
            "pickup": {"country": "US", "state": "TX", "city": "", "postal_code": ""},
            "drop": {"country": "US", "state": "CA", "city": "", "postal_code": ""},
        },
        headers=headers,
    )
    assert resp2.status_code == 200
    assert resp2.json()["margin_percent"] == 0.15

    # 3. Customer + TX should hit 0.20
    resp3 = await client.post(
        "/base-margin-configs/resolve",
        json={
            "customer": {"name": "Acme"},
            "pickup": {"country": "US", "state": "TX", "city": "", "postal_code": ""},
            "drop": {"country": "US", "state": "NY", "city": "", "postal_code": ""},
        },
        headers=headers,
    )
    assert resp3.status_code == 200
    assert resp3.json()["margin_percent"] == 0.20

    # 4. Customer Subname + Full Route should hit 0.25
    resp4 = await client.post(
        "/base-margin-configs/resolve",
        json={
            "customer": {"name": "Acme", "subname": "Sub1"},
            "pickup": {"country": "US", "state": "TX", "city": "", "postal_code": ""},
            "drop": {"country": "US", "state": "CA", "city": "", "postal_code": ""},
        },
        headers=headers,
    )
    assert resp4.status_code == 200
    assert resp4.json()["margin_percent"] == 0.25
