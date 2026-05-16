import logging
import uuid as uuid_lib

from . import repo
from .exceptions import ConfigNotFoundError, DuplicateConfigError
from .models import CreateRequest, FuelCostConfig, FuelCostConfigResponse, ResolveRequest, UpdateRequest

logger = logging.getLogger(__name__)


async def create_fuel_cost_config(req: CreateRequest, created_by: str = "admin") -> FuelCostConfigResponse:
    customer_name = req.customer.name if req.customer else None
    customer_subname = req.customer.subname if req.customer else None
    truck_type = req.truck_type.value

    count = await repo.count_matching(
        customer_name=customer_name,
        customer_subname=customer_subname,
        truck_type=truck_type,
    )
    if count > 0:
        raise DuplicateConfigError("A Fuel Cost Configuration already exists with these exact parameters.")

    dao = FuelCostConfig(
        uuid=uuid_lib.uuid4(),
        version=1,
        customer_name=customer_name,
        customer_subname=customer_subname,
        truck_type=truck_type,
        fuel_cost_per_km=req.fuel_cost_per_km,
        created_by=created_by,
    )
    saved = await repo.save_config(dao)
    logger.info(
        "create_fuel_cost_config uuid=%s truck_type=%s created_by=%s",
        saved.uuid,
        saved.truck_type,
        created_by,
    )
    return FuelCostConfigResponse.from_dao(saved)


async def list_fuel_cost_configs(
    customer_name: str | None = None,
    customer_subname: str | None = None,
    truck_type: str | None = None,
) -> list[FuelCostConfigResponse]:
    records = await repo.list_configs(
        customer_name=customer_name,
        customer_subname=customer_subname,
        truck_type=truck_type,
    )
    return [FuelCostConfigResponse.from_dao(r) for r in records]


async def get_fuel_cost_config(uuid_val: uuid_lib.UUID) -> FuelCostConfigResponse:
    record = await repo.get_config(uuid_val)
    return FuelCostConfigResponse.from_dao(record)


async def update_fuel_cost_config(
    uuid_val: uuid_lib.UUID,
    req: UpdateRequest,
    created_by: str = "admin",
) -> FuelCostConfigResponse:
    current = await repo.get_config(uuid_val)  # raises ConfigNotFoundError if missing

    new_row = FuelCostConfig(
        uuid=uuid_val,
        version=current.version + 1,
        customer_name=current.customer_name,
        customer_subname=current.customer_subname,
        truck_type=current.truck_type,
        fuel_cost_per_km=req.fuel_cost_per_km,
        created_by=created_by,
    )
    saved = await repo.save_config(new_row)
    logger.info(
        "update_fuel_cost_config uuid=%s new_version=%s created_by=%s",
        uuid_val,
        saved.version,
        created_by,
    )
    return FuelCostConfigResponse.from_dao(saved)


async def delete_fuel_cost_config(uuid_val: uuid_lib.UUID) -> None:
    await repo.delete_config(uuid_val)
    logger.info("delete_fuel_cost_config uuid=%s", uuid_val)


async def resolve_fuel_cost_config(req: ResolveRequest) -> FuelCostConfigResponse:
    c_name = req.customer.name if req.customer else None
    c_subname = req.customer.subname if req.customer else None
    truck_type = req.truck_type.value

    all_configs = await repo.get_all_active_configs()

    valid_matches: list[FuelCostConfig] = []
    for c in all_configs:
        if c.truck_type != truck_type:
            continue
        if c.customer_name is not None and c.customer_name != c_name:
            continue
        if c.customer_subname is not None and (c_subname is None or c.customer_subname != c_subname):
            continue
        valid_matches.append(c)

    if not valid_matches:
        raise ConfigNotFoundError(
            f"No fuel cost configuration found for truck_type={truck_type}, customer={c_name}/{c_subname}."
        )

    def get_specificity(c: FuelCostConfig) -> int:
        weight = 0
        if c.customer_name is not None:
            weight += 10
        if c.customer_subname is not None:
            weight += 1
        return weight

    best = max(valid_matches, key=lambda c: (get_specificity(c), c.version))
    logger.info("resolve_fuel_cost_config matched uuid=%s version=%s", best.uuid, best.version)
    return FuelCostConfigResponse.from_dao(best)
