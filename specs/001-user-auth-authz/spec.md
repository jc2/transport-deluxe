# Feature Specification: User Authentication and Authorization

**Feature Branch**: `001-user-auth-authz`
**Created**: 2026-04-23
**Status**: Draft
**Input**: User description: "Implement an authentication and authorization service for Transport Deluxe. Authentication is simple username + password (no email validation, no 2FA). Authorization uses roles: Margin Configurators and Cost Configurators."

## User Scenarios & Testing *(mandatory)*

### User Story 1 - User Login (Priority: P1)

A user with a valid account enters their username and password to gain access to the system. Upon successful authentication, the system identifies the user and their assigned role, enabling them to interact with the parts of the system they are authorized for.

**Why this priority**: Without authentication, no other feature of the system can be used securely. It is the foundation for the audit trail required by the Configuration Management Policy — the system must know *who* is performing every action.

**Independent Test**: Can be fully tested by attempting to log in with valid and invalid credentials and verifying that a valid session is returned on success and an error on failure. Delivers standalone value as the gateway to all system functionality.

**Acceptance Scenarios**:

1. **Given** a registered user with a valid username and password, **When** they submit their credentials, **Then** the system grants access and returns a valid session token that identifies them and their role.
2. **Given** a user submits an incorrect password, **When** the credentials are validated, **Then** the system rejects access with an "invalid credentials" error (without revealing which field was wrong).
3. **Given** a user submits a username that does not exist, **When** the credentials are validated, **Then** the system rejects access with the same generic "invalid credentials" error.
4. **Given** an authenticated user no longer needs access, **When** they log out, **Then** their Casdoor session is ended. The JWT remains technically valid until its natural expiry (24 h, POC), but a downstream service MAY reject it if the token fails signature, audience, issuer, or `exp` validation.

---

### User Story 2 - Role-Based Access Control for Configuration APIs (Priority: P2)

After logging in, the system restricts which configuration endpoints each user can access based on their assigned role. A Cost Configurator can only modify cost-related configurations, and a Margin Configurator can only modify margin-related configurations. These roles are operationally exclusive.

**Why this priority**: The Configuration Management Policy mandates strict role segregation to ensure financial integrity. Without this, any user could modify any configuration, breaking the segregation of duties required by the business.

**Independent Test**: Can be fully tested by authenticating as a Cost Configurator and attempting to access a Margin Configuration endpoint (must be denied), and vice versa. Delivers value as the enforcement mechanism for the Configuration Management Policy.

**Acceptance Scenarios**:

1. **Given** a user authenticated as a Cost Configurator, **When** they attempt to access a cost-related configuration endpoint, **Then** access is granted.
2. **Given** a user authenticated as a Cost Configurator, **When** they attempt to access a margin-related configuration endpoint, **Then** access is denied with a "forbidden" error.
3. **Given** a user authenticated as a Margin Configurator, **When** they attempt to access a margin-related configuration endpoint, **Then** access is granted.
4. **Given** a user authenticated as a Margin Configurator, **When** they attempt to access a cost-related configuration endpoint, **Then** access is denied with a "forbidden" error.
5. **Given** an unauthenticated user, **When** they attempt to access any protected endpoint, **Then** access is denied with an "unauthorized" error.

---

### User Story 3 - Predictor Access to Price Predictions (Priority: P3)

A regular authenticated user (Predictor) who has no special configuration role can request price predictions but cannot access or modify any configuration.

**Why this priority**: The system needs to support the primary consumer of the price engine — users who request predictions — while ensuring they cannot tamper with the underlying configuration data.

**Independent Test**: Can be tested by authenticating as a Predictor and verifying access to prediction endpoints is granted but configuration endpoints are denied.

**Acceptance Scenarios**:

1. **Given** a user authenticated as a Predictor, **When** they request a price prediction, **Then** the system processes the request and returns the prediction.
2. **Given** a user authenticated as a Predictor, **When** they attempt to access any configuration endpoint (cost or margin), **Then** access is denied with a "forbidden" error.

---

### User Story 4 - Developer JWT Test Script (Priority: P4)

A developer running the stack locally needs to quickly obtain valid JWT tokens for each role without going through the Casdoor UI, in order to test protected API endpoints.

**Why this priority**: Accelerates development and integration testing across the monorepo. Without this, developers must manually configure and authenticate through Casdoor for every test run.

**Independent Test**: Can be tested by running the script from the command line with a role argument and verifying that a valid JWT is returned and accepted by a protected endpoint.

**Acceptance Scenarios**:

1. **Given** the Docker Compose stack is running, **When** a developer executes the script with `cost-configurator` as the argument, **Then** a valid JWT with `"cost-configurator"` in the `roles` claim is printed to stdout.
2. **Given** the Docker Compose stack is running, **When** a developer executes the script with `margin-configurator` as the argument, **Then** a valid JWT with `"margin-configurator"` in the `roles` claim is printed to stdout.
3. **Given** the Docker Compose stack is running, **When** a developer executes the script with `predictor` as the argument, **Then** a valid JWT with an empty `roles` array is printed to stdout.
4. **Given** the returned JWT, **When** used in a request to a protected endpoint, **Then** the endpoint enforces the correct access based on the `roles` claim.

