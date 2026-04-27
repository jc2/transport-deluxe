import logging
import uuid as uuid_lib
from datetime import datetime, timezone
from decimal import Decimal
from typing import Any

from fastapi import HTTPException
from hamilton import base, driver  # type: ignore[import-untyped]
from sqlmodel import select
from sqlmodel.ext.asyncio.session import AsyncSession

from . import steps
from .models import (
    MarginAdjustment,
    MarginAudit,
    MarginRequest,
    MarginResponse,
    StepType,
)

logger = logging.getLogger(__name__)


async def run_margin_workflow(
    session: AsyncSession,
    request: MarginRequest,
    correlation_id: uuid_lib.UUID,
) -> MarginResponse:
    # 0. Check for existing correlation_id
    statement = select(MarginAudit).where(MarginAudit.correlation_id == correlation_id).limit(1)
    result = await session.exec(statement)
    if result.first():
        raise HTTPException(
            status_code=400, detail=f"Margin request with correlation_id {correlation_id} has already been processed."
        )

    # 1. Resolve External Dependencies (IO-Bound) explicitly
    import asyncio

    ship_date = request.load.ship_date
    now = datetime.now(timezone.utc).date()
    days_to_shipment = (ship_date - now).days

    customer_dict = request.load.customer.model_dump()
    pickup_dict = request.load.route.pickup.model_dump()
    drop_dict = request.load.route.drop.model_dump()

    base_margin_task = steps.base_margin_config_task(customer_dict, pickup_dict, drop_dict)
    lead_time_task = steps.lead_time_config_task(days_to_shipment)

    base_margin_config, lead_time_config = await asyncio.gather(base_margin_task, lead_time_task)

    # 2. Use Hamilton for Business Logic (CPU-Bound/Deterministic)
    all_in_cost_float = float(request.all_in_cost)
    inputs = {
        "all_in_cost": all_in_cost_float,
        "base_margin_config": base_margin_config,
        "lead_time_config": lead_time_config,
    }

    adapter = base.SimplePythonGraphAdapter(base.DictResult())
    dr = driver.Driver(inputs, steps, adapter=adapter)

    logic_vars = ["initial_base_margin", "lead_time_adjustment", "all_in_margin"]
    logic_results = dr.execute(logic_vars)

    full_results = {
        "base_margin_config": base_margin_config,
        "lead_time_config": lead_time_config,
        **logic_results,
    }

    audit_vars = [
        "base_margin_config",
        "lead_time_config",
        "initial_base_margin",
        "lead_time_adjustment",
        "all_in_margin",
    ]

    def clean_for_json(obj: Any) -> Any:
        import numpy as np
        import pandas as pd

        if isinstance(obj, pd.Series):
            return clean_for_json(obj.to_dict())
        if isinstance(obj, pd.DataFrame):
            return [clean_for_json(r) for r in obj.to_dict(orient="records")]
        if isinstance(obj, (Decimal, np.float64, np.float32)):
            return float(obj)
        if isinstance(obj, (np.int64, np.int32)):
            return int(obj)
        if isinstance(obj, uuid_lib.UUID):
            return str(obj)
        if isinstance(obj, dict):
            return {str(k): clean_for_json(v) for k, v in obj.items()}
        if isinstance(obj, list):
            return [clean_for_json(x) for x in obj]
        return obj

    for step_name in audit_vars:
        output_val = full_results[step_name]

        step_input: dict[str, Any] = {}
        step_type: StepType = StepType.ENRICHING

        if step_name == "base_margin_config":
            step_input = {"customer": customer_dict, "pickup": pickup_dict, "drop": drop_dict}
            step_type = StepType.FETCH_CONFIGURATION
        elif step_name == "lead_time_config":
            step_input = {"days_to_shipment": days_to_shipment}
            step_type = StepType.FETCH_CONFIGURATION
        elif step_name == "initial_base_margin":
            step_input = {"all_in_cost": all_in_cost_float, "base_margin_config": base_margin_config}
            step_type = StepType.CALCULATE_ADJUSTMENT
        elif step_name == "lead_time_adjustment":
            step_input = {
                "initial_base_margin": logic_results["initial_base_margin"],
                "lead_time_config": lead_time_config,
            }
            step_type = StepType.CALCULATE_ADJUSTMENT
        elif step_name == "all_in_margin":
            step_input = {
                "initial_base_margin": logic_results["initial_base_margin"],
                "lead_time_adjustment": logic_results["lead_time_adjustment"],
            }
            step_type = StepType.EQUATION

        audit_entry = MarginAudit(
            correlation_id=correlation_id,
            step_name=step_name,
            step_type=step_type.value,
            input=clean_for_json(step_input),
            output=clean_for_json(output_val),
        )
        session.add(audit_entry)

    await session.commit()

    bm_uuid = base_margin_config.get("id")
    bm_version = base_margin_config.get("version")
    lt_uuid = lead_time_config.get("id")
    lt_version = lead_time_config.get("version")

    adjustments = [
        MarginAdjustment(
            name="initial_base_margin",
            amount=Decimal(str(logic_results["initial_base_margin"])),
            config_uuid=uuid_lib.UUID(bm_uuid) if bm_uuid else None,
            config_version=int(bm_version) if bm_version else None,
        ),
        MarginAdjustment(
            name="lead_time_adjustment",
            amount=Decimal(str(logic_results["lead_time_adjustment"])),
            config_uuid=uuid_lib.UUID(lt_uuid) if lt_uuid else None,
            config_version=int(lt_version) if lt_version else None,
        ),
    ]

    return MarginResponse(
        correlation_id=correlation_id,
        load=request.load,
        adjustments=adjustments,
        all_in_cost=request.all_in_cost,
        all_in_margin=Decimal(str(logic_results["all_in_margin"])),
    )
