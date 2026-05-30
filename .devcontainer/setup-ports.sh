#!/bin/bash
# Creates local proxies inside the devcontainer so that VS Code can forward
# those ports back to the user's machine.

# Ensure COMPOSE_PROJECT_NAME is persisted for all terminal sessions
echo "export COMPOSE_PROJECT_NAME=transport-deluxe" > /etc/profile.d/compose-project.sh
echo "COMPOSE_PROJECT_NAME=transport-deluxe" >> /etc/environment
export COMPOSE_PROJECT_NAME=transport-deluxe

# Install socat if not present
if ! command -v socat &>/dev/null; then
  apt-get update -qq && apt-get install -y socat -q
fi

# Kill any existing socat proxies
pkill socat 2>/dev/null || true

nohup socat TCP-LISTEN:8000,fork,reuseaddr TCP:casdoor:8000 >/dev/null 2>&1 &
nohup socat TCP-LISTEN:5050,fork,reuseaddr TCP:pgadmin:80 >/dev/null 2>&1 &
nohup socat TCP-LISTEN:8001,fork,reuseaddr TCP:fuel-cost-config:8001 >/dev/null 2>&1 &
nohup socat TCP-LISTEN:8002,fork,reuseaddr TCP:driver-tariff-config:8001 >/dev/null 2>&1 &
nohup socat TCP-LISTEN:8003,fork,reuseaddr TCP:base-margin-config:8003 >/dev/null 2>&1 &
nohup socat TCP-LISTEN:8004,fork,reuseaddr TCP:lead-time-config:8004 >/dev/null 2>&1 &
nohup socat TCP-LISTEN:8005,fork,reuseaddr TCP:costing-engine:8001 >/dev/null 2>&1 &
nohup socat TCP-LISTEN:8006,fork,reuseaddr TCP:margin-engine:8001 >/dev/null 2>&1 &
nohup socat TCP-LISTEN:8007,fork,reuseaddr TCP:pricing-engine:8001 >/dev/null 2>&1 &
nohup socat TCP-LISTEN:8008,fork,reuseaddr TCP:transport-deluxe-core:8008 >/dev/null 2>&1 &

disown
echo "Port proxies started."
