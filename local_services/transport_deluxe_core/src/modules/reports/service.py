import uuid as uuid_lib

from sqlmodel.ext.asyncio.session import AsyncSession

from .models import BreakdownResponse
from .repo import get_breakdown


async def get_report_breakdown(
    session: AsyncSession,
    correlation_id: uuid_lib.UUID,
    engines: list[str] | None = None,
    step_types: list[str] | None = None,
) -> BreakdownResponse | None:
    rows = await get_breakdown(session, correlation_id, engines=engines, step_types=step_types)
    if not rows:
        return None
    return BreakdownResponse(correlation_id=correlation_id, rows=rows)
