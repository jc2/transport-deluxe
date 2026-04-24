# Feature Specification: Fuel Cost Configuration Management

**Feature Branch**: `002-fuel-cost-config`
**Created**: 2026-04-23
**Status**: Draft
**Input**: User description: "implement the fuel service configuration"

## User Scenarios & Testing *(mandatory)*

### User Story 1 - View Active Fuel Cost Configurations (Priority: P1)

A Cost Configurator needs to see all currently active fuel cost configurations to understand the pricing rules in effect. They can browse a paginated, filterable list showing each record's unique identifier, Customer Name, Customer Subname, Truck Type, current fuel cost per KM, version number, and audit info. Filtering by any combination of fields allows the future UI to build targeted views without full data loads.

**Why this priority**: Without visibility into existing configurations, the configurator cannot make informed decisions when creating or updating rules. This is the read-only foundation for all other actions, and its filtering capability is essential for the planned management UI.

**Independent Test**: Can be tested by logging in as a Cost Configurator, requesting the list filtered by Truck Type=Reefer, and verifying only Reefer configurations are returned with correct pagination metadata.

**Acceptance Scenarios**:

1. **Given** I am authenticated as a Cost Configurator, **When** I request the configurations list with no filters, **Then** I receive a paginated response showing active configurations with: UUID, Customer Name (empty if System-level), Customer Subname (empty if not applicable), Truck Type, fuel cost per KM (USD), version number, Created By, and Created At.
2. **Given** there are multiple versions of a configuration for the same Customer Name + Customer Subname + Truck Type combination, **When** I view the list, **Then** only the latest active version is shown (one row per logical combination).
3. **Given** the total number of configurations exceeds a single page, **When** I navigate to the next page, **Then** the system returns the next set of records with correct pagination metadata (current page, page size, total count, total pages).
4. **Given** I filter the list by Customer Name=GlobalLogistics, **When** the response is returned, **Then** only configurations where Customer Name matches GlobalLogistics are included.
5. **Given** I filter the list by Truck Type=Reefer and Customer Name=GlobalLogistics, **When** the response is returned, **Then** only Reefer configurations where Customer Name matches GlobalLogistics are included.
6. **Given** I am authenticated as a Predictor (non-configurator), **When** I attempt to access the configurations list, **Then** I receive an access-denied response.

---

### User Story 2 - Create a New Fuel Cost Configuration (Priority: P2)

A Cost Configurator creates a new fuel cost rule by filling in four fields: Customer Name (optional), Customer Subname (optional — only meaningful when a Customer Name is set), Truck Type (required), and Fuel Cost per KM (required). The system automatically infers the scope from which fields are populated — no scope selection is required from the user.

**Why this priority**: Creating configurations is the primary write action. Without it, the configurator cannot introduce new pricing rules for new customers or truck types.

**Independent Test**: Can be tested by creating a configuration with no Customer Name and no Customer Subname and verifying that a price estimation for any customer picks up this System-level fuel cost as the baseline.

**Acceptance Scenarios**:

1. **Given** I am a Cost Configurator, **When** I submit a configuration leaving Customer Name and Customer Subname empty with Truck Type=Dryvan and Fuel Cost=0.50, **Then** the system saves it as active.
2. **Given** I am a Cost Configurator, **When** I submit a configuration with Customer Name=GlobalLogistics, Customer Subname empty, and Truck Type=Reefer, **Then** the system saves it as active.
3. **Given** I am a Cost Configurator, **When** I submit a configuration with Customer Name=GlobalLogistics, Customer Subname=Texas_Branch, and Truck Type=Reefer, **Then** the system saves it as active.
4. **Given** an active configuration already exists for Customer Name=GlobalLogistics, Customer Subname=Texas_Branch, Truck Type=Reefer, **When** I attempt to create another active record with the same three fields, **Then** the system rejects the request stating a duplicate active configuration exists.
5. **Given** I submit a configuration with an invalid fuel cost (e.g., negative or zero), **When** the form is submitted, **Then** the system displays a validation error and does not persist the record.
6. **Given** I am a Cost Configurator, **When** I save a new configuration, **Then** the record stores my user identity and the current timestamp as Created By and Created At.

---

### User Story 3 - Edit a Fuel Cost Configuration (Priority: P2)

A Cost Configurator updates the fuel cost value for an existing configuration. The system creates a new version, preserving the history of the old value, so the change is traceable.

**Why this priority**: Fuel costs change over time. The immutability model means edits are new versions — this is a core business rule that ensures audit compliance.

