# Driver Tariff Configuration

Defines the compensation factor for the driver, calculated as a percentage of the base operational cost.

## Attributes
- **Tariff Factor**: A configurable decimal value used to calculate the driver's pay (currently defaulted to 0.50 or 50% in the system, but fully modifiable via configuration).

> **Governance Notice**: This configuration is governed by the [Configuration Management Policy](../resources/configuration_policy.md) and requires the **Cost Configurator** role.

> **Decimal Notation**: All factors are expressed as decimals (e.g., 1.0 = 100%, 0.1 = 10%).

## Logic
1. This is a **Global** configuration that applies to all shipments regardless of customer or route.
2. **Application**: The factor is applied directly to the **Base Cost Adjustment** calculated in the [Cost Estimation](../interactions/cost_estimation.md).
3. The result is the [Driver Tariff Adjustment](../interactions/driver_tariff_adjustment.md).

## Calculation Example
- **Base Cost Adjustment**: 231.00 USD
- **Tariff Factor**: 0.50 (50%)
- **Driver Tariff Adjustment**: `231.00 * 0.50 = 115.50 USD`
