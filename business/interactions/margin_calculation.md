# Margin Calculation

Margin is the business profit added to the [all_in_cost](cost_estimation.md).

## Step-by-Step Calculation
1. **Determine Initial Base Margin**:
    - **Configuration Search**: Lookup [Base Margin Configuration](../configurations/base_margin_configuration.md) to identify the correct percentage (0 to 1).
    - **Application**: Convert percent to currency: `Initial Base Margin = (all_in_cost * %) / (1 - %)`.
2. **Determine [Lead Time Adjustment](../adjustments/lead_time_adjustment.md)**:
    - **Configuration Search**: Lookup [Lead Time Configuration](../configurations/lead_time_configuration.md) based on days to shipment.
    - **Application**: Multiply **Initial Base Margin** by the retrieved factor.
3. **Determine [Stochastic Adjustment](../adjustments/stochastic_adjustment.md)**:
    - **Configuration Search**: Lookup [Stochastic Margin Configuration](../configurations/stochastic_margin_configuration.md).
    - **Application**: Multiply **Initial Base Margin** by the retrieved factor.
4. **Determine [Truck Complexity Adjustment](../adjustments/truck_complexity_adjustment.md)**:
    - **Configuration Search**: Lookup [Truck Complexity Margin Configuration](../configurations/truck_complexity_margin_configuration.md) based on distance.
    - **Application**: Multiply **Initial Base Margin** by the retrieved factor.
5. **Determine all_in_margin**: Sum all components: `Initial Base Margin + Lead Time Adjustment + Stochastic Adjustment + Truck Complexity Adjustment`.

## Formula
all_in_margin = Initial Base Margin + Lead Time Adjustment + Stochastic Adjustment + Truck Complexity Adjustment

## Example
If a load has:
- **all_in_cost**: 100 USD
- **Base Margin Percent**: 15%

**Step 1 (Initial Base Margin)**:
- `(100 * 0.15) / (1 - 0.15) = 17.65 USD`

**Step 2 (Lead Time Example)**:
- If Lead Time Factor is +20%: `17.65 * 0.20 = 3.53 USD`

**Resulting all_in_margin**: Sum of all adjustments.
