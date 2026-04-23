# Prediction

The final output of the pricing engine, encapsulating the entire calculation audit trail.

## Characteristics
- **Unique Identifier**: Each prediction is assigned a UUID.
- **Detailed Origin**: All configurations in the system are versioned and never hard-deleted. They have a unique version ID. The prediction saves the exact IDs of the configuration versions that were active at the moment of the prediction, allowing for a perfect historical reconstruction.

## Full Breakdown (Transparency Policy)
A prediction is not just a final price; it is a nested structure of **Adjustments** derived from **Configurations**.

### 1. Cost Breakdown ([all_in_cost](all_in_cost.md))
Total operational expense calculated in [Cost Estimation](../interactions/cost_estimation.md).
- **[Base Cost Adjustment](../adjustments/base_cost_adjustment.md)**: (Distance * Fuel Rate).
- **[Driver Tariff Adjustment](../adjustments/driver_tariff_adjustment.md)**: (Base Cost * 0.50).
- **[Customer Cost Adjustment](../adjustments/customer_cost_adjustment.md)**: (Base Cost * WeekDay Discount).

### 2. Margin Breakdown ([all_in_margin](all_in_margin.md))
Total business profit calculated in [Margin Calculation](../interactions/margin_calculation.md).
- **Initial Base Margin**: Derived from [Base Margin Configuration](../configurations/base_margin_configuration.md).
- **[Lead Time Adjustment](../adjustments/lead_time_adjustment.md)**: (Base Margin * Lead Time Factor).
- **[Stochastic Adjustment](../adjustments/stochastic_adjustment.md)**: (Base Margin * Stochastic Factor).
- **[Truck Complexity Adjustment](../adjustments/truck_complexity_adjustment.md)**: (Base Margin * Complexity Factor).

### 3. Final Price
The sum of the top-level aggregates.
- `Price = all_in_cost + all_in_margin`
