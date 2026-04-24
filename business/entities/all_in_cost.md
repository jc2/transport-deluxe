# All In Cost

The **All In Cost** represent the total operational expenditure required to fulfill a transport request. It is the primary aggregate of the [Cost Estimation](../interactions/cost_estimation.md) process.

## Composition
This entity is the sum of two specific monetary adjustments:

1. **[Base Cost Adjustment](../adjustments/base_cost_adjustment.md)**: The foundational cost based on distance and fuel.
2. **[Driver Tariff Adjustment](../adjustments/driver_tariff_adjustment.md)**: The driver's compensation (50% of base).

## Formula
```text
all_in_cost = Base Cost Adjustment + Driver Tariff Adjustment
```

## Role in Pricing
The **All In Cost** serves as the monetary base for calculating the Initial Base Margin in [Margin Calculation](../interactions/margin_calculation.md) (not to be confused with the final Margin). It represents the "break-even" point before any business profit is applied.
