# Driver Tariff Adjustment

The **Driver Tariff Adjustment** is the calculated monetary compensation for the driver, based on the [Driver Tariff Configuration](../configurations/driver_tariff_configuration.md) (the human-defined factor) applied to the operational baseline.

## Relationship
- **Source Configuration**: [Driver Tariff Configuration](../configurations/driver_tariff_configuration.md) (The rule/percentage).
- **Base Metric**: [Base Cost Adjustment](base_cost_adjustment.md) (The value derived from distance and fuel).
- **Result**: **Driver Tariff Adjustment** (The actual currency amount).

## Step-by-Step Generation
1. **Get Configuration**: The system retrieves the applicable tariff factor (e.g., 55%) based on the [Load](../entities/load.md)'s Pickup and Drop states from the [Driver Tariff Configuration](../configurations/driver_tariff_configuration.md).
2. **Identify Base**: The system uses the already calculated [Base Cost Adjustment](base_cost_adjustment.md).
3. **Calculate Output**: Multiply the configuration factor by the base cost.

## Calculation Formula
Driver Tariff Adjustment = Base Cost Adjustment * Driver Tariff Configuration factor

## Integration
This adjustment is one of the three components of the [all_in_cost](../interactions/cost_estimation.md). It is additive to the total cost estimation.

## Example
- **Load Route**: CA -> NY
- **Base Cost Adjustment**: 231.00 USD
- **Matched Configuration Factor**: 0.55 (55%)
- **Resulting Adjustment**: 127.05 USD
