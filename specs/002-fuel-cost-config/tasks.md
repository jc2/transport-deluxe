# Implementation Tasks: Fuel Cost Configuration Service

**Feature**: 002-fuel-cost-config

## Phase 1: Setup

- [x] T001 Create `FuelCostConfig` database model with table mapping in `fuel_cost_config/src/modules/fuel_cost_config/models.py`
- [x] T002 Generate initial Alembic migration for `fuel_cost_config` table and indexes in `fuel_cost_config/src/migrations/versions/001_initial.py`
- [x] T003 Configure database session dependency using `asyncpg` within `fuel_cost_config/src/tools/db.py`
- [x] T004 Set up Casdoor JWT authentication dependency in `fuel_cost_config/src/tools/auth.py`

## Phase 2: Foundational

- [x] T005 Define Pydantic schemas for API requests and responses (`FuelCostConfigResponse`, `PaginatedResponse`) in `fuel_cost_config/src/modules/fuel_cost_config/models.py`
- [x] T006 Implement core database access service structure in `fuel_cost_config/src/modules/fuel_cost_config/service.py`
- [x] T007 Initialize FastAPI router for the module in `fuel_cost_config/src/modules/fuel_cost_config/router.py`

## Phase 3: [US5] Resolve Fuel Cost Configuration for a Load

> **Goal**: Implement the unauthenticated resolution endpoint that applies the specificity hierarchy to find the active fuel cost.
> **Independent Test**: Call the endpoint without auth, provide a Load (Customer, Subcustomer, Truck Type), and verify it returns the most specific match.

- [x] T008 [US5] Implement resolution SQL query and service logic using `CASE`-based priority ordering in `fuel_cost_config/src/modules/fuel_cost_config/service.py`
- [x] T009 [US5] Create `POST /fuel-cost-configs/resolve` unauthenticated endpoint in `fuel_cost_config/src/modules/fuel_cost_config/router.py`
- [x] T010 [P] [US5] Write integration tests for resolution logic hierarchy in `fuel_cost_config/tests/test_resolve.py`, explicitly verifying the highest-version tie-breaker condition.

## Phase 4: [US1] View Active Fuel Cost Configurations

> **Goal**: Implement the paginated and filterable list endpoint and the get-by-UUID endpoint.
> **Independent Test**: Authenticate as a Cost Configurator, request the list filtered by Truck Type, and verify correct pagination and filtering.

- [x] T011 [US1] Implement service logic for listing active configurations with pagination and filtering in `fuel_cost_config/src/modules/fuel_cost_config/service.py`
- [x] T012 [US1] Create `GET /fuel-cost-configs` authenticated endpoint in `fuel_cost_config/src/modules/fuel_cost_config/router.py`
- [x] T013 [P] [US1] Implement service logic to get a configuration by UUID (latest active) in `fuel_cost_config/src/modules/fuel_cost_config/service.py`
- [x] T014 [P] [US1] Create `GET /fuel-cost-configs/{uuid}` authenticated endpoint in `fuel_cost_config/src/modules/fuel_cost_config/router.py`
- [x] T015 [P] [US1] Write integration tests for listing and filtering in `fuel_cost_config/tests/test_list.py`
- [x] T016 [P] [US1] Write integration tests for get-by-UUID in `fuel_cost_config/tests/test_get.py`

## Phase 5: [US2] Create a New Fuel Cost Configuration

> **Goal**: Implement the creation of new fuel cost configurations enforcing unique active combination rules.
> **Independent Test**: Create a System-level configuration and verify it becomes the baseline.

- [x] T017 [US2] Implement creation service logic with `uuid` generation, monotonicity, and unique constraint handling in `fuel_cost_config/src/modules/fuel_cost_config/service.py`
- [x] T018 [US2] Create `POST /fuel-cost-configs` authenticated endpoint extracting user identity from JWT in `fuel_cost_config/src/modules/fuel_cost_config/router.py`
- [x] T019 [P] [US2] Write integration tests for configuration creation and unique constraint in `fuel_cost_config/tests/test_create.py`

## Phase 6: [US3] Edit a Fuel Cost Configuration

> **Goal**: Implement the update endpoint that creates a new version and deactivates the previous active one automatically.
> **Independent Test**: Edit a configuration and verify a new version record is created while the older one is marked inactive.

- [x] T020 [US3] Implement update service logic executing atomic transaction to deactivate old and insert new version in `fuel_cost_config/src/modules/fuel_cost_config/service.py`
- [x] T021 [US3] Create `PUT /fuel-cost-configs/{uuid}` authenticated endpoint in `fuel_cost_config/src/modules/fuel_cost_config/router.py`
- [x] T022 [P] [US3] Write integration tests for the update atomic operation in `fuel_cost_config/tests/test_update.py`

## Phase 7: [US4] Deactivate a Fuel Cost Configuration

> **Goal**: Implement the soft delete functionality with system baseline protection.
> **Independent Test**: Deactivate a configuration and assert it disappears from the active list but remains in the database.

- [x] T023 [US4] Implement deactivation service logic with baseline protection check in atomic transaction in `fuel_cost_config/src/modules/fuel_cost_config/service.py`
- [x] T024 [US4] Create `DELETE /fuel-cost-configs/{uuid}` authenticated endpoint in `fuel_cost_config/src/modules/fuel_cost_config/router.py`
- [x] T025 [P] [US4] Write integration tests for deactivation and baseline protection in `fuel_cost_config/tests/test_deactivate.py`

## Phase 8: [US-UI-1] Configure SQLAdmin Interface

> **Goal**: Add a web UI using SQLAdmin to list, create, and manage `FuelCostConfig` records safely.
> **Independent Test**: Access `/admin`, verify Auth redirects correctly, and confirm the model view supports filtering and lists records.

- [X] T026 [US-UI-1] Create `AuthenticationBackend` for SQLAdmin using existing Casdoor integration in `fuel_cost_config/src/tools/admin_auth.py`
- [X] T027 [US-UI-1] Create `ModelView` for `FuelCostConfig` defining visible columns, search fields, and filtering in `fuel_cost_config/src/modules/fuel_cost_config/admin.py`
- [X] T028 [US-UI-1] Mount and configure SQLAdmin app instances dynamically in FastAPI `fuel_cost_config/src/main.py` entrypoint.

## Phase 9: Polish & Cross-Cutting Concerns

- [X] T029 Configure Docker Compose overrides to include SQLAdmin environment variables if needed in `docker-compose.yml`
- [X] T030 Refine exception handling and validation errors across endpoints to ensure strict compliance with the API contract.
- [X] T031 Verify access denial for incorrect roles (e.g. Cost Configurator attempting to access Margin APIs) through explicit test or manual validation logic in dependency wrappers.

---
## Summary

- **Total Tasks**: 31
- **Tasks per User Story**:
  - Setup & Foundational: 7
  - US5 (Resolve): 3
  - US1 (View): 6
  - US2 (Create): 3
  - US3 (Edit): 3
  - US4 (Deactivate): 3
  - US-UI-1 (SQLAdmin): 3
  - Polish: 3
- **Parallel Opportunities**: Tests and endpoints within a User Story can generally be split out. US5 and US1 read endpoints can be started simultaneously after Foundational logic.
- **Suggested MVP Scope**: Phase 1 through Phase 5, Phase 8 (US-UI-1 allows for quick visual verification of data insertion).
