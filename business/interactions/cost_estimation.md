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
4. **Determine all_in_cost**: Sum both adjustments: `Base Cost Adjustment + Driver Tariff Adjustment`.

## Formula
`all_in_cost = Base Cost Adjustment + Driver Tariff Adjustment`

## Factors
- **Distance**: Retrieved from the external [Distance Service](../resources/distance_service.md). This is a **mandatory** dependency. Distance is always rounded up to the nearest integer metric.

## Example
If a load has:
- **Base Cost Adjustment**: 40 USD
- **Driver Tariff Adjustment**: 20 USD (50% of 40)
- **Calculation**: 40 + 20 = 60 USD

The **all_in_cost** Calculation:
`40 + 20 = 60 USD`
