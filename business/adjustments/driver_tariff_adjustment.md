# Driver Tariff Adjustment

The **Driver Tariff Adjustment** is the calculated monetary compensation for the driver, based on the [Driver Tariff Configuration](../configurations/driver_tariff_configuration.md) (the human-defined factor) applied to the operational baseline.

## Relationship
- **Source Configuration**: [Driver Tariff Configuration](../configurations/driver_tariff_configuration.md) (The rule/percentage).
- **Base Metric**: [Base Cost Adjustment](base_cost_adjustment.md) (The value derived from distance and fuel).
- **Result**: **Driver Tariff Adjustment** (The actual currency amount).

## Step-by-Step Generation
1. **Get Configuration**: The system retrieves the current tariff factor (e.g., 50%).
2. **Identify Base**: The system uses the already calculated [Base Cost Adjustment](base_cost_adjustment.md).
3. **Calculate Output**: Multiply the configuration factor by the base cost.

## Calculation Formula
Driver Tariff Adjustment = Base Cost Adjustment * Driver Tariff Configuration factor

## Integration
This adjustment is one of the three components of the [all_in_cost](../interactions/cost_estimation.md). It is additive to the total cost estimation.

## Example
- **Base Cost Adjustment**: 231.00 USD
- **Configuration Factor**: 0.50 (50%)
- **Resulting Adjustment**: 115.50 USD
