import logging
from typing import Any

import httpx

logger = logging.getLogger(__name__)

BASE_MARGIN_SERVICE_URL = "http://base-margin-config:8003/base-margin-configs/resolve"
LEAD_TIME_SERVICE_URL = "http://lead-time-config:8004/lead-time-configs/resolve"


async def base_margin_config_task(
    customer: dict[str, Any], pickup: dict[str, Any], drop: dict[str, Any]
) -> dict[str, Any]:
    payload = {"customer": customer, "pickup": pickup, "drop": drop}
    async with httpx.AsyncClient() as client:
        response = await client.post(BASE_MARGIN_SERVICE_URL, json=payload, timeout=10.0)
        response.raise_for_status()
        result: dict[str, Any] = response.json()
        return result


async def lead_time_config_task(days_to_shipment: int) -> dict[str, Any]:
    payload = {"days_to_shipment": days_to_shipment}
    async with httpx.AsyncClient() as client:
        response = await client.post(LEAD_TIME_SERVICE_URL, json=payload, timeout=10.0)
        response.raise_for_status()
        result: dict[str, Any] = response.json()
        return result


def initial_base_margin(all_in_cost: float, base_margin_config: dict[str, Any]) -> float:
    margin_percent = float(base_margin_config.get("margin_percent", 0.0))
    if margin_percent >= 1.0:
        raise ValueError("margin_percent must be < 1.0 to avoid division by zero")
    return (float(all_in_cost) * margin_percent) / (1.0 - margin_percent)


def lead_time_adjustment(initial_base_margin: float, lead_time_config: dict[str, Any]) -> float:
    configuration_factor = lead_time_config.get("configuration_factor", 0.0)
    return initial_base_margin * float(configuration_factor)


def all_in_margin(initial_base_margin: float, lead_time_adjustment: float) -> float:
    return initial_base_margin + lead_time_adjustment
