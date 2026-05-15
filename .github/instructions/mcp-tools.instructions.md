---
description: "Use when adding, modifying or reviewing MCP tools in any service (configuration or workflow engine). Covers FastMCP setup, tool anatomy, parameter annotations, error handling, service delegation, authentication, and MCP testing with fastmcp.Client."
---

# MCP Tool Implementation Conventions

## Core Principle: MCP is just another interface

MCP tools are **not** a separate layer of business logic. They are a second interface into the same `service.py` functions that the HTTP REST endpoints use. The stack looks like this:

```
HTTP REST client  →  router.py    ─┐
                                    ├──→  service.py  →  repo.py  →  database
MCP agent         →  mcp_tools.py  ┘
```

`mcp_tools.py` MUST NOT contain SQL queries, business rules, or any logic that duplicates what `service.py` already does. If you find yourself re-implementing logic in a tool, move it to `service.py` instead.

**Session management**: MCP tools do NOT open database sessions. They call `service.*` functions directly, which delegate to `repo.*` functions that manage their own sessions via `get_db_session()`. No `AsyncSession` in `mcp_tools.py`.

Every configuration service MUST expose a full set of MCP tools.
Workflow engines MAY expose read-only tools for inspecting audit data.

## 1. File Organisation

```text
modules/{domain}/
├── mcp_server.py      # mcp = FastMCP("Human-readable name", auth=get_mcp_auth())  — nothing else
└── mcp_tools.py       # All @mcp.tool decorated functions
```

`main.py` imports `mcp_tools` as a side effect to trigger tool registration:

```python
import src.modules.{domain}.mcp_tools  # noqa: F401    ← registers tools
from src.modules.{domain}.mcp_server import mcp

mcp_app = mcp.http_app(path="/mcp", transport="streamable-http")
app = FastAPI(lifespan=combine_lifespans(lifespan, mcp_app.lifespan))
app.mount("/", mcp_app)
```

## 2. Tool Annotations

Every tool MUST declare one annotation reflecting its intent:

| Annotation          | When to use                                      |
|---------------------|--------------------------------------------------|
| `readOnlyHint`      | Reads data, no side effects (list, get, resolve) |
| `idempotentHint`    | Safe to retry; create-or-update pattern          |
| `destructiveHint`   | Deletes or irreversibly modifies data            |

```python
@mcp.tool(annotations={"readOnlyHint": True})  # type: ignore
async def get_all_configs_tool(...) -> list[dict[str, Any]]:
    ...
```

## 3. Tool Anatomy

A tool calls a `service.*` function **immediately**. No SQL, no sessions, no business logic between.

```python
from typing import Annotated, Any, Optional
from fastmcp.server.dependencies import get_access_token  # type: ignore[import-not-found]

from src.modules.{domain}.exceptions import ConfigNotFoundError, DuplicateConfigError
from src.modules.{domain}.mcp_server import mcp
from src.modules.{domain}.models import CreateRequest, Customer, Stop, ResolveRequest, UpdateRequest
from src.modules.{domain}.service import (
    create_domain_config, get_domain_config, list_domain_configs,
    resolve_domain_config, update_domain_config, delete_domain_config,
)


def _current_user() -> str:
    """Extract caller identity from the MCP access token."""
    token = get_access_token()
    if token:
        return token.claims.get("preferred_username") or token.claims.get("name") or token.client_id
    return "mcp-agent"


@mcp.tool(annotations={"readOnlyHint": True})  # type: ignore
async def get_config_tool(
    uuid_str: Annotated[str, "The UUID of the configuration to retrieve."],
) -> dict[str, Any]:
    """Retrieve a single configuration record by its UUID.

    Returns the full configuration object, or an error dict if not found.
    """
    try:
        config = await get_domain_config(uuid.UUID(uuid_str))  # ← service call, no session
        return config.model_dump(mode="json")
    except ConfigNotFoundError as e:
        return {"error": str(e)}
    except ValueError:
        return {"error": "Invalid UUID format"}
```

### No Session Management in Tools

MCP tools MUST NOT open database sessions. The session lifecycle is handled by `repo.py`.

```python
# WRONG — do not do this in mcp_tools.py
async with AsyncSession(engine, expire_on_commit=False) as session:
    result = await get_domain_config(session, uuid.UUID(uuid_str))  # ← wrong

# CORRECT — call service directly, no session
result = await get_domain_config(uuid.UUID(uuid_str))
```

