# Transport Deluxe

## Port Index

| Port | Service | Purpose |
|------|---------|---------|
| 8000 | Casdoor (Identity Provider / OAuth 2.0) | Authentication & authorization |
| 8001 | fuel-cost-config | Fuel Cost Configuration Management |
| 8002 | driver-tariff-config | Driver Tariff Configuration Management |
| 8003 | base-margin-config | Base Margin Configuration Management |

---

## Starting the stack

```bash
docker compose up
```

This starts Casdoor + its database, the `fuel-cost-config` service (at `http://localhost:8001`), the `driver-tariff-config` service (at `http://localhost:8002`), and the `base-margin-config` service (at `http://localhost:8003`), along with their respective databases.

To start only the identity services (useful during development):

```bash
docker compose up casdoor casdoor-db
```

---

## Running the tests

Integration tests run against separate dedicated test databases. They require Casdoor to be running in order to obtain real JWT tokens.

```bash
# Start Casdoor (if not already running)
docker compose up -d casdoor casdoor-db

# Run fuel-cost-config service tests
docker compose -f docker-compose.yml -f docker-compose.test.yml --profile test up --abort-on-container-exit fuel-cost-config-tests

# Run driver-tariff-config service tests
docker compose -f docker-compose.yml -f docker-compose.test.yml --profile test up --abort-on-container-exit driver-tariff-config-tests

# Run base-margin-config service tests
docker compose -f docker-compose.yml -f docker-compose.test.yml --profile test up --abort-on-container-exit base-margin-config-tests
```

The test containers exit with code 0 if all tests pass.

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

1. Ensure the application is running: `docker compose up`
2. Open your browser to:
   - **Fuel Cost Config**: [http://localhost:8001/admin](http://localhost:8001/admin)
   - **Driver Tariff Config**: [http://localhost:8002/admin](http://localhost:8002/admin)
   - **Base Margin Config**: [http://localhost:8003/admin](http://localhost:8003/admin)
3. Authenticate using Casdoor credentials. You must use an account that has the required config role (`cost-configurator` or `margin-configurator`).
   - **Example Cost Username**: `test-cost-configurator`
   - **Example Margin Username**: `test-margin-configurator`
   - **Example Password**: `test123`
