# Truck Complexity Margin Configuration

Defines margin adjustments based on the route distance to compensate for increased logistical complexity on longer hauls.

## Logic
1. This configuration retrieves a factor based on the **Route distance**. All distances are integers; non-integer distances are always rounded up (ceiling) to the next whole kilometer before lookup.

> **Governance Notice**: This configuration is governed by the [Configuration Management Policy](../resources/configuration_policy.md) and requires the **Margin Configurator** role.

> **Decimal Notation**: All factors are expressed as decimals (e.g., 1.0 = 100%, 0.1 = 10%).

2. **Application**: The factor is applied to the **Initial Base Margin**.
3. The result is [Truck Complexity Adjustment](../interactions/truck_complexity_adjustment.md).

## Example Distribution
Since distances are rounded up to the nearest integer, boundaries have no gaps:
| Distance Range | Multiplier |
| :--- | :--- |
| 0 - 500 km | 0.05 |
| 501 - 1000 km | 0.08 |
| 1001+ km | 0.12 |