---

### Edge Cases

- What happens when a session token expires? The system must reject it with an "unauthorized" error and require re-authentication.
- What happens if a user submits credentials with empty username or password fields? The system must reject the request with a validation error before attempting any credential lookup.
- What happens if a user holds both Cost Configurator and Margin Configurator roles? Both roles are permitted; the user gains access to both cost and margin configuration endpoints. Role assignment is the responsibility of the Casdoor administrator.
- What happens when a user account is deactivated in the 3rd party provider? Deactivation is handled entirely in Casdoor — the account is disabled there. Any active JWTs expire naturally within their 24 h lifetime. No blacklist or server-side revocation is maintained in this POC.

## Requirements *(mandatory)*

### Functional Requirements

- **FR-001**: Users MUST be able to authenticate by providing a username and password.
- **FR-002**: The system MUST reject authentication attempts with incorrect credentials using a generic error message that does not reveal whether the username or password was the invalid field.
- **FR-003**: Upon successful authentication, Casdoor MUST issue a signed JWT access token that encodes the user's identity and their assigned roles in the `roles` array claim.
- **FR-004**: Downstream services MUST validate the JWT signature and expiry on every protected request using Casdoor's JWKS endpoint. *(POC: no server-side blacklist — tokens expire naturally.)*
- **FR-005**: The system MUST provide a logout mechanism via Casdoor's native logout endpoint. *(POC: active JWTs remain valid until their 24 h expiry; no blacklist is maintained.)*
- **FR-006**: A user may hold zero, one, or both of the configurator roles (`cost-configurator`, `margin-configurator`). A user with no role is treated as a Predictor. There is no enforced minimum or maximum role count.
- **FR-007**: A user MAY hold both Cost Configurator and Margin Configurator roles simultaneously. Role assignment is the responsibility of the Casdoor administrator. If both roles are present, the user gains access to both cost and margin configuration endpoints.
- **FR-008**: Cost Configurators MUST have access to all cost-related configuration operations (`all_in_cost` scope) and MUST be denied access to all margin-related configuration operations.
- **FR-009**: Margin Configurators MUST have access to all margin-related configuration operations (`all_in_margin` scope) and MUST be denied access to all cost-related configuration operations.
- **FR-010**: Predictors MUST have access to price prediction requests and MUST be denied access to all configuration operations (both cost and margin).
- **FR-011**: Unauthenticated requests to any protected endpoint MUST be denied with an "unauthorized" response.
- **FR-012**: The system MUST expose the authenticated user's identity (username and role) so that downstream services can record it for audit purposes (per the Configuration Management Policy).
- **FR-013**: The system MUST delegate credential storage and password security (hashing, etc.) entirely to the 3rd party identity provider; the auth service MUST NOT store or handle raw passwords.
- **FR-014**: Role assignments are owned by Casdoor and surfaced natively in the JWT `roles` array claim. No scope-mapping layer is required.
- **FR-015**: All downstream APIs in the monorepo MUST authorize requests by inspecting the `roles` array claim of the JWT; no out-of-band permission lookup is required per request.
- **FR-016**: The Casdoor identity provider MUST be run as a Docker container and included in the project's Docker Compose configuration so the entire stack can be started with a single command.
- **FR-017**: The project README MUST document the local URL where Casdoor's admin console is accessible for user and role management.
- **FR-018**: The project MUST include a CLI script located in a `scripts/` folder that generates valid JWT access tokens for testing purposes, supporting the following scenarios: a Cost Configurator user, a Margin Configurator user, and a user with no roles (Predictor). The script MUST be executable from the command line without additional setup beyond the running Docker Compose stack.

### Key Entities *(include if feature involves data)*

- **User**: Represents a person with access to the system. Identity and credentials are owned by the 3rd party identity provider. Key attributes surfaced to this service: username (unique identifier), role, active status.
- **Role**: Defines what operations a user is permitted to perform. Values: `Predictor`, `Cost Configurator`, `Margin Configurator`. Roles are assigned and managed exclusively in the 3rd party provider's admin console; role exclusivity between Cost Configurator and Margin Configurator is enforced there.
- **JWT Access Token**: A signed JWT issued by Casdoor after successful login, encoding user identity and assigned roles. Valid when: signature is valid (RS256, verified via JWKS), `iss` matches the Casdoor issuer, `aud` matches the application, and `exp` is in the future. Expires naturally after 24 h (POC). No server-side blacklist.

## Success Criteria *(mandatory)*

### Measurable Outcomes

