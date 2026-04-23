# Price Calculation

The final Price of a Load is the sum of its total cost and its total margin.

## Formula
`Price = all_in_cost + all_in_margin`

## Mathematical Relationships
- **Margin Percent**: A value between 0 and 1 representing the profit ratio relative to the price.
- **Formula for Margin**: To calculate the margin from a percentage:
  `all_in_margin = (all_in_cost * margin_percent) / (1 - margin_percent)`
- **Formula for Margin Percent (Verification)**:
  `margin_percent = (Price - all_in_cost) / Price`

## Workflow
1. Identify the [Load](../entities/load.md) requirements.
2. Execute [Cost Estimation](cost_estimation.md) to get the `all_in_cost`.
3. Execute [Margin Calculation](margin_calculation.md) to get the `all_in_margin`.
4. Generate a unique [Prediction](../entities/prediction.md) with a full breakdown.
