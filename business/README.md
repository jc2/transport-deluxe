# Business Documentation Index

Welcome to the internal Source of Truth for the **Transport Deluxe** project.

## Project Overview
**Transport Deluxe** is a price prediction engine for truck freight within the United States. Its primary goal is to provide accurate and transparent price forecasts for heavy-duty shipments, considering various factors such as truck types, route distances, and market dynamics.

## Core Concepts
- **Price Transparency:** Every prediction includes a detailed breakdown of costs and margins.
- **Hierarchical Customers:** Support for global customers (Name) and regional branches (Subname).
- **Variable Margins:** Pricing logic that accounts for route specifics, truck types, and time-based discounts.

## Categories
- [Entities](entities/README.md): Physical or conceptual objects like `Truck`, `Customer`, and [User](entities/user.md).
- [Configurations](configurations/): Human-defined rules for costs and margins, governed by the [Configuration Management Policy](resources/configuration_policy.md).
- [Adjustments](adjustments/): Calculated values like `Lead Time Adjustment`.
- [Interactions](interactions/README.md): Processes like `Price Calculation` and `Cost Estimation`.
- [Resources](resources/README.md): External dependencies such as the `Distance Service`.

## Full Price Prediction Example
To illustrate how all entities and interactions work together, here is a complete scenario.

### 1. Scenario Context
*   **Customer Name/Subname**: GlobalLogistics / TexasBranch
*   **Route**: Houston (TX) to Dallas (TX) -> **385 km** (via Distance Service)
*   **Truck Type**: Reefer
*   **Dates**: Current Date: April 22 | Shipment Date: April 23 (**1 day Lead Time**)

### 2. Cost Estimation (`all_in_cost`)
*   **Fuel Cost Configuration**: Specific for `TexasBranch` @ Reefer -> `0.60 USD/km` (See [Fuel Cost Configuration](configurations/fuel_cost_configuration.md))
    *   **Base Cost Adjustment**: `385 km * 0.60 USD/km = 231.00 USD`
*   **Driver Tariff Configuration**: 50% of Base Cost (See [Driver Tariff Configuration](configurations/driver_tariff_configuration.md))
    *   **Driver Cost Adjustment**: `231.00 * 0.50 = 115.50 USD`
*   **Result**: `all_in_cost = 231.00 + 115.50 = 346.50 USD`

### 3. Margin Calculation (`all_in_margin`)
*   **Base Margin Configuration**: Select from configuration -> `0.15 (15%)` (See [Base Margin Configuration](configurations/base_margin_configuration.md))
    *   `Initial Base Margin = (346.50 * 0.15) / (1 - 0.15) ≈ 61.15 USD`
*   **Lead Time Configuration**: From configuration factor -> `0.20 (+20%)` (See [Lead Time Configuration](configurations/lead_time_configuration.md))
    *   **Lead Time Adjustment**: `61.15 * 0.20 = 12.23 USD`
*   **Result**: `all_in_margin = 61.15 + 12.23 = 73.38 USD`

### 4. Final Price
*   `Price = all_in_cost + all_in_margin`
*   `Price = 346.50 + 73.38 = 419.88 USD`

---
*Maintained by the Business Truth Agent.*
