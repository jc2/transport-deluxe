# Transport Deluxe

## Port Index

| Port | Service | Purpose |
|------|---------|---------|
| 5432 | postgres | Unified PostgreSQL 16 instance (databases: `casdoor`, `transport_deluxe`, `transport_deluxe_test`) |
| 5050 | pgAdmin 4 | PostgreSQL web admin UI |
| 8000 | Casdoor (Identity Provider / OAuth 2.0) | Authentication & authorization |
| 8001 | fuel-cost-config | Fuel Cost Configuration Management |
| 8002 | driver-tariff-config | Driver Tariff Configuration Management |
| 8003 | base-margin-config | Base Margin Configuration Management |
| 8004 | lead-time-config | Lead Time Configuration Management |
| 8005 | costing-engine | Transport Costing Workflow Engine |
| 8006 | margin-engine | Margin Calculation Engine |
| 8007 | pricing-engine | Price Calculation Engine |


## External Services (Cloud APIs)
This project calculates truck routes distances in kilometers based on ZIP codes using cloud APIs:
1. **Nominatim OpenStreetMap API** for Geocoding (ZIP -> coordinates)
2. **Stadia Maps (Valhalla) API** for Routing (Coordinates -> distances)

Since these are cloud-based services, no local Docker containers or data downloads are required for routing.

To test the services via CLI:
* **Test Geocoding:** `uv run python scripts/test_nominatim.py 90210`
* **Test Routing:** `uv run python scripts/test_valhalla.py --lat1 34.0901 --lon1 -118.4065 --lat2 40.7488 --lon2 -73.9857`
* **Test Geocoding + Routing Combined:** `uv run python scripts/test_distance_service.py 90210 10001`

---

## Starting the stack

```bash
make up
```

This starts a unified PostgreSQL 16 instance (shared by all services), pgAdmin 4 (`http://localhost:5050`), Casdoor (`http://localhost:8000`), and all local services:
- `fuel-cost-config` at `http://localhost:8001`
- `driver-tariff-config` at `http://localhost:8002`
- `base-margin-config` at `http://localhost:8003`
- `lead-time-config` at `http://localhost:8004`
- `costing-engine` at `http://localhost:8005`
- `margin-engine` at `http://localhost:8006`
- `pricing-engine` at `http://localhost:8007`

To start the stack in detached mode:

```bash
make up-d
```

---

## Running the tests

Integration tests run against separate dedicated test databases. They require Casdoor to be running in order to obtain real JWT tokens.

```bash
make test
```

The test containers exit with code 0 if all tests pass.

## Stopping the stack and cleaning up

To stop and remove all docker containers (both normal and test):

```bash
make clean
```

---

## Authentication

Casdoor is the identity provider for this project. The admin console is available at `http://localhost:8000`.

Default admin credentials (change after first login):
- **Username**: `admin`
- **Password**: `123`

### Get a Test Token

Use the CLI script to generate a JWT for any role:

```bash
python scripts/get_token.py cost-configurator
python scripts/get_token.py margin-configurator
python scripts/get_token.py predictor
```

The JWT is printed to stdout. Requires `httpx`: `pip install httpx`.

### Verify a Test Token

You can verify a token's signature, issuer, audience, expiration, and extract its roles and user data using the verification script. Pass the token directly as an argument (for example, using command substitution):

```bash
python scripts/verify_token.py $(python scripts/get_token.py cost-configurator)
```

Requires `httpx` and `python-jose`: `pip install httpx python-jose`.

## Admin UI (SQLAdmin)

The services include an embedded SQLAdmin interface to manage configurations.

1. Ensure the application is running: `make up` (or `make up-d` for detached mode)
2. Open your browser to:
   - **Fuel Cost Config**: [http://localhost:8001/admin](http://localhost:8001/admin)
   - **Driver Tariff Config**: [http://localhost:8002/admin](http://localhost:8002/admin)
   - **Base Margin Config**: [http://localhost:8003/admin](http://localhost:8003/admin)
   - **Lead Time Config**: [http://localhost:8004/admin](http://localhost:8004/admin)
   - **Costing Engine**: [http://localhost:8005/admin](http://localhost:8005/admin)
   - **Margin Engine**: [http://localhost:8006/admin](http://localhost:8006/admin)
   - **Pricing Engine**: [http://localhost:8007/admin](http://localhost:8007/admin)
3. Authenticate using Casdoor credentials. You must use an account that has the required config role (`cost-configurator` or `margin-configurator`).
   - **Example Cost Username**: `test-cost-configurator`
   - **Example Margin Username**: `test-margin-configurator`
   - **Example Password**: `test123`

## pgAdmin 4

A pgAdmin 4 instance is included for database inspection.

1. Open [http://localhost:5050](http://localhost:5050)
2. Login with:
   - **Email**: `admin@transport-deluxe.com`
   - **Password**: `admin`
3. The server **transport-deluxe** (PostgreSQL on `postgres:5432`) is pre-configured and connects automatically.
4. Databases:
   - `casdoor` — Casdoor identity provider data
   - `transport_deluxe` — all local services, each in its own schema (`fuel_cost_config`, `driver_tariff_config`, `base_margin_config`, `lead_time_config`, `costing_engine`, `margin_engine`, `pricing_engine`)
   - `transport_deluxe_test` — same schema structure, used by integration tests
