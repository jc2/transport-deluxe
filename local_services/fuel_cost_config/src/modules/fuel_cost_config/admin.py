# mypy: ignore-errors

from sqladmin import ModelView
from wtforms.fields import SelectField

from src.modules.fuel_cost_config.models import FuelCostConfig, TruckType


class FuelCostConfigAdmin(ModelView, model=FuelCostConfig):
    column_list = [
        FuelCostConfig.uuid,
        FuelCostConfig.version,
        FuelCostConfig.customer_name,
        FuelCostConfig.customer_subname,
        FuelCostConfig.truck_type,
        FuelCostConfig.fuel_cost_per_km,
        FuelCostConfig.created_by,
        FuelCostConfig.created_at,
    ]
    form_columns = [
        FuelCostConfig.customer_name,
        FuelCostConfig.customer_subname,
        FuelCostConfig.truck_type,
        FuelCostConfig.fuel_cost_per_km,
    ]
    form_overrides = {"truck_type": SelectField}
    form_args = {"truck_type": {"choices": [(t.value, t.value) for t in TruckType]}}

    async def on_model_change(self, data, model, is_created, request):
        if is_created:
            from sqlalchemy import select

            async with self.session_maker() as session:
                stmt = select(FuelCostConfig).where(
                    FuelCostConfig.customer_name == data.get("customer_name"),
                    FuelCostConfig.customer_subname == data.get("customer_subname"),
                    FuelCostConfig.truck_type == data.get("truck_type"),
                )
                result = await session.execute(stmt)
                if result.first():
                    from fastapi import HTTPException

                    raise HTTPException(
                        status_code=400,
                        detail="A configuration for this combination already exists. Please update the existing one.",
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
        FuelCostConfig.customer_name,
        FuelCostConfig.customer_subname,
        FuelCostConfig.truck_type,
    ]
    # Removed column_filters temporarily as SQLModel attributes lack parameter_name in this version
    column_default_sort = ("created_at", True)
    name_plural = "Fuel Cost Configs"
    name = "Fuel Cost Config"