### Return values

- Always return `dict[str, Any]` or `list[dict[str, Any]]` — MCP cannot serialize SQLModel/Pydantic objects.
- Use `model.model_dump(mode="json")` to convert objects.
- On success (create/update): `{"result": "Created/Updated successfully", "config": obj.model_dump(mode="json")}`.
- On success (delete): `{"result": "Configuration {uuid} deleted successfully"}`.
- On not-found: `{"error": str(e)}` or `{"match_found": False, "message": "..."}`.
- On resolve success: `{"match_found": True, "config": obj.model_dump(mode="json")}`.

## 4. Standard Tool Set for Configuration Services

Every configuration service exposes these five tools:

### set_{domain}_config (idempotentHint)

Handles both create and update. If `uuid_str` is provided → update; otherwise → create.

```python
@mcp.tool(annotations={"idempotentHint": True})  # type: ignore
async def set_domain_config(
    margin_percent: Annotated[float, "Required. Margin as decimal (0.125 = 12.5%). Must be 0–0.99."],
    uuid_str: Annotated[Optional[str], "Provide to update existing config. Omit to create new."] = None,
    customer_name: Annotated[Optional[str], "Exact customer name."] = None,
    # ... all domain fields ...
) -> dict[str, Any]:
    """Create or update a configuration rule.

    [Validation rules and hierarchy constraints documented here]
    """
    # Build DTO objects from flat params
    customer = Customer(name=customer_name or "") if customer_name or customer_subname else None
    pickup = Stop(country=pickup_country or "", ...) if any([pickup_country, ...]) else None

    try:
        current_user = _current_user()
        if uuid_str:
            req = UpdateRequest(customer=customer, pickup=pickup, margin_percent=margin_percent)
            result = await update_domain_config(uuid.UUID(uuid_str), req, created_by=current_user)
            return {"result": "Updated successfully", "config": result.model_dump(mode="json")}
        req = CreateRequest(customer=customer, pickup=pickup, margin_percent=margin_percent)
        result = await create_domain_config(req, created_by=current_user)
        return {"result": "Created successfully", "config": result.model_dump(mode="json")}
    except (ConfigNotFoundError, DuplicateConfigError) as e:
        return {"error": str(e)}
    except ValueError as e:
        return {"error": str(e), "message": "Validation failed checking constraints."}
    except Exception as e:
        return {"error": str(e)}
```

### delete_{domain}_config_tool (destructiveHint)

```python
@mcp.tool(annotations={"destructiveHint": True})  # type: ignore
async def delete_domain_config_tool(
    uuid_str: Annotated[str, "The UUID of the configuration to delete."],
) -> dict[str, Any]:
    """Permanently delete a configuration. This action cannot be undone."""
    try:
        await delete_domain_config(uuid.UUID(uuid_str))
        return {"result": f"Configuration {uuid_str} deleted successfully"}
    except ConfigNotFoundError as e:
        return {"error": str(e)}
    except ValueError:
        return {"error": "Invalid UUID format"}
```

### resolve_{applicable_thing} (readOnlyHint)

Used to resolve the best-matching config for a real-world load context. Parameters should represent the full known context of the load (mandatory fields, not optional).

```python
@mcp.tool(annotations={"readOnlyHint": True})  # type: ignore
async def resolve_applicable_domain(
    customer_name: Annotated[str, "REQUIRED. Exact customer name. Pass '' if no customer."],
    pickup_country: Annotated[str, "REQUIRED. ISO 3166-1 alpha-2 country code, e.g. 'US'."],
    # ... all contextual fields marked REQUIRED ...
    customer_subname: Annotated[Optional[str], "Optional. Customer sub-account."] = None,
) -> dict[str, Any]:
    """Resolve and find the applicable configuration for a specific load context.

    [Document the priority-weight system and why all fields matter]
    """
    req = ResolveRequest(customer=Customer(...), pickup=Stop(...), drop=Stop(...))
    try:
        result = await resolve_domain_config(req)
        return {"match_found": True, "config": result.model_dump(mode="json")}
    except ConfigNotFoundError:
        return {"match_found": False, "message": "No matching configuration found."}
```

### get_all_configs_tool (readOnlyHint)

List with the same optional filter parameters as the REST `GET /` endpoint.

