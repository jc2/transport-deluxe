# Truck Type

Defines the physical characteristics and cost factors of the vehicles used for transporting cargo.

## Types
1. **Flatbed**: Open-body truck for oversized or odd-shaped cargo.
2. **Reefer**: Refrigerated truck for temperature-sensitive cargo.
3. **Dryvan**: Standard enclosed trailer for general freight.

## Margin Complexity Adjustment
Beyond the fuel factor, each truck type affects the margin through a specific configuration:
- **Factor**: A multiplier based on `truck_type`.
- **Distance Ranges**: The multiplier may vary depending on the distance ranges (strictly in **kilometers**).
- **Application**: This multiplier directly affects the **Base Margin**.
