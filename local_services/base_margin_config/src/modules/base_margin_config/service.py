import uuid as uuid_lib

from . import repo
from .exceptions import ConfigNotFoundError, DuplicateConfigError
from .models import BaseMarginConfig, BaseMarginConfigResponse, CreateRequest, ResolveRequest, Stop, UpdateRequest


def _flatten_request(
    req: CreateRequest | UpdateRequest,
) -> dict[str, str | None]:
    """Extract flat DB fields from a request DTO."""
    return {
        "customer_name": req.customer.name if req.customer else None,
        "customer_subname": req.customer.subname if req.customer else None,
        "pickup_country": req.pickup.country if req.pickup and req.pickup.country else None,
        "pickup_state": req.pickup.state if req.pickup and req.pickup.state else None,
        "pickup_city": req.pickup.city if req.pickup and req.pickup.city else None,
        "pickup_postal_code": req.pickup.postal_code if req.pickup and req.pickup.postal_code else None,
        "drop_country": req.drop.country if req.drop and req.drop.country else None,
        "drop_state": req.drop.state if req.drop and req.drop.state else None,
        "drop_city": req.drop.city if req.drop and req.drop.city else None,
        "drop_postal_code": req.drop.postal_code if req.drop and req.drop.postal_code else None,
    }


async def create_base_margin_config(req: CreateRequest, created_by: str = "admin") -> BaseMarginConfigResponse:
    fields = _flatten_request(req)

    count = await repo.count_matching(
        customer_name=fields["customer_name"],
        customer_subname=fields["customer_subname"],
        pickup_country=fields["pickup_country"],
        pickup_state=fields["pickup_state"],
        pickup_city=fields["pickup_city"],
        pickup_postal_code=fields["pickup_postal_code"],
        drop_country=fields["drop_country"],
        drop_state=fields["drop_state"],
        drop_city=fields["drop_city"],
        drop_postal_code=fields["drop_postal_code"],
    )
    if count > 0:
        raise DuplicateConfigError("A Base Margin Configuration already exists with these exact parameters.")

    dao = BaseMarginConfig(
        uuid=uuid_lib.uuid4(),
        version=1,
        **fields,
        margin_percent=req.margin_percent,
        created_by=created_by,
    )
    saved = await repo.save_config(dao)
    return BaseMarginConfigResponse.from_dao(saved)


async def list_base_margin_configs(
    customer_name: str | None = None,
    customer_subname: str | None = None,
    pickup_country: str | None = None,
    pickup_state: str | None = None,
    pickup_city: str | None = None,
    pickup_postal_code: str | None = None,
    drop_country: str | None = None,
    drop_state: str | None = None,
    drop_city: str | None = None,
    drop_postal_code: str | None = None,
) -> list[BaseMarginConfigResponse]:
    records = await repo.list_configs(
        customer_name=customer_name,
        customer_subname=customer_subname,
        pickup_country=pickup_country,
        pickup_state=pickup_state,
        pickup_city=pickup_city,
        pickup_postal_code=pickup_postal_code,
        drop_country=drop_country,
        drop_state=drop_state,
        drop_city=drop_city,
        drop_postal_code=drop_postal_code,
    )
    return [BaseMarginConfigResponse.from_dao(r) for r in records]


async def get_base_margin_config(uuid_val: uuid_lib.UUID) -> BaseMarginConfigResponse:
    record = await repo.get_config(uuid_val)
    return BaseMarginConfigResponse.from_dao(record)


