# Stochastic Adjustment

The **Stochastic Adjustment** is a probabilistic adjustment applied to the margin.

## Relationship
- **Source Configuration**: [Stochastic Margin Configuration](../configurations/stochastic_margin_configuration.md).
- **Base Metric**: **Initial Base Margin**.
- **Result**: **Stochastic Adjustment** (The actual currency amount).

## Step-by-Step Generation
1. **Get Configuration**: Retrieve the probability distribution from [Stochastic Margin Configuration](../configurations/stochastic_margin_configuration.md).
2. **Determine Factor**: The system selects a factor based on the defined distribution.
3. **Calculate Output**: Multiply the factor by the **Initial Base Margin**.

## Calculation Formula
Stochastic Adjustment = Initial Base Margin * Stochastic Factor

## Integration
This adjustment is one of the components of the [all_in_margin](../interactions/margin_calculation.md).
