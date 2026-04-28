import logging
import uuid as uuid_lib
from decimal import Decimal
from typing import Any

from fastapi import HTTPException
from hamilton import driver  # type: ignore[import-untyped]
from sqlmodel import select
from sqlmodel.ext.asyncio.session import AsyncSession

from . import steps
from .models import (
    PricingAdjustment,
    PricingAudit,
    PricingRequest,
    PricingResponse,
    StepType,
)

logger = logging.getLogger(__name__)


async def process_pricing(
    session: AsyncSession,
    request: PricingRequest,
    correlation_id: uuid_lib.UUID,
) -> PricingResponse:
    # 0. Check for existing correlation_id to prevent duplicate processing
    statement = select(PricingAudit).where(PricingAudit.correlation_id == correlation_id).limit(1)
    result = await session.exec(statement)
    if result.first():
        raise HTTPException(
            status_code=400, detail=f"Pricing request with correlation_id {correlation_id} has already been processed."
        )

    # 1. Resolve External Dependencies (IO-Bound) explicitly
    # First call costing engine to get all_in_cost and enriched load
    correlation_id_str = str(correlation_id)
    costing_request_dict = {"load": request.load.model_dump(mode="json")}

    costing_res = await steps.costing_estimation(costing_request_dict, correlation_id_str)

    # Then call margin engine with the enriched load and all_in_cost
    margin_request_dict = {"load": costing_res.get("load"), "all_in_cost": costing_res.get("all_in_cost")}
    margin_res = await steps.margin_calculation(margin_request_dict, correlation_id_str)

    # 2. Use Hamilton for Business Logic (CPU-Bound/Deterministic)
    dr = driver.Builder().with_modules(steps).build()

    inputs = {
        "cost_estimation_result": costing_res,
        "margin_calculation_result": margin_res,
    }

    logic_vars = ["all_in_cost_adjustment", "all_in_margin_adjustment", "all_in_rate"]
    logic_results = dr.execute(logic_vars, inputs=inputs)

    # 3. Consolidate results for Response and Auditing
    full_results = {
        "costing_estimation": costing_res,
        "margin_calculation": margin_res,
        **logic_results,
    }

    # Log each step in audit table identical to costing_engine loop
    audit_vars = [
        "costing_estimation",
        "margin_calculation",
        "all_in_cost_adjustment",
        "all_in_margin_adjustment",
        "all_in_rate",
    ]

    def clean_for_json(obj: Any) -> Any:
        from decimal import Decimal

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
        step_type: StepType = StepType.ENRICHING  # Default

        if step_name == "costing_estimation":
            step_input = {"request_payload": costing_request_dict, "correlation_id": correlation_id_str}
            step_type = StepType.ENRICHING
        elif step_name == "margin_calculation":
            step_input = {"request_payload": margin_request_dict, "correlation_id": correlation_id_str}
            step_type = StepType.ENRICHING
        elif step_name == "all_in_cost_adjustment":
            step_input = {"cost_estimation_result": costing_res}
            step_type = StepType.CALCULATE_ADJUSTMENT
        elif step_name == "all_in_margin_adjustment":
            step_input = {"margin_calculation_result": margin_res}
            step_type = StepType.CALCULATE_ADJUSTMENT
        elif step_name == "all_in_rate":
            step_input = {
                "all_in_cost_adjustment": full_results["all_in_cost_adjustment"],
                "all_in_margin_adjustment": full_results["all_in_margin_adjustment"],
            }
            step_type = StepType.EQUATION

        audit_entry = PricingAudit(
            correlation_id=correlation_id,
            step_name=step_name,
            step_type=step_type,
            input=clean_for_json(step_input),
            output=clean_for_json(output_val),
        )
        session.add(audit_entry)

    await session.commit()

    # Clean the response objects exactly like costing_engine
    adj_cost = clean_for_json(full_results["all_in_cost_adjustment"])
    adj_margin = clean_for_json(full_results["all_in_margin_adjustment"])
    final_rate = clean_for_json(full_results["all_in_rate"])

    adjustments = [
        PricingAdjustment(**adj_cost),
        PricingAdjustment(**adj_margin),
    ]

    all_in_cost = Decimal(str(adj_cost["amount"]))
    all_in_margin = Decimal(str(adj_margin["amount"]))

    return PricingResponse(
        correlation_id=correlation_id,
        load=request.load,
        adjustments=adjustments,
        all_in_cost=all_in_cost,
        all_in_margin=all_in_margin,
        all_in_rate=Decimal(str(final_rate)),
    )
