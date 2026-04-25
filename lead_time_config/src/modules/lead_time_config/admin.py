# mypy: ignore-errors

from sqladmin import ModelView

from src.modules.lead_time_config.models import LeadTimeConfig


class LeadTimeConfigAdmin(ModelView, model=LeadTimeConfig):
    column_list = [
        LeadTimeConfig.uuid,
        LeadTimeConfig.version,
        LeadTimeConfig.min_days,
        LeadTimeConfig.max_days,
        LeadTimeConfig.configuration_factor,
        LeadTimeConfig.created_by,
        LeadTimeConfig.created_at,
    ]
    form_columns = [
        LeadTimeConfig.min_days,
        LeadTimeConfig.max_days,
        LeadTimeConfig.configuration_factor,
    ]

    async def on_model_change(self, data, model, is_created, request):
        if is_created:
            from sqlalchemy import select

            async with self.session_maker() as session:
                stmt = select(LeadTimeConfig).where(
                    LeadTimeConfig.min_days == data.get("min_days"),
                    LeadTimeConfig.max_days == data.get("max_days"),
                )
                result = await session.execute(stmt)
                if result.first():
                    from fastapi import HTTPException

                    raise HTTPException(
                        status_code=400,
                        detail=(
                            "A configuration for this min/max days combination "
                            "already exists. Please update the existing one."
                        ),
                    )

            import uuid as uuid_lib

            data["uuid"] = uuid_lib.uuid4()
            data["version"] = 1
            admin_user = request.session.get("admin_user")
            if admin_user:
                data["created_by"] = admin_user

    async def update_model(self, request, pk: str, data: dict):
        from sqlalchemy.orm import selectinload

        stmt = self._stmt_by_identifier(pk)
        for relation in self._form_relations:
            stmt = stmt.options(selectinload(relation))

        async with self.session_maker(expire_on_commit=False) as session:
            result = await session.execute(stmt)
            old_obj = result.scalars().first()
            if not old_obj:
                return None

            new_data = {
                "uuid": old_obj.uuid,
                "version": old_obj.version + 1,
            }

            for field in self.form_columns:
                field_name = field if isinstance(field, str) else field.name
                new_data[field_name] = data.get(field_name, getattr(old_obj, field_name))

            admin_user = request.session.get("admin_user")
            if admin_user:
                new_data["created_by"] = admin_user

            new_obj = self.model(**new_data)
            session.add(new_obj)
            await session.commit()
            return new_obj

    column_searchable_list = [
        LeadTimeConfig.uuid,
        LeadTimeConfig.created_by,
    ]
    column_sortable_list = [
        LeadTimeConfig.uuid,
        LeadTimeConfig.version,
        LeadTimeConfig.min_days,
        LeadTimeConfig.max_days,
        LeadTimeConfig.created_at,
    ]
    column_default_sort = ("created_at", True)
    name_plural = "Lead Time Configurations"
    name = "Lead Time Configuration"
    icon = "fa-solid fa-clock"
