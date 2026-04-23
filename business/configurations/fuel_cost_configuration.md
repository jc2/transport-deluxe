# Fuel Cost Configuration

Defines the cost of fuel per kilometer based on the truck type and specific customer agreements.

## Attributes
- **Truck Type**: Reference to [Truck Type](../entities/truck_type.md).
- **Customer**: Reference to [Customer](../entities/customer.md).
- **Fuel Cost per KM**: The monetary value (USD) to be multiplied by the distance.

> **Governance Notice**: This configuration is governed by the [Configuration Management Policy](../resources/configuration_policy.md) and requires the **Cost Configurator** role.

> **Decimal Notation**: All factors are expressed as decimals (e.g., 1.0 = 100%, 0.1 = 10%).

## Logic
1. The system searches for a specific match: `Customer + Truck Type`.
2. If not found, it searches for a `Global + Truck Type` default.
3. The result is used as the basis for the **Base Cost Adjustment** in the [Cost Estimation](../interactions/cost_estimation.md).

## Example Data
| Customer | Truck Type | Fuel Cost (USD/KM) |
| :--- | :--- | :--- |
| Global | Dry Van | 0.50 |
| Global | Reefer | 0.65 |
| Global | Flatbed | 0.55 |
| GlobalLogistics | Reefer | 0.60 |
