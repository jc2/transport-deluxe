# Base Cost Adjustment

The **Base Cost Adjustment** is the primary cost component derived from fuel consumption and distance.

## Relationship
- **Source Configuration**: [Fuel Cost Configuration](../configurations/fuel_cost_configuration.md) (The cost per km).
- **Core Dependency**: [Distance Service](../resources/distance_service.md) (Operational data).
- **Result**: **Base Cost Adjustment** (The actual currency amount).

## Step-by-Step Generation
1. **Get Distance**: Obtain the route distance from the [Distance Service](../resources/distance_service.md).
2. **Get Configuration**: Retrieve the fuel cost per km from [Fuel Cost Configuration](../configurations/fuel_cost_configuration.md).
3. **Calculate Output**: Multiply distance by the fuel cost per km.

## Calculation Formula
Base Cost = Distance * Fuel Rate

*Where:*
- **Distance**: strictly in Kilometers (KM).
- **Fuel Rate**: USD per KM from [Fuel Cost Configuration](../configurations/fuel_cost_configuration.md).

## Integration
This is the foundational value for the [Driver Tariff Adjustment](driver_tariff_adjustment.md).
