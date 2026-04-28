import logging
import os
from decimal import Decimal
from typing import Any

import httpx

logger = logging.getLogger(__name__)

COSTING_ENGINE_URL = os.getenv("COSTING_ENGINE_URL", "http://costing-engine:8001/costing/estimate")
MARGIN_ENGINE_URL = os.getenv("MARGIN_ENGINE_URL", "http://margin-engine:8001/margin/estimate")


async def costing_estimation(request_payload: dict[str, Any], correlation_id: str) -> dict[str, Any]:
    headers = {"x-correlation-id": correlation_id}
    async with httpx.AsyncClient() as client:
        response = await client.post(COSTING_ENGINE_URL, json=request_payload, headers=headers, timeout=30.0)
        response.raise_for_status()
        result: dict[str, Any] = response.json()
        return result


async def margin_calculation(request_payload: dict[str, Any], correlation_id: str) -> dict[str, Any]:
    headers = {"x-correlation-id": correlation_id}
    async with httpx.AsyncClient() as client:
        response = await client.post(MARGIN_ENGINE_URL, json=request_payload, headers=headers, timeout=30.0)
        response.raise_for_status()
        result: dict[str, Any] = response.json()
        return result


def all_in_cost_adjustment(cost_estimation_result: dict[str, Any]) -> dict[str, Any]:
    amount = Decimal(str(cost_estimation_result.get("all_in_cost", "0.0")))
    return {
        "name": "All In Cost Adjustment",
        "amount": amount,
        "config_uuid": None,
        "config_version": None,
    }


def all_in_margin_adjustment(margin_calculation_result: dict[str, Any]) -> dict[str, Any]:
    amount = Decimal(str(margin_calculation_result.get("all_in_margin", "0.0")))
    return {
        "name": "All In Margin Adjustment",
        "amount": amount,
        "config_uuid": None,
        "config_version": None,
    }


def all_in_rate(all_in_cost_adjustment: dict[str, Any], all_in_margin_adjustment: dict[str, Any]) -> Decimal:
    cost_amt = Decimal(str(all_in_cost_adjustment["amount"]))
    margin_amt = Decimal(str(all_in_margin_adjustment["amount"]))
    amount = cost_amt + margin_amt
    return amount
