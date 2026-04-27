import uuid as uuid_lib
from typing import Annotated, Optional

from fastapi import APIRouter, Depends, Header, HTTPException
from sqlmodel.ext.asyncio.session import AsyncSession

from ...tools.db import get_session
from . import service
from .models import CostingRequest, CostingResponse

router = APIRouter()

SessionDep = Annotated[AsyncSession, Depends(get_session)]


@router.post("/estimate", response_model=CostingResponse)
async def estimate_cost(
    request: CostingRequest,
    session: SessionDep,
    x_correlation_id: Annotated[Optional[uuid_lib.UUID], Header()] = None,
) -> CostingResponse:
    if not x_correlation_id:
        raise HTTPException(
            status_code=400,
            detail={"status": 400, "messages": ["Missing X-Correlation-ID header"]},
        )

    try:
        return await service.run_costing_workflow(
            session=session,
            request=request,
            correlation_id=x_correlation_id,
        )
    except Exception as e:
        import logging

        logger = logging.getLogger(__name__)
        logger.error(f"Costing workflow failed: {e}", exc_info=True)
        raise HTTPException(
            status_code=500,
            detail={"status": 500, "messages": [str(e)]},
        )
