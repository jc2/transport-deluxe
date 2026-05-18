import logging
import uuid as uuid_lib

from . import repo
from .exceptions import ConfigNotFoundError, DuplicateConfigError
from .models import CreateRequest, DriverTariffConfig, DriverTariffConfigResponse, ResolveRequest, UpdateRequest

logger = logging.getLogger(__name__)


async def create_driver_tariff_config(req: CreateRequest, created_by: str = "admin") -> DriverTariffConfigResponse:
    count = await repo.count_matching(
        pickup_state=req.pickup_state,
        drop_state=req.drop_state,
    )
    if count > 0:
        raise DuplicateConfigError(
            "A Driver Tariff Configuration already exists for this pickup and drop state combination."
        )

    dao = DriverTariffConfig(
        uuid=uuid_lib.uuid4(),
        version=1,
        pickup_state=req.pickup_state,
        drop_state=req.drop_state,
        tariff_factor=req.tariff_factor,
        created_by=created_by,
    )
    saved = await repo.save_config(dao)
    logger.info(
        "create_driver_tariff_config uuid=%s pickup=%s drop=%s created_by=%s",
        saved.uuid,
        saved.pickup_state,
        saved.drop_state,
        created_by,
    )
    return DriverTariffConfigResponse.from_dao(saved)


async def list_driver_tariff_configs(
    pickup_state: str | None = None,
    drop_state: str | None = None,
) -> list[DriverTariffConfigResponse]:
    records = await repo.list_configs(
        pickup_state=pickup_state,
        drop_state=drop_state,
    )
    return [DriverTariffConfigResponse.from_dao(r) for r in records]


async def get_driver_tariff_config(uuid_val: uuid_lib.UUID) -> DriverTariffConfigResponse:
    record = await repo.get_config(uuid_val)
    return DriverTariffConfigResponse.from_dao(record)


async def update_driver_tariff_config(
    uuid_val: uuid_lib.UUID,
    req: UpdateRequest,
    created_by: str = "admin",
) -> DriverTariffConfigResponse:
    current = await repo.get_config(uuid_val)  # raises ConfigNotFoundError if missing

    new_row = DriverTariffConfig(
        uuid=uuid_val,
        version=current.version + 1,
        pickup_state=current.pickup_state,
        drop_state=current.drop_state,
        tariff_factor=req.tariff_factor,
        created_by=created_by,
    )
    saved = await repo.save_config(new_row)
    logger.info(
        "update_driver_tariff_config uuid=%s new_version=%s created_by=%s",
        uuid_val,
        saved.version,
        created_by,
    )
    return DriverTariffConfigResponse.from_dao(saved)


async def delete_driver_tariff_config(uuid_val: uuid_lib.UUID) -> None:
    await repo.delete_config(uuid_val)
    logger.info("delete_driver_tariff_config uuid=%s", uuid_val)


async def resolve_driver_tariff_config(req: ResolveRequest) -> DriverTariffConfigResponse:
    pickup_state = req.load.route.pickup.state
    drop_state = req.load.route.drop.state

    all_configs = await repo.get_all_active_configs()

    # A config is a candidate if its specific states match the request,
    # or if a state is None (wildcard).
    valid_matches: list[DriverTariffConfig] = []
    for c in all_configs:
        if c.pickup_state is not None and c.pickup_state != pickup_state:
            continue
        if c.drop_state is not None and c.drop_state != drop_state:
            continue
        valid_matches.append(c)

    if not valid_matches:
        logger.warning(
            "resolve_driver_tariff_config found no match for %s -> %s",
            pickup_state,
            drop_state,
        )
        raise ConfigNotFoundError(f"No driver tariff configuration found for route {pickup_state} -> {drop_state}.")

    def get_specificity(c: DriverTariffConfig) -> int:
        # Higher = more specific = wins
        has_pickup = c.pickup_state is not None
        has_drop = c.drop_state is not None
        if has_pickup and has_drop:
            return 4  # exact route match
        elif has_pickup:
            return 3  # origin default
        elif has_drop:
            return 2  # destination default
        else:
            return 1  # global fallback

    best = max(valid_matches, key=lambda c: (get_specificity(c), c.version))
    logger.info(
        "resolve_driver_tariff_config matched uuid=%s version=%s for %s -> %s",
        best.uuid,
        best.version,
        pickup_state,
        drop_state,
    )
    return DriverTariffConfigResponse.from_dao(best)
