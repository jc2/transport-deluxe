# Truck Complexity Adjustment

The **Truck Complexity Adjustment** is a margin adjustment based on the complexity of the truck type required.

## Relationship
- **Source Configuration**: [Truck Complexity Margin Configuration](../configurations/truck_complexity_margin_configuration.md).
- **Base Metric**: **Initial Base Margin**.
- **Result**: **Truck Complexity Adjustment** (The actual currency amount).

## Step-by-Step Generation
1. **Identify Truck Type**: Determine the truck type assigned to the load.
2. **Get Configuration**: Retrieve the complexity factor for that truck type from [Truck Complexity Margin Configuration](../configurations/truck_complexity_margin_configuration.md).
3. **Calculate Output**: Multiply the factor by the **Initial Base Margin**.

## Calculation Formula
Truck Complexity Adjustment = Initial Base Margin * Truck Complexity Factor

## Integration
This adjustment is one of the components of the [all_in_margin](../interactions/margin_calculation.md).
