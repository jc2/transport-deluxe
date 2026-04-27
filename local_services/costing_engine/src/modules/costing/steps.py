import logging
import math
import os
from decimal import Decimal
from typing import Any

import httpx
from dotenv import load_dotenv

load_dotenv()

logger = logging.getLogger(__name__)

NOMINATIM_URL = "https://nominatim.openstreetmap.org/search"
VALHALLA_URL = "https://api.stadiamaps.com/route/v1"
STADIA_API_KEY = os.getenv("STADIA_API_KEY")

# Configuration Service URLs (internal docker network)
FUEL_COST_SERVICE_URL = "http://fuel-cost-config:8001/fuel-cost-configs/resolve"
DRIVER_TARIFF_SERVICE_URL = "http://driver-tariff-config:8001/driver-tariff-configs/resolve"


async def pickup_coords(pickup: dict[str, Any]) -> dict[str, float]:
    headers = {"User-Agent": "TransportDeluxeApp/1.0"}
    query_params: dict[str, str | int] = {
        "postalcode": pickup["postal_code"],
        "city": pickup["city"],
        "state": pickup["state"],
        "country": pickup["country"],
        "format": "json",
        "limit": 1,
    }
    async with httpx.AsyncClient() as client:
        response = await client.get(NOMINATIM_URL, params=query_params, headers=headers, timeout=10.0)
        response.raise_for_status()
        data = response.json()
        if not data:
            raise ValueError(f"Coordinates not found for {pickup}")
        return {"lat": float(data[0]["lat"]), "lon": float(data[0]["lon"])}


async def drop_coords(drop: dict[str, Any]) -> dict[str, float]:
    headers = {"User-Agent": "TransportDeluxeApp/1.0"}
    query_params: dict[str, str | int] = {
        "postalcode": drop["postal_code"],
        "city": drop["city"],
        "state": drop["state"],
        "country": drop["country"],
        "format": "json",
        "limit": 1,
    }
    async with httpx.AsyncClient() as client:
        response = await client.get(NOMINATIM_URL, params=query_params, headers=headers, timeout=10.0)
        response.raise_for_status()
        data = response.json()
        if not data:
            raise ValueError(f"Coordinates not found for {drop}")
        return {"lat": float(data[0]["lat"]), "lon": float(data[0]["lon"])}


async def distance_km(pickup_coords: dict[str, float], drop_coords: dict[str, float]) -> float:
    params = {"api_key": STADIA_API_KEY}
    payload = {
        "locations": [pickup_coords, drop_coords],
        "costing": "truck",
        "units": "kilometers",
    }
    async with httpx.AsyncClient() as client:
        response = await client.post(
            VALHALLA_URL,
            params=params,
            json=payload,
            headers={"Content-Type": "application/json"},
            timeout=10.0,
        )
        response.raise_for_status()
        data = response.json()
        if "trip" in data and "summary" in data["trip"]:
            # Round up to the nearest integer metric as per business requirements
            # Casting to float for Hamilton type safety if needed
            return float(math.ceil(float(data["trip"]["summary"]["length"])))
        raise ValueError(f"Unexpected routing response format: {data}")


async def fuel_config(truck_type: str, customer: dict[str, Any]) -> dict[str, Any]:
    # ResolveRequest schema for fuel_cost_config: {"truck_type": str, "customer": {"name": str, "subname": str}}
    payload = {"truck_type": truck_type, "customer": {"name": customer.get("name"), "subname": customer.get("subname")}}
    async with httpx.AsyncClient() as client:
        response = await client.post(FUEL_COST_SERVICE_URL, json=payload, timeout=10.0)
        response.raise_for_status()
        result: dict[str, Any] = response.json()
        return result


async def tariff_config(load: dict[str, Any]) -> dict[str, Any]:
    # Driver Tariff resolve expects a ResolveRequest with a "load" field containing the Load object
    payload = {"load": load}
    async with httpx.AsyncClient() as client:
        response = await client.post(DRIVER_TARIFF_SERVICE_URL, json=payload, timeout=10.0)
        response.raise_for_status()
        result: dict[str, Any] = response.json()
        return result


def base_cost_adjustment(distance_km: float, fuel_config: dict[str, Any]) -> dict[str, Any]:
    fuel_cost_per_km = Decimal(str(fuel_config["fuel_cost_per_km"]))
    amount = Decimal(str(distance_km)) * fuel_cost_per_km
    return {
        "name": "Base Cost Adjustment (Fuel)",
        "amount": amount,
        "config_uuid": fuel_config["uuid"],
        "config_version": fuel_config["version"],
    }


def driver_tariff_adjustment(base_cost_adjustment: dict[str, Any], tariff_config: dict[str, Any]) -> dict[str, Any]:
    tariff_factor = Decimal(str(tariff_config["tariff_factor"]))
    amount = base_cost_adjustment["amount"] * tariff_factor
    return {
        "name": "Driver Tariff Adjustment",
        "amount": amount,
        "config_uuid": tariff_config["uuid"],
        "config_version": tariff_config["version"],
    }


def all_in_cost(base_cost_adjustment: dict[str, Any], driver_tariff_adjustment: dict[str, Any]) -> Decimal:
    result: Decimal = Decimal(str(base_cost_adjustment["amount"])) + Decimal(str(driver_tariff_adjustment["amount"]))
    return result
