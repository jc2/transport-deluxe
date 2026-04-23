# Base Margin Configuration

Defines the business-standard profitability percentage applied to different transport types.

## Attributes
- **Margin Percent**: A decimal value (0 to 0.99) representing the desired profit margin. The system enforces a hard limit of 0.99 (99%) to prevent division-by-zero errors in the margin formula.

> **Governance Notice**: This configuration is governed by the [Configuration Management Policy](../resources/configuration_policy.md) and requires the **Margin Configurator** role.

> **Decimal Notation**: All factors are expressed as decimals (e.g., 0.99 = 99%, 0.1 = 10%).

## Logic
1. This configuration provides the `Base Margin Percent`.
2. It is used in the **Price Calculation** to determine the **Initial Base Margin**.
3. **Formula**: `Initial Base Margin = (all_in_cost * Base Margin Percent) / (1 - Base Margin Percent)`.

## Calculation Example
- If **Base Margin Percent** is **0.15** (representing 15%) and **Cost** is **100 USD**:
- `Initial Base Margin = (100 * 0.15) / (1 - 0.15) ≈ 17.65 USD`.