async def update_base_margin_config(
    uuid_val: uuid_lib.UUID,
    req: UpdateRequest,
    created_by: str = "admin",
) -> BaseMarginConfigResponse:
    current = await repo.get_config(uuid_val)  # raises ConfigNotFoundError if missing

    fields = _flatten_request(req)

    count = await repo.count_matching(
        customer_name=fields["customer_name"],
        customer_subname=fields["customer_subname"],
        pickup_country=fields["pickup_country"],
        pickup_state=fields["pickup_state"],
        pickup_city=fields["pickup_city"],
        pickup_postal_code=fields["pickup_postal_code"],
        drop_country=fields["drop_country"],
        drop_state=fields["drop_state"],
        drop_city=fields["drop_city"],
        drop_postal_code=fields["drop_postal_code"],
        exclude_uuid=current.uuid,
    )
    if count > 0:
        raise DuplicateConfigError("A Base Margin Configuration already exists with these exact parameters.")

    new_dao = BaseMarginConfig(
        uuid=current.uuid,
        version=current.version + 1,
        **fields,
        margin_percent=req.margin_percent,
        created_by=created_by,
    )
    saved = await repo.save_config(new_dao)
    return BaseMarginConfigResponse.from_dao(saved)


async def delete_base_margin_config(uuid_val: uuid_lib.UUID) -> None:
    await repo.delete_config(uuid_val)  # raises ConfigNotFoundError if missing


async def resolve_base_margin_config(req: ResolveRequest) -> BaseMarginConfigResponse:
    all_configs = await repo.get_all_active_configs()

    c_name = req.customer.name if req.customer else None
    c_subname = req.customer.subname if req.customer else None
    req_p = req.pickup if req.pickup else Stop()
    req_d = req.drop if req.drop else Stop()

    valid_matches: list[BaseMarginConfig] = []

    for c in all_configs:
        match = True

        if c.customer_name is not None and c.customer_name != c_name:
            match = False
        if c.customer_subname is not None and (c_subname is None or c.customer_subname != c_subname):
            match = False

        if c.pickup_country is not None and c.pickup_country != "" and c.pickup_country != (req_p.country or ""):
            match = False
        if c.pickup_state is not None and c.pickup_state != "" and c.pickup_state != (req_p.state or ""):
            match = False
        if c.pickup_city is not None and c.pickup_city != "" and c.pickup_city != (req_p.city or ""):
            match = False
        if (
            c.pickup_postal_code is not None
            and c.pickup_postal_code != ""
            and c.pickup_postal_code != (req_p.postal_code or "")
        ):
            match = False

        if c.drop_country is not None and c.drop_country != "" and c.drop_country != (req_d.country or ""):
            match = False
        if c.drop_state is not None and c.drop_state != "" and c.drop_state != (req_d.state or ""):
            match = False
        if c.drop_city is not None and c.drop_city != "" and c.drop_city != (req_d.city or ""):
            match = False
        if (
            c.drop_postal_code is not None
            and c.drop_postal_code != ""
            and c.drop_postal_code != (req_d.postal_code or "")
        ):
            match = False

        if match:
            valid_matches.append(c)

    if not valid_matches:
        raise ConfigNotFoundError("No matching base margin configuration found for the given parameters.")

    def get_weight(c: BaseMarginConfig) -> int:
        weight = 0

        if c.customer_name is not None:
            weight += 100_000_000
        if c.customer_subname is not None:
            weight += 10_000_000

        has_pickup = any([c.pickup_country, c.pickup_state, c.pickup_city, c.pickup_postal_code])
        has_drop = any([c.drop_country, c.drop_state, c.drop_city, c.drop_postal_code])

        if has_pickup and has_drop:
            weight += 1_000_000
        elif has_pickup or has_drop:
            weight += 100_000

        if c.pickup_country is not None:
            weight += 1
        if c.pickup_state is not None:
            weight += 10
        if c.pickup_city is not None:
            weight += 100
        if c.pickup_postal_code is not None:
            weight += 1000

        if c.drop_country is not None:
            weight += 1
        if c.drop_state is not None:
            weight += 10
        if c.drop_city is not None:
            weight += 100
        if c.drop_postal_code is not None:
            weight += 1000

        return weight

    valid_matches.sort(key=get_weight, reverse=True)
    return BaseMarginConfigResponse.from_dao(valid_matches[0])
