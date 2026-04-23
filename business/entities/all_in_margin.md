# All In Margin

The **All In Margin** represents the total business profit added to a prediction. It is the final aggregate of the [Margin Calculation](../interactions/margin_calculation.md) process.

## Composition
This entity is a multi-layered aggregate starting from an initial baseline:

1. **Initial Base Margin**: The starting profit value derived from cost and percent.
2. **[Lead Time Adjustment](../adjustments/lead_time_adjustment.md)**: Urgency-based additive value.
3. **[Stochastic Adjustment](../adjustments/stochastic_adjustment.md)**: Market-volatility additive value.
4. **[Truck Complexity Adjustment](../adjustments/truck_complexity_adjustment.md)**: Distance/Complexity additive value.

## Formula
```text
all_in_margin = Initial Base Margin + Lead Time Adjustment + Stochastic Adjustment + Truck Complexity Adjustment
```

## Role in Pricing
The **All In Margin** is the total value added to the [All In Cost](all_in_cost.md) to determine the final [Prediction](prediction.md) price. It ensures the business captures profit while adjusting for specific shipment risks and conditions.
