# Fuel Cost Configuration

Defines the cost of fuel per kilometer based on the truck type and specific customer agreements.

## Attributes
- **Truck Type**: Reference to [Truck Type](../entities/truck_type.md).
- **Customer Name**: (Optional) Reference to the top-level identifier of a [Customer](../entities/customer.md). If empty, the configuration applies globally.
- **Customer Subname**: (Optional) Reference to a specific branch/region within a [Customer](../entities/customer.md).
- **Fuel Cost per KM**: The monetary value (USD) to be multiplied by the distance.

> **Note on Scope**: "Scope" is not a stored attribute but an **inference** based on which fields are populated. For example, if both Customer Name and Customer Subname are empty, the system infers a "System" scope.

> **Governance Notice**: This configuration is governed by the [Configuration Management Policy](../resources/configuration_policy.md) and requires the **Cost Configurator** role.

## Logic (Specificity Hierarchy)
The system retrieves the fuel cost based on the most specific match available (*Specificity descending*):
1. **Specific Match** (Inferred Scope: *Subcustomer*): `Customer Name + Customer Subname + Truck Type`
2. **Customer Default** (Inferred Scope: *Customer*): `Customer Name + (Empty Subname) + Truck Type`
3. **System Default** (Inferred Scope: *System*): `(Empty Customer Name) + (Empty Subname) + Truck Type`

## Example Data
The following table illustrates how the **Inferred Scope** is determined by the presence of data:

| Customer Name | Customer Subname | Truck Type | Fuel Cost (USD/KM) | Inferred Scope |
| :--- | :--- | :--- | :--- | :--- |
| - | - | Dry Van | 0.50 | **System** |
| - | - | Reefer | 0.65 | **System** |
| - | - | Flatbed | 0.55 | **System** |
| GlobalLogistics | - | Reefer | 0.60 | **Customer** |
| GlobalLogistics | Texas_Branch | Reefer | 0.58 | **Subcustomer** |
