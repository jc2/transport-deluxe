# mypy: ignore-errors

from sqladmin import ModelView

from src.modules.driver_tariff_config.models import DriverTariffConfig


class DriverTariffConfigAdmin(ModelView, model=DriverTariffConfig):
    column_list = [
        DriverTariffConfig.uuid,
        DriverTariffConfig.version,
        DriverTariffConfig.pickup_state,
        DriverTariffConfig.drop_state,
        DriverTariffConfig.tariff_factor,
        DriverTariffConfig.created_by,
        DriverTariffConfig.created_at,
    ]
    form_columns = [
        DriverTariffConfig.pickup_state,
        DriverTariffConfig.drop_state,
        DriverTariffConfig.tariff_factor,
    ]

    async def on_model_change(self, data, model, is_created, request):
        if is_created:
            from sqlalchemy import select

            async with self.session_maker() as session:
                stmt = select(DriverTariffConfig).where(
                    DriverTariffConfig.pickup_state == data.get("pickup_state"),
                    DriverTariffConfig.drop_state == data.get("drop_state"),
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
        DriverTariffConfig.pickup_state,
        DriverTariffConfig.drop_state,
    ]
    column_default_sort = ("created_at", True)
    name_plural = "Driver Tariff Configs"
    name = "Driver Tariff Config"
