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
    CostingAdjustment,
    CostingAudit,
    CostingRequest,
    CostingResponse,
    StepType,
)

logger = logging.getLogger(__name__)


async def run_costing_workflow(
    session: AsyncSession,
    request: CostingRequest,
    correlation_id: uuid_lib.UUID,
) -> CostingResponse:
    # 0. Check for existing correlation_id to prevent duplicate processing
    statement = select(CostingAudit).where(CostingAudit.correlation_id == correlation_id).limit(1)
    result = await session.exec(statement)
    if result.first():
        raise HTTPException(
            status_code=400, detail=f"Costing request with correlation_id {correlation_id} has already been processed."
        )

    # 1. Resolve External Dependencies (IO-Bound) explicitly
    # This circumvents Hamilton async orchestration issues in the current environment
    import asyncio

    # Run enrichment in parallel
    pickup_task = steps.pickup_coords(request.load.route.pickup.model_dump())
    drop_task = steps.drop_coords(request.load.route.drop.model_dump())

    pickup_coords, drop_coords = await asyncio.gather(pickup_task, drop_task)

    # Prepare enriched load for services that expect the full schema
    current_load_dict = request.load.model_dump()
    current_load_dict["route"]["pickup"]["latitude"] = pickup_coords["lat"]
    current_load_dict["route"]["pickup"]["longitude"] = pickup_coords["lon"]
    current_load_dict["route"]["drop"]["latitude"] = drop_coords["lat"]
    current_load_dict["route"]["drop"]["longitude"] = drop_coords["lon"]
    # Services expect 'ship_date' and 'route' structure
    full_load_for_resolve = {
        "route": {"pickup": current_load_dict["route"]["pickup"], "drop": current_load_dict["route"]["drop"]},
        "customer": current_load_dict["customer"],
        "truck_type": current_load_dict["truck_type"],
        "ship_date": request.load.ship_date.isoformat(),
    }

    fuel_task = steps.fuel_config(request.load.truck_type.value, request.load.customer.model_dump())
    tariff_task = steps.tariff_config(full_load_for_resolve)

    fuel_config, tariff_config = await asyncio.gather(fuel_task, tariff_task)

    # Resolve distance
    distance_km = await steps.distance_km(pickup_coords, drop_coords)

    # Update load objects with resolved coordinates and distance
    enriched_load = request.load.model_copy(deep=True)
    enriched_load.route.pickup.latitude = pickup_coords["lat"]
    enriched_load.route.pickup.longitude = pickup_coords["lon"]
    enriched_load.route.drop.latitude = drop_coords["lat"]
    enriched_load.route.drop.longitude = drop_coords["lon"]
    enriched_load.distance_km = distance_km

    # 2. Use Hamilton for Business Logic (CPU-Bound/Deterministic)
    inputs = {
        "distance_km": distance_km,
        "fuel_config": fuel_config,
        "tariff_config": tariff_config,
    }

    dr = driver.Driver(inputs, steps)

    # We execute only the logic steps
    logic_vars = ["base_cost_adjustment", "driver_tariff_adjustment", "all_in_cost"]
    logic_results = dr.execute(logic_vars)

    # 3. Consolidate results for Response and Auditing
    full_results = {
        "pickup_coords": pickup_coords,
        "drop_coords": drop_coords,
        "distance_km": distance_km,
        "fuel_config": fuel_config,
        "tariff_config": tariff_config,
        **logic_results,
    }

    # Log each step in audit table
    audit_vars = [
        "pickup_coords",
        "drop_coords",
        "distance_km",
        "fuel_config",
        "tariff_config",
        "base_cost_adjustment",
        "driver_tariff_adjustment",
        "all_in_cost",
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

        # Determine inputs and step type for this specific step
        step_input: dict[str, Any] = {}
        step_type: StepType = StepType.ENRICHING  # Default

        if step_name == "pickup_coords":
            step_input = {"pickup": request.load.route.pickup.model_dump()}
            step_type = StepType.ENRICHING
        elif step_name == "drop_coords":
            step_input = {"drop": request.load.route.drop.model_dump()}
            step_type = StepType.ENRICHING
        elif step_name == "distance_km":
            step_input = {"pickup_coords": pickup_coords, "drop_coords": drop_coords}
            step_type = StepType.ENRICHING
        elif step_name == "fuel_config":
            step_input = {"customer": request.load.customer.model_dump(), "truck_type": request.load.truck_type.value}
            step_type = StepType.FETCH_CONFIGURATION
        elif step_name == "tariff_config":
            step_input = {"load": full_load_for_resolve}
            step_type = StepType.FETCH_CONFIGURATION
        elif step_name == "base_cost_adjustment":
            step_input = {"distance_km": distance_km, "fuel_config": fuel_config}
            step_type = StepType.CALCULATE_ADJUSTMENT
        elif step_name == "driver_tariff_adjustment":
            step_input = {"base_cost_adjustment": full_results["base_cost_adjustment"], "tariff_config": tariff_config}
            step_type = StepType.CALCULATE_ADJUSTMENT
        elif step_name == "all_in_cost":
            step_input = {
                "base_cost_adjustment": full_results["base_cost_adjustment"],
                "driver_tariff_adjustment": full_results["driver_tariff_adjustment"],
            }
            step_type = StepType.EQUATION

        audit_entry = CostingAudit(
            correlation_id=correlation_id,
            step_name=step_name,
            step_type=step_type,
            input=clean_for_json(step_input),
            output=clean_for_json(output_val),
        )
        session.add(audit_entry)

    await session.commit()

    # Clean the response objects
    adj_base = clean_for_json(full_results["base_cost_adjustment"])
    adj_tariff = clean_for_json(full_results["driver_tariff_adjustment"])
    final_cost = clean_for_json(full_results["all_in_cost"])

    adjustments = [
        CostingAdjustment(**adj_base),
        CostingAdjustment(**adj_tariff),
    ]

    return CostingResponse(
        correlation_id=correlation_id,
        load=enriched_load,
        adjustments=adjustments,
        all_in_cost=Decimal(str(final_cost["amount"])),
    )
