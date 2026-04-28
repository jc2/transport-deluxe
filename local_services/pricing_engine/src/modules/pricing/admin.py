from sqladmin import ModelView

from .models import PricingAudit


class PricingAuditAdmin(ModelView, model=PricingAudit):  # type: ignore[call-arg, misc]
    name = "Pricing Audit"
    name_plural = "Pricing Audits"
    icon = "fa-solid fa-receipt"
    column_list = [
        "id",
        "correlation_id",
        "step_name",
        "step_type",
        "input",
        "output",
        "timestamp",
    ]
    column_searchable_list = ["correlation_id", "step_name", "step_type"]
    column_details_list = [
        "id",
        "correlation_id",
        "step_name",
        "step_type",
        "input",
        "output",
        "timestamp",
    ]
    can_create = False
    can_edit = False
    can_delete = False
    can_view_details = True
