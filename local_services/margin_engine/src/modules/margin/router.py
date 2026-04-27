import uuid as uuid_lib
from typing import Annotated, Optional

from fastapi import APIRouter, Depends, Header, HTTPException
from sqlmodel.ext.asyncio.session import AsyncSession

from ...tools.db import get_session
from . import service
from .models import MarginRequest, MarginResponse

router = APIRouter()

SessionDep = Annotated[AsyncSession, Depends(get_session)]


@router.post("/estimate", response_model=MarginResponse)
async def estimate_cost(
    request: MarginRequest,
    session: SessionDep,
    x_correlation_id: Annotated[Optional[uuid_lib.UUID], Header()] = None,
) -> MarginResponse:
    if not x_correlation_id:
        raise HTTPException(
            status_code=400,
            detail={"status": 400, "messages": ["Missing X-Correlation-ID header"]},
        )

    try:
        return await service.run_margin_workflow(
            session=session,
            request=request,
            correlation_id=x_correlation_id,
        )
    except Exception as e:
        import logging

        logger = logging.getLogger(__name__)
        logger.error(f"Margin workflow failed: {e}", exc_info=True)
        raise HTTPException(
            status_code=500,
            detail={"status": 500, "messages": [str(e)]},
        )
