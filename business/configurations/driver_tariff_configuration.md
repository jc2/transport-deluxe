# Driver Tariff Configuration

Defines the compensation factor for the driver, calculated as a percentage of the base operational cost, based on the location (State) of pickup and delivery.

## Attributes
- **Pickup State**: (Optional) The shipping origin state (e.g., CA, TX).
- **Drop State**: (Optional) The shipping destination state (e.g., NY, FL).
- **Tariff Factor**: A configurable decimal value used to calculate the driver's pay.

> **Wildcard Logic**: In the database, a `NULL` value for any location attribute acts as a **Global Matcher**. If an attribute is `NULL`, the configuration applies to all possible values for that field.

> **Constraint**: At least one location (**Pickup State** or **Drop State**) must be specified. A configuration cannot have both fields empty (which would imply a global default that is not supported for this specific entity).

> **Uniqueness**: The combination of `Pickup State` and `Drop State` must be unique. No duplicate configurations for the same route segment are allowed.

> **Governance Notice**: This configuration is governed by the [Configuration Management Policy](../resources/configuration_policy.md) and requires the **Cost Configurator** role.

> **Decimal Notation**: All factors are expressed as decimals (e.g., 1.0 = 100%, 0.1 = 10%).

## Logic (Specificity Hierarchy)
The system retrieves the tariff factor based on the most specific match available (*Specificity descending*):
1. **Specific Route**: `Pickup State + Drop State`
2. **Origin Default**: `Pickup State + (Empty Drop State)`
3. **Destination Default**: `(Empty Pickup State) + Drop State`

## Example Data
The following table illustrates how different combinations determine the factor:

| Pickup State | Drop State | Tariff Factor | Description |
| :--- | :--- | :--- | :--- |
| CA | NY | 0.55 | Specific route from California to New York |
| TX | - | 0.52 | Any load originating in Texas |
| - | FL | 0.48 | Any load delivering in Florida |

## Calculation
1. **Application**: The factor is retrieved based on the [Load](../entities/load.md)'s origin and destination states.
2. The factor is applied directly to the **Base Cost Adjustment** calculated in the [Cost Estimation](../interactions/cost_estimation.md).
3. The result is the [Driver Tariff Adjustment](../adjustments/driver_tariff_adjustment.md).

## Calculation Example
- **Route**: CA -> NY
- **Base Cost Adjustment**: 231.00 USD
- **Matched Factor**: 0.55 (55%)
- **Driver Tariff Adjustment**: `231.00 * 0.55 = 127.05 USD`
