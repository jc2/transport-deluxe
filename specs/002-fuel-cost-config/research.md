# Research: Fuel Cost Configuration Service

**Feature**: 002-fuel-cost-config
**Date**: 2026-04-23

---

## Decision 1: fastcrud library

**Question**: Can `fastcrud` simplify the implementation and justify a constitution exception?

**Decision**: Rejected. Use manual SQLModel + asyncpg.

**Rationale**:
- fastcrud targets SQLAlchemy ORM, not SQLModel. Mixing both adds friction.
- Only 2 of the 6 endpoints (list, get) would benefit from fastcrud's helpers.
- The 4 remaining endpoints require fully custom logic:
  - **Update** creates a new version record and deactivates the previous one in a single atomic transaction — no CRUD library models this pattern.
  - **Deactivate** requires a guard check (last System baseline) + soft delete, also atomic.
  - **Resolve** implements a 3-level specificity hierarchy; pure business logic with no CRUD analog.
- fastcrud's pagination helper (~15 lines of benefit) is trivially reproducible with SQLModel directly.
- Constitution remains unmodified.

**Alternatives considered**: crud_router (auto-generates endpoints), fastcrud direct methods. Both evaluated and rejected for the same reason above.

---

## Decision 2: Apache Hamilton

**Question**: Should Hamilton be used for business logic orchestration as required by Principle II?

**Decision**: Not applicable to this service. Constitution violation justified and documented.

**Rationale**:
- Hamilton is a DAG-based pipeline framework designed for data transformation workflows where steps have explicit input/output dependencies that form a directed acyclic graph.
- This service has no pipeline. Each endpoint is a direct, linear database operation:
  1. Validate input → 2. Query/mutate DB → 3. Return response.
- No step produces outputs consumed by other steps within the same request. There is no DAG.
- Forcing Hamilton here would add a framework layer with zero operational benefit and significant boilerplate overhead.
- The simpler alternative (async functions in `service.py`) is equally readable, testable, and maintainable for this use case.

**Simpler alternative adopted**: `service.py` contains plain `async def` functions (one per use case). `router.py` delegates to `service.py` directly. No `steps.py` file. Constitution violation documented in `plan.md` Complexity Tracking.

---

## Decision 3: Version History exposure

**Question**: FR-010 requires a version history view per configuration. FR-015 fixes the endpoint count at exactly 6. How do we reconcile?

**Decision**: Version history is served via the list endpoint (`GET /fuel-cost-configs`) with two optional query parameters: `uuid=<uuid>` and `include_inactive=true`.

**Rationale**:
- No 7th endpoint needed.
- The list endpoint already has pagination, so history pages naturally.
- When `uuid` + `include_inactive=true` are combined, the endpoint acts as a history view sorted by `version ASC`.
- This pattern is a standard REST convention (filter + include_deleted).

---

## Decision 4: Active uniqueness enforcement

**Question**: How do we guarantee at most one active version per (customer_name, customer_subname, truck_type)?

**Decision**: PostgreSQL partial unique index.

```sql
CREATE UNIQUE INDEX uq_fcc_active_combination
ON fuel_cost_config (COALESCE(customer_name, ''), COALESCE(customer_subname, ''), truck_type)
WHERE is_active = TRUE;
```

**Rationale**:
- DB-level enforcement is race-condition safe — no application-level check can be.
- Works correctly for NULL values via `COALESCE` to empty string.
- The application still returns a 409 Conflict to the user by catching the `UniqueViolation` exception from asyncpg.

---

## Decision 5: Resolution query strategy

**Question**: How to efficiently resolve the best-match config from the 3-level hierarchy in a single DB round trip?

**Decision**: Single query with `CASE`-based priority ordering.

```sql
SELECT * FROM fuel_cost_config
WHERE is_active = TRUE
  AND truck_type = :truck_type
  AND (
      (customer_name = :customer_name AND customer_subname = :customer_subname)
      OR (customer_name = :customer_name AND customer_subname IS NULL)
      OR (customer_name IS NULL AND customer_subname IS NULL)
  )
ORDER BY
    CASE
        WHEN customer_name = :customer_name AND customer_subname = :customer_subname THEN 1
        WHEN customer_name = :customer_name AND customer_subname IS NULL THEN 2
        ELSE 3
    END,
    version DESC
LIMIT 1;
```

**Rationale**:
- Single round trip to the DB for all three hierarchy levels.
- `LIMIT 1` with priority ordering returns the most specific match.
- `version DESC` tiebreak handles the data anomaly case (FR-014).
- The covering index on `(customer_name, customer_subname, truck_type, is_active)` makes this fast.

---

## Decision 6: JWT authentication strategy

**Question**: How do management endpoints verify the Cost Configurator role?

**Decision**: Verify Casdoor-issued JWT via JWKS; check `roles` claim. Extract `name` claim from decoded JWT for audit.

**Rationale**:
- Casdoor JWKS at `http://casdoor:8000/.well-known/jwks` (internal Docker network).
- JWT `roles` array claim contains `cost-configurator` for authorised users (established in feature 001).
- JWT `name` claim propagated to `created_by` audit field on all write operations — no separate header needed (Principle IX).
- The resolve endpoint skips all JWT verification — no auth dependency.
- Library: `python-jose[cryptography]` for RS256 JWT verification.
