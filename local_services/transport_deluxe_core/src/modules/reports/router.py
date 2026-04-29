import uuid as uuid_lib
from typing import Annotated

from fastapi import APIRouter, Depends, HTTPException, Query
from sqlmodel.ext.asyncio.session import AsyncSession

from ...tools.db import get_session
from .models import BreakdownResponse
from .service import get_report_breakdown

router = APIRouter(tags=["Reports"])

AsyncSessionDep = Annotated[AsyncSession, Depends(get_session)]

_VALID_ENGINES = {"costing", "margin", "pricing"}


@router.get("/breakdown/{correlation_id}", response_model=BreakdownResponse)
async def breakdown(
    correlation_id: Annotated[uuid_lib.UUID, "Correlation ID from engine workflow headers"],
    session: AsyncSessionDep,
    engine: Annotated[list[str] | None, Query(description="Filter by engine: costing, margin, pricing")] = None,
    step_type: Annotated[list[str] | None, Query(description="Filter by step_type value")] = None,
) -> BreakdownResponse:
    if engine:
        invalid = set(engine) - _VALID_ENGINES
        if invalid:
            raise HTTPException(
                status_code=400,
                detail={
                    "status": 400,
                    "messages": [f"Invalid engine(s): {sorted(invalid)}. Valid values: costing, margin, pricing"],
                },
            )

    result = await get_report_breakdown(session, correlation_id, engines=engine, step_types=step_type)
    if result is None:
        raise HTTPException(
            status_code=404,
            detail={"status": 404, "messages": [f"No audit records found for correlation_id {correlation_id}"]},
        )
    return result