**Independent Test**: Can be tested by editing an existing System + Reefer configuration and verifying a new version record is created while the old version becomes inactive.

**Acceptance Scenarios**:

1. **Given** an active configuration for System + Reefer at 0.65 USD/KM, **When** I update the fuel cost to 0.70 USD/KM and save, **Then** a new version is created (now the active one at 0.70), and the previous version is retained but marked as inactive.
2. **Given** I edit a configuration, **When** the change is saved, **Then** the new version records my user identity and the current timestamp as Created By / Created At (the "edit" is effectively a new creation).
3. **Given** I view the version history of a configuration, **When** multiple edits have occurred, **Then** all past versions appear in chronological order with their respective fuel cost values and audit information.

---

### User Story 4 - Deactivate a Fuel Cost Configuration (Priority: P3)

A Cost Configurator deactivates a fuel cost configuration that is no longer needed (e.g., a customer-specific override that has expired). The record is retained for audit purposes but no longer used in price estimation.

**Why this priority**: Lower priority because the system still operates with the system fallback. Deactivation affects overrides; the System + Truck Type baseline must always remain active.

**Independent Test**: Can be tested by deactivating a Subcustomer-specific override and verifying that subsequent price estimations for that subcustomer fall back to the Customer or System configuration.

**Acceptance Scenarios**:

1. **Given** an active Subcustomer + Truck Type configuration, **When** I deactivate it, **Then** the record is marked inactive (not deleted) and disappears from the active configuration list.
2. **Given** a price estimation is requested after deactivating a Subcustomer override, **When** the system resolves the fuel cost, **Then** it falls back to the Customer + Truck Type configuration, or to System + Truck Type if none exists.
3. **Given** I attempt to deactivate the only active System + Truck Type configuration for a specific truck type, **When** the request is submitted, **Then** the system rejects it with an error stating the system baseline cannot be removed.
4. **Given** I deactivate a configuration, **When** I view the version history, **Then** the deactivated version is still visible with its full audit trail.

---

### User Story 5 - Resolve Fuel Cost Configuration for a Load (Priority: P1)

A consuming service (e.g., the price estimation engine) sends a Load object — containing Customer Name, Customer Subname, Truck Type, and Shipment Date — and receives back the single active fuel cost configuration that best matches it, following the specificity hierarchy. This endpoint is intentionally open: it requires no authentication, as it is called by internal services, not directly by end users. If no match can be found at any level, the service rejects the request.

**Why this priority**: This is the core consumption endpoint. Without it, price estimation cannot function. It is equally foundational as the management operations.

**Independent Test**: Can be tested by calling the resolution endpoint without any authentication token, providing a Load with a known Customer Name + Customer Subname + Truck Type, and verifying that the most specific active configuration is returned.

**Acceptance Scenarios**:

1. **Given** the resolution endpoint is called without any authentication token, **When** a valid Load is provided, **Then** the system processes the request normally (no auth required).
2. **Given** active configurations exist for System+Reefer, Customer Name=GlobalLogistics+Reefer, and Customer Subname=Texas_Branch+Reefer, **When** the resolution endpoint receives a Load with Customer Name=GlobalLogistics, Customer Subname=Texas_Branch, Truck Type=Reefer, **Then** it returns the Subcustomer-level configuration (most specific match).
3. **Given** there is no Subcustomer-level configuration for Texas_Branch+Reefer but a Customer-level one for GlobalLogistics+Reefer exists, **When** the resolution endpoint receives the same Load, **Then** it falls back and returns the Customer-level configuration.
4. **Given** no Customer-level or Subcustomer-level configuration exists, but a System-level configuration for Reefer exists, **When** the resolution endpoint receives the Load, **Then** it falls back and returns the System-level configuration.
5. **Given** no configuration exists at any level for the requested Truck Type, **When** the resolution endpoint receives the Load, **Then** it returns a 400 error indicating no matching configuration was found.
6. **Given** multiple versions exist for the matching combination, **When** the resolution endpoint resolves the match, **Then** it returns only the latest active version.

---

### User Story 6 - Manage Configurations via SQLAdmin Interface (US-UI-1) (Priority: P2)

A Cost Configurator needs an integrated administrative web interface to view, search, and manage Fuel Cost Configurations without relying on external API clients. The system must use SQLAdmin connected to the database to provide this interface and secure it via the standard Casdoor authentication to enforce role boundaries.

**Why this priority**: Required for immediate adoption and testing by non-technical operational users, acting as the primary management UI.

