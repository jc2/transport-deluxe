# mypy: ignore-errors
import uuid as uuid_lib

from fastapi import HTTPException
from sqladmin import ModelView
from sqlalchemy import select

from .models import BaseMarginConfig


class BaseMarginConfigAdmin(ModelView, model=BaseMarginConfig):
    column_list = [
        BaseMarginConfig.uuid,
        BaseMarginConfig.version,
        BaseMarginConfig.customer_name,
        BaseMarginConfig.customer_subname,
        BaseMarginConfig.pickup_country,
        BaseMarginConfig.pickup_state,
        BaseMarginConfig.pickup_city,
        BaseMarginConfig.pickup_postal_code,
        BaseMarginConfig.drop_country,
        BaseMarginConfig.drop_state,
        BaseMarginConfig.drop_city,
        BaseMarginConfig.drop_postal_code,
        BaseMarginConfig.margin_percent,
        BaseMarginConfig.created_by,
        BaseMarginConfig.created_at,
    ]
    form_columns = [
        BaseMarginConfig.customer_name,
        BaseMarginConfig.customer_subname,
        BaseMarginConfig.pickup_country,
        BaseMarginConfig.pickup_state,
        BaseMarginConfig.pickup_city,
        BaseMarginConfig.pickup_postal_code,
        BaseMarginConfig.drop_country,
        BaseMarginConfig.drop_state,
        BaseMarginConfig.drop_city,
        BaseMarginConfig.drop_postal_code,
        BaseMarginConfig.margin_percent,
    ]

    async def on_model_change(self, data, model, is_created, request):
        # Convert WTForms empty strings to None to properly trigger PostgreSQL NULLs
        for k, v in data.items():
            if v == "":
                data[k] = None

        if is_created:
            async with self.session_maker() as session:
                stmt = select(BaseMarginConfig).where(
                    BaseMarginConfig.customer_name == data.get("customer_name"),
                    BaseMarginConfig.customer_subname == data.get("customer_subname"),
                    BaseMarginConfig.pickup_country == data.get("pickup_country"),
                    BaseMarginConfig.pickup_state == data.get("pickup_state"),
                    BaseMarginConfig.pickup_city == data.get("pickup_city"),
                    BaseMarginConfig.pickup_postal_code == data.get("pickup_postal_code"),
                    BaseMarginConfig.drop_country == data.get("drop_country"),
                    BaseMarginConfig.drop_state == data.get("drop_state"),
                    BaseMarginConfig.drop_city == data.get("drop_city"),
                    BaseMarginConfig.drop_postal_code == data.get("drop_postal_code"),
                )
                result = await session.execute(stmt)
                if result.first():
                    raise HTTPException(
                        status_code=400,
                        detail="A configuration for this combination already exists. Please update the existing one.",
                    )

            # Assign primary keys directly like fuel_cost_config
            data["uuid"] = uuid_lib.uuid4()
            data["version"] = 1
            admin_user = request.session.get("admin_user")
            if admin_user:
                data["created_by"] = admin_user
            else:
                data["created_by"] = "admin"

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
                val = data.get(field_name, getattr(old_obj, field_name))
                new_data[field_name] = None if val == "" else val

            admin_user = request.session.get("admin_user")
            if admin_user:
                new_data["created_by"] = admin_user
            else:
                new_data["created_by"] = "admin"

            new_obj = self.model(**new_data)
            session.add(new_obj)
            await session.commit()
            return new_obj

    column_searchable_list = [
        BaseMarginConfig.customer_name,
        BaseMarginConfig.customer_subname,
        BaseMarginConfig.pickup_country,
        BaseMarginConfig.drop_country,
    ]
    column_default_sort = ("created_at", True)
    name_plural = "Base Margin Configs"
    name = "Base Margin Config"
