# Lead Time Adjustment

The **Lead Time Adjustment** is a modification to the margin based on how far in advance a load is scheduled.

## Relationship
- **Source Configuration**: [Lead Time Configuration](../configurations/lead_time_configuration.md).
- **Base Metric**: **Initial Base Margin**.
- **Result**: **Lead Time Adjustment** (The actual currency amount).

## Step-by-Step Generation
1. **Determine Lead Time**: Calculate the number of days between "today" and the shipment date.
2. **Get Configuration**: Retrieve the adjustment factor for that many days from [Lead Time Configuration](../configurations/lead_time_configuration.md).
3. **Calculate Output**: Multiply the factor by the **Initial Base Margin**.

## Calculation Formula
Lead Time Adjustment = Initial Base Margin * Lead Time Adjustment Factor

## Integration
This adjustment is one of the components of the [all_in_margin](../interactions/margin_calculation.md).
