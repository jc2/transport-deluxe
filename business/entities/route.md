# Route

A Route defines the geographic path between two points in the United States.

## Structure
A route consists of exactly two stops:
1. **Pickup**: The starting point.
2. **Drop**: The destination point.

## Mandatory Data (for both stops)
- City
- State
- Zipcode
- Country

## Distance
The distance of a route is calculated in **kilometers** using an external resource based on the Zipcodes of the Pickup and Drop stops.
