# Lead Time Configuration

The Lead Time Configuration defines the rules for urgency-based margin adjustments relative to the shipment date.

## Mechanism
This is a Configuration Factor based on the difference (in integer days) between the system-generated **Current Date** and the *Shipment Date*.

> **Note on Dates**: For simplicity, dates do not contain time components (only Year-Month-Day). The difference is always calculated as an integer number of calendar days.

> **Decimal Notation**: All factors are expressed as decimals (e.g., 1.0 = 100%, 0.1 = 10%).

## Configuration Table (Example)
The system uses configurable ranges of days to determine the adjustment factor:

| Days to Shipment | Configuration Factor | Description |
| :--- | :--- | :--- |
| 0 - 1 | 0.20 | High urgency (+20%) |
| 2 - 5 | 0.05 | Standard lead time (+5%) |
| 6+ | 0.00 | Advanced booking (0%) |

## Business Rule
- This configuration is used to calculate the **Lead Time Adjustment**.
- It acts as a multiplier applied exclusively to the **Initial Base Margin**.

## Example
If the **Initial Base Margin** is **17.65 USD**:
- **Case A (Urgent)**: Shipment is scheduled for tomorrow (1 day lead time). The factor is **0.20**.
  - `Lead Time Adjustment = 17.65 * 0.20 = 3.53 USD`.
- **Case B (Standard)**: Shipment is scheduled for next week (7 days lead time). The factor is **0.00**.
  - `Lead Time Adjustment = 17.65 * 0.00 = 0.00 USD`.
