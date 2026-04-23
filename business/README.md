# Business Documentation Index

Welcome to the internal Source of Truth for the **Transport Deluxe** project.

## Project Overview
**Transport Deluxe** is a price prediction engine for truck freight within the United States. Its primary goal is to provide accurate and transparent price forecasts for heavy-duty shipments, considering various factors such as truck types, customer subsidies, route distances, and stochastic market adjustments.

## Core Concepts
- **Price Transparency:** Every prediction includes a detailed breakdown of costs and margins.
- **Hierarchical Customers:** Support for global customers and regional sub-customers.
- **Variable Margins:** Pricing logic that accounts for route specifics, truck types, and time-based discounts.

## Categories
- [Entities](entities/README.md): Physical or conceptual objects like `Truck`, `Customer`, and [User](entities/user.md).
- [Configurations](configurations/): Human-defined rules for costs and margins, governed by the [Configuration Management Policy](resources/configuration_policy.md).
- [Adjustments](adjustments/): Calculated values like `Lead Time Adjustment` and `Stochastic Adjustment`.
- [Interactions](interactions/README.md): Processes like `Price Calculation` and `Cost Estimation`.
- [Resources](resources/README.md): External dependencies such as the `Distance Service`.

## Full Price Prediction Example
To illustrate how all entities and interactions work together, here is a complete scenario.

### 1. Scenario Context
*   **Customer/Subcustomer**: GlobalLogistics / TexasBranch
*   **Route**: Houston (TX) to Dallas (TX) -> **385 km** (via Distance Service)
*   **Truck Type**: Reefer
*   **Dates**: Current Date: April 22 | Shipment Date: April 23 (**1 day Lead Time**)

### 2. Cost Estimation (`all_in_cost`)
*   **Fuel Cost Configuration**: Specific for `TexasBranch` @ Reefer -> `0.60 USD/km` (See [Fuel Cost Configuration](configurations/fuel_cost_configuration.md))
    *   **Base Cost Adjustment**: `385 km * 0.60 USD/km = 231.00 USD`
*   **Driver Tariff Configuration**: 50% of Base Cost (See [Driver Tariff Configuration](configurations/driver_tariff_configuration.md))
    *   **Driver Cost Adjustment**: `231.00 * 0.50 = 115.50 USD`
*   **Customer Cost Week Day Configuration**: 10% (Tuesday promotion) (See [Customer Cost Week Day Configuration](configurations/customer_cost_week_day_configuration.md))
    *   **Customer Cost Adjustment**: `231.00 * 0.10 = -23.10 USD` (expressed as negative)
*   **Result**: `all_in_cost = 231.00 + 115.50 + (-23.10) = 323.40 USD`

### 3. Margin Calculation (`all_in_margin`)
*   **Base Margin Configuration**: Select from configuration -> `0.15 (15%)` (See [Base Margin Configuration](configurations/base_margin_configuration.md))
    *   `Initial Base Margin = (323.40 * 0.15) / (1 - 0.15) ≈ 57.07 USD`
*   **Lead Time Configuration**: From configuration factor -> `0.20 (+20%)` (See [Lead Time Configuration](configurations/lead_time_configuration.md))
    *   **Lead Time Adjustment**: `57.07 * 0.20 = 11.41 USD`
*   **Stochastic Margin Configuration**: From configuration factor -> `0.02 (+2%)` (See [Stochastic Margin Configuration](configurations/stochastic_margin_configuration.md))
    *   **Stochastic Adjustment**: `57.07 * 0.02 = 1.14 USD`
*   **Truck Complexity Margin Configuration**: From configuration factor -> `0.05 (+5%)` (See [Truck Complexity Margin Configuration](configurations/truck_complexity_margin_configuration.md))
    *   **Truck Complexity Adjustment**: `57.07 * 0.05 = 2.85 USD`
*   **Result**: `all_in_margin = 57.07 + 11.41 + 1.14 + 2.85 = 72.47 USD`

### 4. Final Price
*   `Price = all_in_cost + all_in_margin`
*   `Price = 323.40 + 72.47 = 395.87 USD`

---
*Maintained by the Business Truth Agent.*
