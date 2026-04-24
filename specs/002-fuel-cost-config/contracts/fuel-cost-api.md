# API Contract: Fuel Cost Configuration Service

**Feature**: 002-fuel-cost-config
**Date**: 2026-04-23
**Base URL**: `http://localhost:8001`
**Auth**: Bearer JWT (Casdoor RS256) on endpoints 1–5. User identity extracted from JWT `name` claim for audit on write endpoints (3, 4, 5). Endpoint 6 requires no auth.

---

## Shared Schemas

### `FuelCostConfigResponse`

```json
{
  "uuid": "a1b2c3d4-e5f6-7890-abcd-ef1234567890",
  "version": 2,
  "customer": {
    "name": "GlobalLogistics",
    "subname": "Texas_Branch"
  },
  "truck_type": "reefer",
  "fuel_cost_per_km": "0.5800",
  "is_active": true,
  "created_by": "alice",
  "created_at": "2026-04-23T10:00:00Z"
}
```

> `customer` is `null` for System-level configs. `customer.subname` is `null` for Customer-level configs. `truck_type` values: `flatbed`, `reefer`, `dryvan`. Specificity level (System / Customer / Subcustomer) is a conceptual term derived from the `customer` object — never an explicit field.

### `PaginatedResponse<FuelCostConfigResponse>`

```json
{
  "data": [ /* array of FuelCostConfigResponse */ ],
  "page": 1,
  "page_size": 20,
  "total": 45,
  "total_pages": 3
}
```

### Error Response (all endpoints)

```json
{
  "status": 400,
  "messages": ["No active fuel cost configuration found for the given load."]
}
```

---

## Endpoint 1 — List Configurations

**`GET /fuel-cost-configs`**
**Auth**: Cost Configurator Bearer token required.

### Query Parameters

| Parameter | Type | Required | Default | Description |
|-----------|------|----------|---------|-------------|
| `page` | integer ≥ 1 | No | `1` | Page number |
| `page_size` | integer 1–100 | No | `20` | Records per page |
| `customer_name` | string | No | — | Filter by customer name (exact match) |
| `customer_subname` | string | No | — | Filter by subcustomer name (exact match) |
| `truck_type` | `flatbed`\|`reefer`\|`dryvan` | No | — | Filter by truck type |
| `uuid` | UUID string | No | — | Filter to a specific logical configuration (use with `include_inactive` for history) |
| `include_inactive` | boolean | No | `false` | When `true`, includes all versions (not only active). Use with `uuid` for version history. |

**Default sort**: `created_at DESC` (newest first).
**Sort when `include_inactive=true` + `uuid` provided**: `version ASC` (history view).

### Response `200 OK`

```json
{
  "data": [
    {
      "uuid": "g7h8i9j0-...",
      "version": 1,
      "customer": {
        "name": "GlobalLogistics",
        "subname": "Texas_Branch"
      },
      "truck_type": "reefer",
      "fuel_cost_per_km": "0.5800",
      "is_active": true,
      "created_by": "alice",
      "created_at": "2026-04-23T14:00:00Z"
    }
  ],
  "page": 1,
  "page_size": 20,
  "total": 5,
  "total_pages": 1
}
```

### Error Responses

| Status | Condition |
|--------|-----------|
| `401` | Missing or invalid JWT |
| `403` | JWT valid but role is not `cost-configurator` |

---

## Endpoint 2 — Get Configuration by UUID

**`GET /fuel-cost-configs/{uuid}`**
**Auth**: Cost Configurator Bearer token required.

### Path Parameters

| Parameter | Type | Description |
|-----------|------|-------------|
| `uuid` | UUID | Logical configuration identifier |

### Response `200 OK`

Returns the latest active version as a single `FuelCostConfigResponse`.

### Error Responses

| Status | Condition |
|--------|-----------|
| `401` | Missing or invalid JWT |
| `403` | JWT valid but role is not `cost-configurator` |
| `404` | No active version exists for this UUID |

---

## Endpoint 3 — Create Configuration

**`POST /fuel-cost-configs`**
**Auth**: Cost Configurator Bearer token required. User identity taken from JWT `name` claim (→ `created_by`).

### Request Body

```json
{
  "customer": {
    "name": "GlobalLogistics",
    "subname": null
  },
  "truck_type": "reefer",
  "fuel_cost_per_km": "0.6000"
}
```

