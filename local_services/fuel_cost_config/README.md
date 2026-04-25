# Fuel Cost Configuration Service

Standalone FastAPI service that manages versioned fuel cost configurations used by the price estimation engine. Exposes 6 endpoints: 5 authenticated management endpoints and 1 unauthenticated resolution endpoint.

**Port**: 8001

---

## Role in the Business

This service is responsible for the **first phase of cost calculation** (`all_in_cost`). When the estimation engine needs to compute the cost of a shipment, it calls `/fuel-cost-configs/resolve` to obtain the `fuel_cost_per_km` applicable to that specific load. The returned value is multiplied by the route distance to produce the **Base Cost Adjustment**.

```
all_in_cost = Base Cost Adjustment + Driver Tariff Adjustment + Customer Cost Adjustment
              ^^^^^^^^^^^^^^^^^^^^^^^^
              distance_km × fuel_cost_per_km   ← resolved by this service
```

> See [`business/interactions/cost_estimation.md`](../business/interactions/cost_estimation.md) for the full flow.

---

## Business Entities

| Entity | Role in this service |
|--------|----------------------|
| **[Fuel Cost Configuration](../business/configurations/fuel_cost_configuration.md)** | Core entity. Each record stores the `fuel_cost_per_km` for a Customer + Truck Type combination. |
| **[Customer](../business/entities/customer.md)** | Identifies the customer the configuration applies to. Has two levels: `name` (global) and `subname` (branch/region). Both are optional — if empty, the configuration has System scope. |
| **[Truck Type](../business/entities/truck_type.md)** | Vehicle type: `flatbed`, `reefer`, or `dryvan`. Each type has its own fuel cost. |
| **[User](../business/entities/user.md)** | The `created_by` field is extracted from the `name` claim in the JWT — mandatory audit trail per the [Configuration Policy](../business/resources/configuration_policy.md). |

---

## Specificity Hierarchy

Configurations are matched from most specific to most general. The system always returns the most specific one available:

1. **Subcustomer** — `customer_name + customer_subname + truck_type`
2. **Customer** — `customer_name + truck_type`
3. **System** — `truck_type` only (must always exist as a mandatory fallback)

> If no active System-level configuration exists for a given `truck_type`, the service rejects the deactivation request (400 guard) to ensure the engine can always resolve.

---

## Configuration Policy

All configurations follow the [`Configuration Management Policy`](../business/resources/configuration_policy.md):

- **Immutability**: records are never physically deleted.
- **Soft delete**: the record is marked `is_active = false`.
- **Versioning**: every edit creates a new version (same UUID, `version + 1`). The previous version becomes inactive.
- **Access control**: only the `cost-configurator` role can create, update, or deactivate configurations.

---

## Module Table

| Module | File | Responsibility |
|--------|------|----------------|
| Router | `src/modules/fuel_cost_config/router.py` | Endpoint declarations, parameter validation, delegates to service |
| Models | `src/modules/fuel_cost_config/models.py` | SQLModel DB table, Pydantic request/response models, TruckType enum |
| Service | `src/modules/fuel_cost_config/service.py` | Business logic: list, get, create, update, deactivate, resolve |
| DB | `src/tools/db.py` | Async engine, `get_session` dependency |
| Auth | `src/tools/auth.py` | RS256 JWT verification via Casdoor JWKS, role check |

## Admin UI

You can view and manage Fuel Cost Configurations via the SQLAdmin UI.

1. Ensure the services are running: `docker compose --profile test up`
2. Open your browser to: [http://localhost:8001/admin](http://localhost:8001/admin)
3. Log in using a Casdoor user with the `cost-configurator` role.
   - **Username**: `test-cost-configurator`
   - **Password**: `test123`
