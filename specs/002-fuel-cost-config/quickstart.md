# Quickstart: Fuel Cost Configuration Service

**Feature**: 002-fuel-cost-config
**Date**: 2026-04-23

---

## Prerequisites

- Docker + Docker Compose
- Casdoor running (`docker compose up casdoor casdoor-db`)
- A valid Cost Configurator JWT (use `python scripts/get_token.py cost-configurator`)

---

## Start the service

```bash
docker compose up fuel-cost-config fuel-cost-config-db
```

Service available at `http://localhost:8001`.

---

## Run integration tests

```bash
docker compose --profile test up --abort-on-container-exit fuel-cost-config-tests
```

Tests run against `fuel_cost_config_tests` database. All data is cleaned up after each test.

---

## Example: Create a System-level configuration

```bash
TOKEN=$(python scripts/get_token.py cost-configurator)

curl -X POST http://localhost:8001/fuel-cost-configs \
  -H "Authorization: Bearer $TOKEN" \
  -H "x-user: alice" \
  -H "Content-Type: application/json" \
  -d '{
    "customer": null,
    "truck_type": "reefer",
    "fuel_cost_per_km": "0.65"
  }'
```

## Example: List with filter

```bash
curl -H "Authorization: Bearer $TOKEN" \
  "http://localhost:8001/fuel-cost-configs?truck_type=reefer&customer_name=GlobalLogistics"
```

## Example: Update (new version)

```bash
# Use the UUID returned from create
curl -X PUT http://localhost:8001/fuel-cost-configs/<uuid> \
  -H "Authorization: Bearer $TOKEN" \
  -H "x-user: alice" \
  -H "Content-Type: application/json" \
  -d '{"fuel_cost_per_km": "0.70"}'
```

## Example: View version history

```bash
curl -H "Authorization: Bearer $TOKEN" \
  "http://localhost:8001/fuel-cost-configs?uuid=<uuid>&include_inactive=true"
```

## Example: Resolve for a Load (no auth)

```bash
curl -X POST http://localhost:8001/fuel-cost-configs/resolve \
  -H "Content-Type: application/json" \
  -d '{
    "customer": {
      "name": "GlobalLogistics",
      "subname": "Texas_Branch"
    },
    "truck_type": "reefer"
  }'
```

## Example: Deactivate

```bash
curl -X DELETE http://localhost:8001/fuel-cost-configs/<uuid> \
  -H "Authorization: Bearer $TOKEN"
```
