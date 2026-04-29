.PHONY: up up-d test clean truncate-engines

# Build and bring up all normal docker containers without -d
up:
	docker compose up --build

# Build and bring up all normal docker containers with -d
up-d:
	docker compose up -d --build

# Build and run all test docker containers without -d
test:
	docker compose -f docker-compose.yml -f docker-compose.test.yml --profile test build
	docker compose -f docker-compose.yml -f docker-compose.test.yml --profile test run --rm fuel-cost-config-tests
	docker compose -f docker-compose.yml -f docker-compose.test.yml --profile test run --rm driver-tariff-config-tests
	docker compose -f docker-compose.yml -f docker-compose.test.yml --profile test run --rm base-margin-config-tests
	docker compose -f docker-compose.yml -f docker-compose.test.yml --profile test run --rm lead-time-config-tests
	docker compose -f docker-compose.yml -f docker-compose.test.yml --profile test run --rm costing-engine-tests
	docker compose -f docKer-compose.yml -f docker-compose.test.yml --profile test run --rm margin-engine-tests
	docker compose -f docker-compose.yml -f docker-compose.test.yml --profile test build pricing-engine-tests
	docker compose -f docker-compose.yml -f docker-compose.test.yml --profile test run --rm pricing-engine-tests
	docker compose -f docker-compose.yml -f docker-compose.test.yml --profile test run --rm transport-deluxe-core-tests
clean:
	docker compose -f docker-compose.yml -f docker-compose.test.yml --profile test down

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
		docker compose up -d postgres; \
		echo "Waiting for postgres to be ready..."; \
		until docker exec transport-deluxe-postgres-1 pg_isready -U postgres; do sleep 1; done; \
		docker exec transport-deluxe-postgres-1 pg_dumpall -U postgres -c > backup/postgres_dump.sql; \
		echo "Stopping postgres..."; \
		docker compose stop postgres; \
	else \
		docker exec transport-deluxe-postgres-1 pg_dumpall -U postgres -c > backup/postgres_dump.sql; \
	fi

# Restore the postgres databases from the backup folder
load-db:
	@RUNNING=$$(docker ps -q -f name=transport-deluxe-postgres-1); \
	if [ -z "$$RUNNING" ]; then \
		echo "Starting postgres temporarily..."; \
		docker compose up -d postgres; \
		echo "Waiting for postgres to be ready..."; \
		until docker exec transport-deluxe-postgres-1 pg_isready -U postgres; do sleep 1; done; \
		cat backup/postgres_dump.sql | docker exec -i transport-deluxe-postgres-1 psql -U postgres; \
		echo "Stopping postgres..."; \
		docker compose stop postgres; \
	else \
		cat backup/postgres_dump.sql | docker exec -i transport-deluxe-postgres-1 psql -U postgres; \
	fi
