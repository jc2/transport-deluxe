# Costing Engine Service

Workflow service that calculates transport costs using Apache Hamilton and external Geocoding (Nominatim) and Routing (Valhalla) APIs.

## Logic Flow
This service orchestrates the following steps:
1. **Geocoding**: Converts pickup and drop ZIP codes to coordinates using Nominatim.
2. **Routing**: Calculates truck distance in km using Valhalla.
3. **Fuel Cost Lookup**: Calls the `fuel-cost-config` service to resolve the applicable fuel cost per km.
4. **Driver Tariff Lookup**: Calls the `driver-tariff-config` service to resolve the applicable driver pay factor.
5. **Adjustments**:
   - `Base Cost Adjustment = distance_km * fuel_cost_per_km`.
   - `Driver Tariff Adjustment = Base Cost Adjustment * tariff_factor`.
6. **Final Result**: `all_in_cost = Base Cost Adjustment + Driver Tariff Adjustment`.

## Audit System
Every execution is tracked in the `costing_audit` table. For each step in the Hamilton workflow, a row is saved containing:
- `correlation_id`: Provided in the `X-Correlation-ID` header.
- `step_name`: The name of the function in `steps.py`.
- `input`: JSON representation of inputs used by the step.
- `output`: JSON representation of the step result.
- `timestamp`: UTC time of execution.

The audit logs can be viewed in the [Admin Panel](http://localhost:8005/admin) in **read-only** mode.

## API Usage
### POST /costing/estimate
**Headers**:
- `Authorization: Bearer <JWT>`
- `X-Correlation-ID: <UUID>` (Mandatory)

**Body**:
```json
{
  "pickup_zip": "90210",
  "drop_zip": "10001",
  "customer": {
    "name": "GlobalLogistics",
    "subname": "Texas_Branch"
  },
  "truck_type": "reefer"
}
```
