.PHONY: up up-d test clean

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

# Remove all docker containers (both normal and test) along with networks
clean:
	docker compose -f docker-compose.yml -f docker-compose.test.yml --profile test down