```python
@mcp.tool(annotations={"readOnlyHint": True})  # type: ignore
async def get_all_configs_tool(
    customer_name: Annotated[Optional[str], "Filter by exact customer name"] = None,
    pickup_country: Annotated[Optional[str], "Filter by pickup country"] = None,
    # ... all filterable domain fields as optional params ...
) -> list[dict[str, Any]]:
    """Retrieve active configurations, optionally filtered by customer or location."""
    configs = await list_domain_configs(
        customer_name=customer_name,
        pickup_country=pickup_country,
        # ... pass all filter args ...
    )
    return [c.model_dump(mode="json") for c in configs]
```

### get_config_tool (readOnlyHint)

```python
@mcp.tool(annotations={"readOnlyHint": True})  # type: ignore
async def get_config_tool(
    uuid_str: Annotated[str, "The unique UUID of the configuration record to retrieve"],
) -> dict[str, Any]:
    """Retrieve a single configuration record by its UUID."""
    try:
        config = await get_domain_config(uuid.UUID(uuid_str))
        return config.model_dump(mode="json")
    except ConfigNotFoundError as e:
        return {"error": str(e)}
    except ValueError:
        return {"error": "Invalid UUID format"}
```

## 5. Parameter Annotations

Every parameter MUST use `Annotated[type, "description"]`. The string is the agent's inline documentation.

```python
async def set_domain_config(
    margin_percent: Annotated[
        float,
        "Required. Margin as a decimal (e.g., 0.125 = 12.5%). Must be >= 0 and <= 0.99.",
    ],
    uuid_str: Annotated[
        Optional[str], "Provide to update an existing config. Omit to create a new one."
    ] = None,
    pickup_state: Annotated[
        Optional[str], "Pickup state or region. Requires pickup_country. Required if pickup_city is provided."
    ] = None,
) -> dict[str, Any]:
```

Guidelines:
- Required parameters → no default value, describe constraints and valid values in the annotation.
- Optional parameters → `= None`, clarify what happens when omitted.
- Describe hierarchical dependencies explicitly (e.g., "Requires pickup_country to be set").
- For resolve tools: mark all context fields as REQUIRED in the annotation even if technically optional.

## 6. Docstrings

Tool docstrings ARE the MCP tool description — write them for agents, not humans.

- First line: one clear sentence stating what the tool does.
- Subsequent lines: when to use it, validation rules, what is returned, caveats.
- For `set_*` tools: document all hierarchy constraints (e.g., geographic hierarchy rules).

## 7. MCP Testing

Use `fastmcp.Client` directly in tests — no HTTP transport needed.

```python
# conftest.py
@pytest_asyncio.fixture(scope="function")
async def mcp_client(test_db, clean_table):
    from fastmcp import Client
    from src.modules.{domain} import repo as repo_module
    from src.modules.{domain}.mcp_server import mcp
    from src.tools import db as db_module

    db_module.engine = test_db
    repo_module  # ensure import so engine reference is live

    async with Client(mcp) as c:
        yield c

# test_mcp_tools.py
async def test_set_and_update(mcp_client):
    result = await mcp_client.call_tool("set_domain_config", {"margin_percent": 0.15, "customer_name": "ACME"})
    assert result.data["result"] == "Created successfully"
    assert result.data["config"]["version"] == 1

    uid = result.data["config"]["uuid"]
    result2 = await mcp_client.call_tool("set_domain_config", {"uuid_str": uid, "margin_percent": 0.20, "customer_name": "ACME"})
    assert result2.data["result"] == "Updated successfully"
    assert result2.data["config"]["version"] == 2

async def test_resolve(mcp_client):
    await mcp_client.call_tool("set_domain_config", {"margin_percent": 0.12, "customer_name": "ACME", "pickup_country": "MX"})
    result = await mcp_client.call_tool("resolve_applicable_domain", {
        "customer_name": "ACME", "pickup_country": "MX", "pickup_state": "Jalisco",
        "pickup_city": "Guadalajara", "drop_country": "US", "drop_state": "Texas", "drop_city": "Houston",
    })
    assert result.data["match_found"] is True
```

MCP tests use `clean_table` fixture to reset the DB between tests.
MCP auth is bypassed in tests because `Client(mcp)` connects directly to the in-process MCP object without HTTP auth middleware.
