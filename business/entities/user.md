# User

Represents a person interacting with the system. Access to sensitive operations like configuration changes is strictly governed by user roles.

## Roles and Permissions

### 1. Authenticated User (Predictor)
- **Purpose**: Users who obtain price predictions.
- **Authentication**: **Required**.
- **Authorization**: No special permissions required beyond a valid account.
- **Permissions**:
    - Can request price predictions.
    - No access to modify configurations or adjustments.

### 2. Cost Configurator
- **Purpose**: Users responsible for managing the cost base of the business.
- **Permissions**:
    - Full access to creating and editing all [Cost Configurations](../configurations/).
    - Cannot modify Margin Configurations.
- **Scope**: Can affect any configuration related to `all_in_cost` calculation (e.g., fuel cost, driver tariffs).

### 3. Margin Configurator
- **Purpose**: Users responsible for defining business profitability and dynamic pricing strategies.
- **Permissions**:
    - Full access to creating and editing all [Margin Configurations](../configurations/).
    - Cannot modify Cost Configurations.
- **Scope**: Can affect any configuration related to `all_in_margin` calculation (e.g., base margin, lead time complexity).

## Segregation of Duties
To ensure financial integrity, the roles of **Cost Configurator** and **Margin Configurator** are mutually exclusive in their operational impact. A Cost Configurator cannot affect the margin logic, and vice versa.