- **SC-001**: 100% of requests to protected endpoints by unauthenticated users are rejected — no unauthorized access is possible.
- **SC-002**: 100% of unauthorized cross-role access attempts are blocked — e.g., a user whose `roles` claim contains only `cost-configurator` attempting to access a margin configuration endpoint is denied. A user whose `roles` claim contains both `cost-configurator` and `margin-configurator` is granted access to both endpoint types.
- **SC-003**: Every configuration change event in the system is traceable to an authenticated user identity, satisfying the audit requirement of the Configuration Management Policy.
- **SC-004**: Users can complete the login flow and obtain a working session in under 5 seconds under normal load.
- **SC-005**: Invalid credentials never reveal whether the username or password was the failing field — verified by security review.
- **SC-006**: No credentials or plain-text passwords are stored or processed by this service — all credential handling is delegated to Casdoor, verified by security review.
- **SC-007**: The full stack (Casdoor + all APIs) can be started with a single `docker compose up` command.
- **SC-008**: A developer can generate a test JWT for any role in under 30 seconds using the CLI script in `scripts/`.

## Clarifications

### Session 2026-04-23

- Q: What session/token mechanism should be used for authentication and immediate revocation? → A: ~~OAuth 2.0 with stateless JWT tokens and a server-side blacklist for immediate revocation (logout and account deactivation).~~ **Superseded**: Casdoor-native architecture — no custom auth-service, no blacklist. JWTs are issued directly by Casdoor and expire naturally (24 h POC lifetime). Logout delegates to Casdoor's native endpoint.
- Q: What is the scope for user account management (creation, role assignment, deactivation)? → A: Fully delegated to a 3rd party identity provider with its own admin console; no user management API is part of this feature.
- Q: What is the specific 3rd party identity provider? → A: Unknown at this time; the only constraint is that it follows the OAuth 2.0 standard. Integration must be provider-agnostic.
- Q: How are roles encoded in the JWT for downstream authorization? → A: ~~As OAuth 2.0 scopes in the standard `scope` claim (e.g., `cost:configure`, `margin:configure`).~~ **Superseded**: Casdoor surfaces roles natively in the `roles` array claim (e.g., `["cost-configurator", "margin-configurator"]`). Downstream APIs check the `roles` array directly.
- Q: What is the token expiry and refresh strategy? → A: Long-lived access token with no refresh token (POC). Users must re-authenticate manually after expiry.
- Q: What is the selected identity provider and deployment model? → A: **Casdoor**, fully Dockerized and included in the project's Docker Compose setup. User management is done via Casdoor's built-in admin console. Local admin URL documented in the project README.
- Q: Is there a need for test tooling to generate JWTs? → A: Yes — a CLI script in a `scripts/` folder that quickly issues JWTs for each role (Cost Configurator, Margin Configurator, Predictor) for local development and testing.

- Q: Does this feature require a custom Python auth-service in addition to Casdoor? → A: **No.** The Casdoor implementation consists only of Docker Compose configuration and volumes. No custom Python auth-service is built as part of this feature. Future Python APIs will verify Casdoor-issued JWTs directly using Casdoor's JWKS endpoint — no custom middleware service is involved.

## Assumptions

- **A-001**: There are three user roles: Predictor (any authenticated user without a special role), Cost Configurator, and Margin Configurator. The user description mentioned two roles (Cost Configurator and Margin Configurator); Predictor is the implicit third role for general authenticated users as documented in the business entity model.
- **A-002**: User account lifecycle (creation, role assignment, deactivation) is fully managed in the 3rd party identity provider's admin console. This feature delivers only the authentication/authorization integration layer — no user management API is in scope.
- **A-003**: Email validation, account recovery (password reset), and second-factor authentication are explicitly out of scope.
- **A-008**: The selected identity provider is **Casdoor** — an open-source, OAuth 2.0 / OIDC compliant IdP. It is deployed as a Docker container within the project's Docker Compose stack. User and role management is performed through Casdoor's built-in web admin console.
- **A-009**: ~~The canonical scope values are: `cost:configure`, `margin:configure`, `predict`.~~ **Superseded by architecture**: Casdoor role names are used directly as the stable contract: `cost-configurator`, `margin-configurator`. A user with no role is treated as a Predictor (empty `roles` array).
- **A-004**: This is a proof-of-concept. The system uses long-lived OAuth 2.0 JWT access tokens with no refresh token mechanism. Users must re-authenticate manually after token expiry. Token lifetime will be defined during planning. This strategy may be revised before production.
- **A-005**: Casdoor serves as the shared identity boundary for the monorepo. Each downstream API verifies JWTs independently using Casdoor's JWKS endpoint; no central gateway or introspection service is involved.
- **A-006**: A user may hold more than one role simultaneously. Role assignment and removal is the sole responsibility of the Casdoor administrator.
- **A-007**: Account deactivation is handled entirely in Casdoor (account disabled in the admin console). Active JWTs expire naturally within their 24 h lifetime. No blacklist or server-side revocation mechanism is implemented in this POC. This is out of scope for this feature.
