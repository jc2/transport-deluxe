# Customer Cost Adjustment

The **Customer Cost Adjustment** is a discount applied to the base cost based on the customer and the day of the week.

## Relationship
- **Source Configuration**: [Customer Cost Week Day Configuration](../configurations/customer_cost_week_day_configuration.md) (The discount percentage).
- **Base Metric**: **Base Cost Adjustment**.
- **Result**: **Customer Cost Adjustment** (A negative currency amount/discount).

## Step-by-Step Generation
1. **Get Configuration**: Lookup [Customer Cost Week Day Configuration](../configurations/customer_cost_week_day_configuration.md) using shipment date and customer.
2. **Identify Base**: Use the calculated [Base Cost Adjustment](base_cost_adjustment.md).
3. **Calculate Output**: Multiply the configuration factor by the base cost.

## Calculation Formula
Customer Cost Adjustment = Base Cost Adjustment * Customer Cost Configuration Multiplier (which is always a negative value or 0).

## Integration
This negative value is added during the total cost estimation process in [Cost Estimation](../interactions/cost_estimation.md), effectively reducing the overall cost.