| Field | Type | Required | Notes |
|-------|------|----------|-------|
| `customer` | `{name, subname}` \| null | No | Omit or `null` for system-level |
| `customer.name` | string | Yes (if customer set) | Customer name |
| `customer.subname` | string \| null | No | Subcustomer name; `null` for customer-level |
| `truck_type` | `flatbed`\|`reefer`\|`dryvan` | Yes | |
| `fuel_cost_per_km` | decimal string | Yes | Must be > 0 |

### Response `201 Created`

Returns the created record as `FuelCostConfigResponse` (version=1, is_active=true).

### Error Responses

| Status | Condition |
|--------|-----------|
| `400` | Validation error (e.g., fuel_cost_per_km ≤ 0, invalid truck_type) |
| `401` | Missing or invalid JWT |
| `403` | JWT valid but role is not `cost-configurator` |
| `409` | An active configuration already exists for this customer + subcustomer + truck_type combination |

---

## Endpoint 4 — Update Configuration (New Version)

**`PUT /fuel-cost-configs/{uuid}`**
**Auth**: Cost Configurator Bearer token required. User identity taken from JWT `name` claim (→ `created_by` of the new version).

### Path Parameters

| Parameter | Type | Description |
|-----------|------|-------------|
| `uuid` | UUID | Logical configuration identifier |

### Request Body

```json
{
  "fuel_cost_per_km": "0.6200"
}
```

| Field | Type | Required | Notes |
|-------|------|----------|-------|
| `fuel_cost_per_km` | decimal string | Yes | Must be > 0 |

**Behaviour**: Creates a new version record (same UUID, version+1, is_active=true). Deactivates the previous active version (is_active=false). Both writes are atomic.

### Response `200 OK`

Returns the new version record as `FuelCostConfigResponse`.

### Error Responses

| Status | Condition |
|--------|-----------|
| `400` | Validation error |
| `401` | Missing or invalid JWT |
| `403` | JWT valid but role is not `cost-configurator` |
| `404` | No active version exists for this UUID |

---

## Endpoint 5 — Deactivate Configuration

**`DELETE /fuel-cost-configs/{uuid}`**
**Auth**: Cost Configurator Bearer token required.

### Path Parameters

| Parameter | Type | Description |
|-----------|------|-------------|
| `uuid` | UUID | Logical configuration identifier |

**Behaviour**: Soft delete — marks the active version as `is_active=false`. Guard check and deactivation are atomic. No record is ever physically deleted.

### Response `204 No Content`

No body.

### Error Responses

| Status | Condition |
|--------|-----------|
| `400` | Target is the last active System-level configuration for its truck type |
| `401` | Missing or invalid JWT |
| `403` | JWT valid but role is not `cost-configurator` |
| `404` | No active version exists for this UUID |

---

## Endpoint 6 — Resolve Configuration for a Load

**`POST /fuel-cost-configs/resolve`**
**Auth**: None required.

### Request Body

```json
{
  "customer": {
    "name": "GlobalLogistics",
    "subname": "Texas_Branch"
  },
  "truck_type": "reefer"
}
```

| Field | Type | Required | Notes |
|-------|------|----------|-------|
| `customer` | `{name, subname}` \| null | No | The load's customer; `null` for system-level fallback |
| `customer.name` | string | Yes (if customer set) | Customer name |
| `customer.subname` | string \| null | No | Subcustomer name |
| `truck_type` | `flatbed`\|`reefer`\|`dryvan` | Yes | |

**Resolution hierarchy** (most specific wins):
1. `customer.name + customer.subname + truck_type`
2. `customer.name + null subname + truck_type`
3. `null customer + truck_type`

Returns the latest active version of the best match (highest version if tie).

### Response `200 OK`

Returns a single `FuelCostConfigResponse`.

### Error Responses

| Status | Condition |
|--------|-----------|
| `400` | No active configuration found at any level for the given truck type |

---

## Auth Header Summary

| Endpoint | `Authorization` | `x-user` |
|----------|----------------|----------|
| GET /fuel-cost-configs | Required | — |
| GET /fuel-cost-configs/{uuid} | Required | — |
| POST /fuel-cost-configs | Required | Required |
| PUT /fuel-cost-configs/{uuid} | Required | Required |
| DELETE /fuel-cost-configs/{uuid} | Required | — |
| POST /fuel-cost-configs/resolve | **Not required** | — |
