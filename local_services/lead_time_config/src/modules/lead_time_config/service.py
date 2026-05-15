import logging
import uuid as uuid_lib

from . import repo
from .exceptions import ConfigNotFoundError, InvalidConfigError, OverlappingConfigError
from .models import CreateRequest, LeadTimeConfig, LeadTimeConfigResponse, ResolveRequest, UpdateRequest

logger = logging.getLogger(__name__)


async def list_lead_time_configs(
    min_days: int | None = None,
    max_days: int | None = None,
) -> list[LeadTimeConfigResponse]:
    records = await repo.list_configs(min_days=min_days, max_days=max_days)
    return [LeadTimeConfigResponse.from_dao(r) for r in records]


async def get_lead_time_config(uuid_val: uuid_lib.UUID) -> LeadTimeConfigResponse:
    record = await repo.get_config(uuid_val)
    logger.info("get_lead_time_config found uuid=%s version=%s", uuid_val, record.version)
    return LeadTimeConfigResponse.from_dao(record)


async def create_lead_time_config(
    req: CreateRequest,
    created_by: str,
) -> LeadTimeConfigResponse:
    if await repo.check_overlap(min_days=req.min_days, max_days=req.max_days):
        raise OverlappingConfigError("An active configuration already exists that overlaps with this min/max range")

    dao = LeadTimeConfig(
        uuid=uuid_lib.uuid4(),
        version=1,
        min_days=req.min_days,
        max_days=req.max_days,
        configuration_factor=req.configuration_factor,
        created_by=created_by,
    )
    saved = await repo.save_config(dao)
    logger.info(
        "create_lead_time_config created uuid=%s rule=[%s, %s] created_by=%s",
        saved.uuid,
        req.min_days,
        req.max_days,
        created_by,
    )
    return LeadTimeConfigResponse.from_dao(saved)


async def update_lead_time_config(
    uuid_val: uuid_lib.UUID,
    req: UpdateRequest,
    created_by: str,
) -> LeadTimeConfigResponse:
    current = await repo.get_config(uuid_val)

    new_min_days: int = (
        req.min_days if ("min_days" in req.model_fields_set and req.min_days is not None) else current.min_days
    )
    new_max_days = req.max_days if "max_days" in req.model_fields_set else current.max_days
    new_configuration_factor = (
        req.configuration_factor if "configuration_factor" in req.model_fields_set else current.configuration_factor
    )

    if new_max_days is not None and new_min_days > new_max_days:
        raise InvalidConfigError("min_days cannot be greater than max_days")

    if new_min_days != current.min_days or new_max_days != current.max_days:
        if await repo.check_overlap(min_days=new_min_days, max_days=new_max_days, exclude_uuid=uuid_val):
            raise OverlappingConfigError("An active configuration already exists that overlaps with this min/max range")

    new_version = current.version + 1
    dao = LeadTimeConfig(
        uuid=uuid_val,
        version=new_version,
        min_days=new_min_days,
        max_days=new_max_days,
        configuration_factor=new_configuration_factor,
        created_by=created_by,
    )
    saved = await repo.save_config(dao)

    logger.info(
        "update_lead_time_config uuid=%s new_version=%s created_by=%s",
        uuid_val,
        new_version,
        created_by,
    )
    return LeadTimeConfigResponse.from_dao(saved)


async def delete_lead_time_config(uuid_val: uuid_lib.UUID) -> None:
    await repo.delete_config(uuid_val)


async def resolve_lead_time_config(req: ResolveRequest) -> LeadTimeConfigResponse:
    days = req.days_to_shipment
    active_configs = await repo.get_all_active_configs()

    match = None
    for config in active_configs:
        max_days = config.max_days if config.max_days is not None else float("inf")
        if config.min_days <= days <= max_days:
            match = config
            break

    if not match:
        logger.warning("resolve_lead_time_config found no match for days_to_shipment=%s", days)
        raise ConfigNotFoundError(f"No active lead time configuration found for {days} days to shipment.")

    logger.info("resolve_lead_time_config matched uuid=%s version=%s for days=%s", match.uuid, match.version, days)
    return LeadTimeConfigResponse.from_dao(match)
