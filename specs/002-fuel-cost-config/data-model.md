# Data Model: Fuel Cost Configuration Service

**Feature**: 002-fuel-cost-config
**Date**: 2026-04-23

---

## Database

**Database name**: `fuel_cost_config` (production) / `fuel_cost_config_tests` (integration tests)
**Engine**: PostgreSQL 16 (async via asyncpg + SQLModel)

---

## Table: `fuel_cost_config`

### Schema

| Column | Type | Nullable | Default | Description |
|--------|------|----------|---------|-------------|
| `uuid` | `UUID` | NOT NULL | — | Logical identifier, shared across all versions of the same configuration |
| `version` | `INTEGER` | NOT NULL | — | Monotonically increasing version number per logical configuration |
| `customer_name` | `VARCHAR(255)` | NULL | `NULL` | Customer name; NULL means system-level |
| `customer_subname` | `VARCHAR(255)` | NULL | `NULL` | Subcustomer name; NULL means not scoped to a subcustomer |
| `truck_type` | `VARCHAR(50)` | NOT NULL | — | Enum: `flatbed`, `reefer`, `dryvan` |
| `fuel_cost_per_km` | `NUMERIC(10, 4)` | NOT NULL | — | USD per KM, positive value |
| `is_active` | `BOOLEAN` | NOT NULL | `TRUE` | Whether this is the current live version |
| `created_by` | `VARCHAR(255)` | NOT NULL | — | JWT `name` claim of the authenticated user at write time |
| `created_at` | `TIMESTAMPTZ` | NOT NULL | `NOW()` | UTC timestamp of record creation |

### Primary Key

```
PRIMARY KEY (uuid, version)
```

Both columns together form the unique composite key per version record. `uuid` alone identifies the logical configuration across all its versions.

### Indexes

```sql
-- Enforce at most one active version per logical combination (partial unique index)
CREATE UNIQUE INDEX uq_fcc_active_combination
ON fuel_cost_config (COALESCE(customer_name, ''), COALESCE(customer_subname, ''), truck_type)
WHERE is_active = TRUE;

-- Fast resolution query: lookup by combination + active flag
CREATE INDEX idx_fcc_lookup
ON fuel_cost_config (customer_name, customer_subname, truck_type, is_active);

-- Fast get-by-uuid: retrieve latest active version
CREATE INDEX idx_fcc_uuid_active
ON fuel_cost_config (uuid, is_active);

-- Default list sort order
CREATE INDEX idx_fcc_created_at_desc
ON fuel_cost_config (created_at DESC);
```

---

## Specificity Levels (conceptual, never stored)

The terms **System**, **Customer**, and **Subcustomer** are used in documentation to describe the resolution hierarchy. They are derived from the `customer` and `subcustomer` DB columns (exposed as `customer.name` / `customer.subname` in the API) and are never stored as an explicit field:

- `customer_name IS NULL AND customer_subname IS NULL` → System-level rule (broadest)
- `customer_name IS NOT NULL AND customer_subname IS NULL` → Customer-level rule
- `customer_name IS NOT NULL AND customer_subname IS NOT NULL` → Subcustomer-level rule (most specific)

**API ↔ DB mapping**:

| API field | DB column |
|-----------|----------|
| `customer.name` | `customer_name` |
| `customer.subname` | `customer_subname` |

---

## Example Data

| uuid | version | customer_name | customer_subname | truck_type | fuel_cost_per_km | is_active | created_by | created_at |
|------|---------|----------|-------------|------------|------------------|-----------|------------|------------|
| `a1b2...` | 1 | NULL | NULL | dryvan | 0.5000 | true | alice | 2026-04-01T10:00Z |
| `a1b2...` | 2 | NULL | NULL | dryvan | 0.5500 | false | alice | 2026-03-01T10:00Z |
| `c3d4...` | 1 | NULL | NULL | reefer | 0.6500 | true | alice | 2026-04-01T10:00Z |
| `e5f6...` | 1 | GlobalLogistics | NULL | reefer | 0.6000 | true | bob | 2026-04-10T09:00Z |
| `g7h8...` | 1 | GlobalLogistics | Texas_Branch | reefer | 0.5800 | true | bob | 2026-04-15T14:00Z |

> Note: `a1b2...` version 1 is `is_active=true` (latest), version 2 is `is_active=false` (historical). The version number is assigned sequentially per `uuid` — version 1 was created first, so after an update the new record gets version 2 and becomes active while version 1 becomes inactive.

---

## Business Rules Enforced at DB Level

1. **At most one active version per combination**: enforced by `uq_fcc_active_combination` partial unique index. Application catches `UniqueViolation` and returns HTTP 409.
2. **No physical deletes**: no `DELETE` statements are ever issued. Only `UPDATE ... SET is_active = FALSE`.
3. **Version monotonicity**: new version = `MAX(version) WHERE uuid = :uuid` + 1, computed inside the atomic transaction.
4. **System baseline protection**: enforced at application level inside the deactivation transaction (guard check before soft delete).

---

## Alembic Migration Strategy

- One migration file per schema change.
- Initial migration: creates `fuel_cost_config` table + all indexes.
- Migrations live in `fuel_cost_config/src/migrations/`.
- Run via `alembic upgrade head` on service startup (in `lifespan` hook).
