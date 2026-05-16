.PHONY: up up-d test clean truncate-engines \
	test-lead-time-config test-fuel-cost-config test-driver-tariff-config \
	test-base-margin-config test-costing-engine test-margin-engine \
	test-pricing-engine test-transport-deluxe-core

# Build and bring up all normal docker containers without -d
up:
	docker-compose up --build

# Build and bring up all normal docker containers with -d
up-d:
	docker-compose up -d --build

# Build and run all test docker containers without -d
test:
	docker-compose -f docker-compose.yml -f docker-compose.test.yml --profile test build
	docker-compose -f docker-compose.yml -f docker-compose.test.yml --profile test run --rm lead-time-config-tests
	docker-compose -f docker-compose.yml -f docker-compose.test.yml --profile test run --rm fuel-cost-config-tests
	docker-compose -f docker-compose.yml -f docker-compose.test.yml --profile test run --rm driver-tariff-config-tests
	docker-compose -f docker-compose.yml -f docker-compose.test.yml --profile test run --rm base-margin-config-tests
	docker-compose -f docker-compose.yml -f docker-compose.test.yml --profile test run --rm costing-engine-tests
	docker-compose -f docKer-compose.yml -f docker-compose.test.yml --profile test run --rm margin-engine-tests
	docker-compose -f docker-compose.yml -f docker-compose.test.yml --profile test build pricing-engine-tests
	docker-compose -f docker-compose.yml -f docker-compose.test.yml --profile test run --rm pricing-engine-tests
	docker-compose -f docker-compose.yml -f docker-compose.test.yml --profile test run --rm transport-deluxe-core-tests
clean:
	docker-compose -f docker-compose.yml -f docker-compose.test.yml --profile test down

# Test individual services
test-lead-time-config:
	docker-compose -f docker-compose.yml -f docker-compose.test.yml --profile test build lead-time-config-tests
	docker-compose -f docker-compose.yml -f docker-compose.test.yml --profile test run --rm lead-time-config-tests

test-fuel-cost-config:
	docker-compose -f docker-compose.yml -f docker-compose.test.yml --profile test build fuel-cost-config-tests
	docker-compose -f docker-compose.yml -f docker-compose.test.yml --profile test run --rm fuel-cost-config-tests

test-driver-tariff-config:
	docker-compose -f docker-compose.yml -f docker-compose.test.yml --profile test build driver-tariff-config-tests
	docker-compose -f docker-compose.yml -f docker-compose.test.yml --profile test run --rm driver-tariff-config-tests

test-base-margin-config:
	docker-compose -f docker-compose.yml -f docker-compose.test.yml --profile test build base-margin-config-tests
	docker-compose -f docker-compose.yml -f docker-compose.test.yml --profile test run --rm base-margin-config-tests

test-costing-engine:
	docker-compose -f docker-compose.yml -f docker-compose.test.yml --profile test build costing-engine-tests
	docker-compose -f docker-compose.yml -f docker-compose.test.yml --profile test run --rm costing-engine-tests

test-margin-engine:
	docker-compose -f docker-compose.yml -f docker-compose.test.yml --profile test build margin-engine-tests
	docker-compose -f docker-compose.yml -f docker-compose.test.yml --profile test run --rm margin-engine-tests

test-pricing-engine:
	docker-compose -f docker-compose.yml -f docker-compose.test.yml --profile test build pricing-engine-tests
	docker-compose -f docker-compose.yml -f docker-compose.test.yml --profile test run --rm pricing-engine-tests

test-transport-deluxe-core:
	docker-compose -f docker-compose.yml -f docker-compose.test.yml --profile test build transport-deluxe-core-tests
	docker-compose -f docker-compose.yml -f docker-compose.test.yml --profile test run --rm transport-deluxe-core-tests

reset-casdoor:
	docker-compose stop casdoor
	docker-compose exec postgres psql -U postgres -c "DROP DATABASE IF EXISTS casdoor;"
	docker-compose exec postgres psql -U postgres -c "CREATE DATABASE casdoor;"
	docker-compose start casdoor

# Truncate all audit/result tables in the engine schemas (costing, margin, pricing).
# Config tables (fuel_cost_config, driver_tariff_config, etc.) are NOT affected.
truncate-engines:
	docker exec transport-deluxe-postgres-1 psql -U postgres -d transport_deluxe -c "\
		TRUNCATE costing_engine.costing_audit RESTART IDENTITY CASCADE; \
		TRUNCATE margin_engine.margin_audit RESTART IDENTITY CASCADE; \
		TRUNCATE pricing_engine.pricing_audit RESTART IDENTITY CASCADE; \
	"

# Dump all postgres databases to the backup folder
dump-db:
	@RUNNING=$$(docker ps -q -f name=transport-deluxe-postgres-1); \
	if [ -z "$$RUNNING" ]; then \
		echo "Starting postgres temporarily..."; \
		docker-compose up -d postgres; \
		echo "Waiting for postgres to be ready..."; \
		until docker exec transport-deluxe-postgres-1 pg_isready -U postgres; do sleep 1; done; \
		docker exec transport-deluxe-postgres-1 pg_dumpall -U postgres -c > backup/postgres_dump.sql; \
		echo "Stopping postgres..."; \
		docker-compose stop postgres; \
	else \
		docker exec transport-deluxe-postgres-1 pg_dumpall -U postgres -c > backup/postgres_dump.sql; \
	fi

# Restore the postgres databases from the backup folder
load-db:
	@RUNNING=$$(docker ps -q -f name=transport-deluxe-postgres-1); \
	if [ -z "$$RUNNING" ]; then \
		echo "Starting postgres temporarily..."; \
		docker-compose up -d postgres; \
		echo "Waiting for postgres to be ready..."; \
		until docker exec transport-deluxe-postgres-1 pg_isready -U postgres; do sleep 1; done; \
		cat backup/postgres_dump.sql | docker exec -i transport-deluxe-postgres-1 psql -U postgres; \
		echo "Stopping postgres..."; \
		docker-compose stop postgres; \
	else \
		cat backup/postgres_dump.sql | docker exec -i transport-deluxe-postgres-1 psql -U postgres; \
	fi