**Independent Test**: Access the `/admin` path without logging in and verify it redirects to Casdoor. Login as a Cost Configurator and verify the table listing displays the exact fields configured.

**Acceptance Scenarios**:

1. **Given** an unauthenticated request to `/admin`, **When** processed, **Then** it must redirect or deny access based on Casdoor verification.
2. **Given** a Cost Configurator opens the Admin view, **When** they view the FuelCostConfig model, **Then** they see `uuid`, `version`, `customer_name`, `customer_subname`, `truck_type`, `fuel_cost_per_km`, `is_active`, `created_by`, and `created_at`.
3. **Given** a Cost Configurator uses the Admin search, **When** searching by `customer_name` or `truck_type`, **Then** the list is filtered accordingly.

---


### Edge Cases

- What happens when neither a customer-specific nor a system-wide configuration exists for a given Truck Type? → The resolution endpoint returns a 400 error (system baseline is mandatory for operation).
- What happens when I try to create a configuration for a Customer Subname whose Customer Name has no configuration for that truck type? → Allowed; the hierarchy lookup will cascade correctly during resolution.
- What happens if a Cost Configurator tries to modify a Margin Configuration? → Access denied; roles are strictly exclusive.
- What happens with concurrent edits to the same configuration by two configurators? → Handled by atomic database transactions: the creation of the new version and the deactivation of the previous version execute as a single atomic operation, preventing duplicate version numbers or inconsistent active flags.

## Requirements *(mandatory)*

### Functional Requirements

- **FR-001**: System MUST provide a paginated list endpoint for active fuel cost configurations, accessible only to authenticated Cost Configurators, returning per record: UUID, Customer Name, Customer Subname, Truck Type, fuel cost per KM (USD), version number, Created By, and Created At. Pagination metadata (current page, page size, total count, total pages) MUST be included in the response. The endpoint MUST support optional filtering by any combination of: Customer Name, Customer Subname, and Truck Type. Default sort order MUST be Created At descending (newest first).
- **FR-002**: System MUST allow Cost Configurators to create a new fuel cost configuration by specifying: Customer Name (optional), Customer Subname (optional), Truck Type (required — Flatbed, Reefer, or Dryvan), and Fuel Cost per KM (required). The system infers scope from the populated fields; scope is never a direct user input.
- **FR-003**: System MUST reject creation of a new active configuration when an active record already exists for the same Customer Name + Customer Subname + Truck Type combination.
- **FR-004**: System MUST validate that the fuel cost per KM is a positive monetary value expressed in USD.
- **FR-005**: System MUST implement immutable versioning: editing a configuration creates a new version record and marks the previous version as inactive. Both operations MUST execute within a single atomic database transaction to prevent inconsistent state under concurrent writes.
- **FR-006**: System MUST support soft deactivation of configurations; physical deletion is never permitted. The guard check (FR-007) and the deactivation update MUST execute within a single atomic database transaction.
- **FR-007**: System MUST reject deactivation of a System-level configuration (Customer Name empty, Customer Subname empty) if it is the sole active system baseline for that truck type.
- **FR-008**: System MUST enforce authentication and role-based access on the five management endpoints (list, get by UUID, create, update, deactivate): only authenticated users with the Cost Configurator role may access them. The resolution endpoint (match by Load) MUST be publicly accessible without authentication.
- **FR-009**: System MUST store audit information on every configuration version: Created By (user identity) and Created At (timestamp).
- **FR-010**: System MUST expose a version history view per configuration, listing all versions in chronological order with their audit data and fuel cost values.
- **FR-011**: System MUST expose a resolution endpoint that accepts a Load object (Customer Name, Customer Subname, Truck Type) and returns the single best-matching active fuel cost configuration, applying the specificity hierarchy: (Customer Name + Customer Subname + Truck Type) → (Customer Name + empty Customer Subname + Truck Type) → (empty Customer Name + empty Customer Subname + Truck Type).
- **FR-012**: The resolution endpoint MUST return a 400 error when no active configuration exists at any level for the requested Truck Type.
- **FR-013**: A UUID is assigned when a logical configuration is first created and remains the same across all its subsequent versions. The composite key UUID + version number uniquely identifies each individual version record. The UUID alone is used to retrieve a configuration (get by UUID, version history).
- **FR-014**: When multiple active versions exist for the same Customer Name + Customer Subname + Truck Type combination (due to race conditions or data anomalies), the resolution endpoint MUST return the record with the highest version number.
- **FR-015**: The service MUST expose exactly six endpoints: (1) List configurations with pagination and filtering, (2) Get a single configuration by UUID (returns the latest active version; returns 404 if no active version exists under that UUID), (3) Create a new configuration, (4) Update an existing configuration by UUID (creates a new version under the same UUID), (5) Deactivate a configuration by UUID (soft delete), (6) Resolve best-match configuration for a given Load. Endpoints 1–5 require Cost Configurator authentication. Endpoint 6 requires no authentication.

