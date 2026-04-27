from sqladmin import ModelView

from .models import MarginAudit


class MarginAuditAdmin(ModelView, model=MarginAudit):  # type: ignore[call-arg, misc]
    name = "Margin Audit"
    name_plural = "Margin Audits"
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
