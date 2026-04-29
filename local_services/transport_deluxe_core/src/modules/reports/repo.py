import uuid as uuid_lib

from sqlmodel import col, select
from sqlmodel.ext.asyncio.session import AsyncSession

from .models import BreakdownRow, CostingAudit, MarginAudit, PricingAudit


def _build_row(engine: str, row: CostingAudit | MarginAudit | PricingAudit) -> BreakdownRow:
    return BreakdownRow(
        engine=engine,
        correlation_id=row.correlation_id,
        step_name=row.step_name,
        step_type=row.step_type,
        input=row.input,
        output=row.output,
        timestamp=row.timestamp,
    )


async def get_breakdown(
    session: AsyncSession,
    correlation_id: uuid_lib.UUID,
    engines: list[str] | None = None,
    step_types: list[str] | None = None,
) -> list[BreakdownRow]:
    rows: list[BreakdownRow] = []
    active_engines = set(engines) if engines else {"costing", "margin", "pricing"}

    if "costing" in active_engines:
        costing_stmt = select(CostingAudit).where(CostingAudit.correlation_id == correlation_id)
        if step_types:
            costing_stmt = costing_stmt.where(col(CostingAudit.step_type).in_(step_types))
        costing_result = await session.exec(costing_stmt)
        rows.extend(_build_row("costing", row) for row in costing_result.all())

    if "margin" in active_engines:
        margin_stmt = select(MarginAudit).where(MarginAudit.correlation_id == correlation_id)
        if step_types:
            margin_stmt = margin_stmt.where(col(MarginAudit.step_type).in_(step_types))
        margin_result = await session.exec(margin_stmt)
        rows.extend(_build_row("margin", row) for row in margin_result.all())

    if "pricing" in active_engines:
        pricing_stmt = select(PricingAudit).where(PricingAudit.correlation_id == correlation_id)
        if step_types:
            pricing_stmt = pricing_stmt.where(col(PricingAudit.step_type).in_(step_types))
        pricing_result = await session.exec(pricing_stmt)
        rows.extend(_build_row("pricing", row) for row in pricing_result.all())

    rows.sort(key=lambda r: r.timestamp)
    return rows