- **FR-016**: The system MUST expose a web UI using SQLAdmin anchored at `/admin`, protected via Casdoor integration, allowing users with the Cost Configurator role to run CRUD operations interactively against `fuel_cost_config`.

### Key Entities

- **Fuel Cost Configuration**: Represents a single versioned pricing rule record. Stored fields: UUID (stable logical identifier shared by all versions of the same Customer Name + Customer Subname + Truck Type combination), version number (integer, incremented on each update — together UUID + version number form the unique composite key per record), Customer Name (optional reference), Customer Subname (optional reference), Truck Type, Fuel Cost per KM (USD), active flag, Created By (user identity), Created At (timestamp). Scope is never stored — it is inferred at read time from the presence or absence of Customer Name and Customer Subname.
- **Truck Type**: Enumeration of supported vehicle types — Flatbed, Reefer, Dryvan. Required dimension in every configuration record.
- **Customer**: A single entity uniquely identified by its **Name** and an optional **Subname**. Both fields are optional in a configuration record; when both are empty the record acts as the system-wide baseline.
- **Load**: The input object used by the resolution endpoint. Carries: Customer Name, Customer Subname, Truck Type, and Shipment Date. Only Customer Name, Customer Subname, and Truck Type are used for fuel cost resolution.
- **User (Cost Configurator)**: The actor who creates and manages configurations. Captured in audit fields on every version.

## Success Criteria *(mandatory)*

### Measurable Outcomes

- **SC-001**: A Cost Configurator can create, view, edit, and deactivate a fuel cost configuration in under 2 minutes per operation without engineering assistance.
- **SC-002**: Every configuration change is fully traceable — 100% of versions include a user identity and timestamp in the audit trail.
- **SC-003**: No configuration record is ever physically removed from the system; 100% of history is retained indefinitely.
- **SC-004**: Price estimation always resolves the correct active fuel cost following the three-level lookup hierarchy; zero incorrect fallbacks under normal operation.
- **SC-005**: Deactivating a customer-specific override causes subsequent price estimations to fall back to the next applicable scope within one request cycle.
- **SC-006**: An attempt to deactivate the last active System-level baseline for any truck type is rejected 100% of the time before any data is modified.
- **SC-007**: The list endpoint supports filtering by any combination of Customer Name, Customer Subname, and Truck Type, enabling a future management UI to build targeted views without loading all records.

- **SC-008**: An out-of-the-box UI via SQLAdmin correctly visualizes the `FuelCostConfig` DB mapping and successfully validates access using the central JWT setup within the first development attempt.

## Assumptions

- The list of truck types (Flatbed, Reefer, Dryvan) is fixed and managed outside this feature; no truck-type CRUD is required here.
- The System-level baseline is represented by a configuration record where both Customer Name and Customer Subname are empty; there is no special reserved entity for it.
- A Subcustomer inherits its parent Customer for fallback purposes; the two-level hierarchy from the business model is authoritative.
- Scope is never stored in the database; it is always derived at runtime by inspecting the `customer_name` and `customer_subname` fields of the configuration record.
- All monetary values (fuel cost per KM) are stored and displayed in USD.
- The version history view is read-only; past versions cannot be reactivated directly (a new configuration must be created instead).
- Authentication and role assignment are handled by the existing identity system (Casdoor, from the user-auth-authz feature).

## Clarifications

### Session 2026-04-23

- Q: How are versions of the same logical configuration grouped and addressed? → A: All versions share the same UUID (assigned at creation). The unique composite key per record is UUID + version number. The UUID alone is used to address a configuration across endpoints.
- Q: What does Get by UUID return when the configuration has been deactivated? → A: 404 — the endpoint returns only the latest active version; if no active version exists, the resource is considered not found.
- Q: How are concurrent updates to the same configuration handled? → A: Via atomic PostgreSQL transactions — version increment and previous-version deactivation execute as one indivisible operation; no optimistic locking at the API layer is required.
- Q: Should the System-level baseline guard check and the soft-delete also be atomic? → A: Yes — both the guard check (FR-007) and the deactivation update execute within a single PostgreSQL transaction.
- Q: What is the default sort order for the list endpoint? → A: Created At descending — newest configurations appear first.
