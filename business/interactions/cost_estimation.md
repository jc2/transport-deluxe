# Cost Estimation

Cost is the calculated expense of performing the transport.

## Step-by-Step Calculation
1. **Identify Route Distance**: Obtain the distance in km via the [Distance Service](../resources/distance_service.md).
2. **Determine [Base Cost Adjustment](../adjustments/base_cost_adjustment.md)**:
    - **Configuration Search**: Lookup [Fuel Cost Configuration](../configurations/fuel_cost_configuration.md) by `Subcustomer` + `Truck Type`. If not found, fallback to `Customer` + `Truck Type`. If not found, fallback to `Global` + `Truck Type`. A Global configuration MUST exist, otherwise the system will throw an error.
    - **Application**: Multiply distance by the retrieved `fuel_cost_per_km` to produce the **Base Cost Adjustment**.
3. **Determine [Driver Tariff Adjustment](../adjustments/driver_tariff_adjustment.md)**:
    - **Configuration Search**: Retrieve the factor from [Driver Tariff Configuration](../configurations/driver_tariff_configuration.md) (currently fixed at 50% but strictly retrieved from configuration).
    - **Application**: Apply this factor to the **Base Cost Adjustment**.
4. **Determine [Customer Cost Adjustment](../adjustments/customer_cost_adjustment.md)**:
    - **Configuration Search**: Lookup [Customer Cost Week Day Configuration](../configurations/customer_cost_week_day_configuration.md) based on the `Shipment Date` (Day of Week) and `Customer` (inherits from parent if missing for Subcustomer).
    - **Application**: Multiply the **Base Cost Adjustment** by the retrieved negative percent. This value is always a negative amount.
5. **Determine all_in_cost**: Sum all three adjustments: `Base Cost Adjustment + Driver Tariff Adjustment + Customer Cost Adjustment`.

## Formula
`all_in_cost = Base Cost Adjustment + Driver Tariff Adjustment + Customer Cost Adjustment`

## Factors
- **Distance**: Retrieved from the external [Distance Service](../resources/distance_service.md). This is a **mandatory** dependency. Distance is always rounded up to the nearest integer metric.
- **Customer Cost Adjustment**: A discount applied based on the specific day of the week for certain customers. See [Customer Cost Week Day Configuration](../configurations/customer_cost_week_day_configuration.md).

## Example
If a load has:
- **Base Cost Adjustment**: 40 USD
- **Driver Tariff Adjustment**: 20 USD (50% of 40)
- **Customer Cost Adjustment**: -10% (-0.1 multiplier for the selected customer/day)
- **Calculation**: 40 + 20 + (-4) = 56 USD

The **Customer Cost Adjustment** would be:
`40 * 0.10 = 4 USD`

The **all_in_cost** Calculation:
`40 + 20 - 4 = 56 USD`
