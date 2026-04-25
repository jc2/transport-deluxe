# Base Margin Configuration Service

Service for managing Base Margin configurations across the Transport Deluxe operation networks.

## Setup

This service runs inside Docker and requires Casdoor (Identity Provider) and Postgres (Database) from the main `docker-compose.yml`.

To bring it up alongside the entire infrastructure:
```bash
cd ..
docker compose up
```

## Running Tests

Tests run against an isolated postgres database in Docker Compose. To trigger tests:

```bash
docker compose -f docker-compose.yml -f docker-compose.test.yml build base-margin-config-tests
docker compose -f docker-compose.yml -f docker-compose.test.yml run --rm base-margin-config-tests pytest tests/ -v
```

## Admin UI

The built-in admin dashboard is available at `http://localhost:8003/admin`.
Authentication requires Casdoor credentials for users with the `margin-configurator` role. You can utilize the default test account:
- User: `test-margin-configurator`
- Pass: `test123`
