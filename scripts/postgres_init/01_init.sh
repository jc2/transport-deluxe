#!/usr/bin/env bash
# Runs inside the postgres:16 container on first startup via docker-entrypoint-initdb.d.
# Creates all databases and schemas for transport-deluxe.
set -euo pipefail

psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" <<-EOSQL
    CREATE DATABASE casdoor;
    CREATE DATABASE transport_deluxe;
    CREATE DATABASE transport_deluxe_test;
EOSQL

# Create schemas in transport_deluxe
psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "transport_deluxe" <<-EOSQL
    CREATE SCHEMA IF NOT EXISTS fuel_cost_config;
    CREATE SCHEMA IF NOT EXISTS driver_tariff_config;
    CREATE SCHEMA IF NOT EXISTS base_margin_config;
    CREATE SCHEMA IF NOT EXISTS lead_time_config;
    CREATE SCHEMA IF NOT EXISTS costing_engine;
    CREATE SCHEMA IF NOT EXISTS margin_engine;
    CREATE SCHEMA IF NOT EXISTS pricing_engine;
EOSQL

# Create the same schemas in the test database
psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "transport_deluxe_test" <<-EOSQL
    CREATE SCHEMA IF NOT EXISTS fuel_cost_config;
    CREATE SCHEMA IF NOT EXISTS driver_tariff_config;
    CREATE SCHEMA IF NOT EXISTS base_margin_config;
    CREATE SCHEMA IF NOT EXISTS lead_time_config;
    CREATE SCHEMA IF NOT EXISTS costing_engine;
    CREATE SCHEMA IF NOT EXISTS margin_engine;
    CREATE SCHEMA IF NOT EXISTS pricing_engine;
EOSQL
