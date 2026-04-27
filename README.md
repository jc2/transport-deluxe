# Transport Deluxe

## Port Index

| Port | Service | Purpose |
|------|---------|---------|
| 8000 | Casdoor (Identity Provider / OAuth 2.0) | Authentication & authorization |
| 8001 | fuel-cost-config | Fuel Cost Configuration Management |
| 8002 | driver-tariff-config | Driver Tariff Configuration Management |
| 8003 | base-margin-config | Base Margin Configuration Management |
| 8004 | lead-time-config | Lead Time Configuration Management |
| 8005 | costing-engine | Transport Costing Workflow Engine |


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

This starts Casdoor + its database, the `fuel-cost-config` service (at `http://localhost:8001`), the `driver-tariff-config` service (at `http://localhost:8002`), the `base-margin-config` service (at `http://localhost:8003`), and the `lead-time-config` service (at `http://localhost:8004`), along with their respective databases.

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
3. Authenticate using Casdoor credentials. You must use an account that has the required config role (`cost-configurator` or `margin-configurator`).
   - **Example Cost Username**: `test-cost-configurator`
   - **Example Margin Username**: `test-margin-configurator`
   - **Example Password**: `test123`
