---
description: "Use when adding, modifying or reviewing MCP tools in any service (configuration or workflow engine). Covers FastMCP setup, tool anatomy, parameter annotations, error handling, session management, integration with FastAPI, and MCP testing with fastmcp.Client."
---

# MCP Tool Implementation Conventions

## Core Principle: MCP is just another interface

MCP tools are **not** a separate layer of business logic. They are a second interface into the same `service.py` functions that the HTTP REST endpoints use. The stack looks like this:

```
HTTP REST client  →  router.py  ─┐
                                  ├──→  service.py  →  database
MCP agent         →  mcp_tools.py ┘
```

`mcp_tools.py` MUST NOT contain SQL queries, business rules, or any logic that duplicates what `service.py` already does. If you find yourself re-implementing logic in a tool, it belongs in `service.py` instead.

Every configuration service MUST expose a full set of MCP tools.
Workflow engines MAY expose read-only tools for inspecting audit data.

## 1. File Organisation

```text
modules/{domain}/
├── mcp_server.py      # mcp = FastMCP("Human-readable service name")  — nothing else
└── mcp_tools.py       # All @mcp.tool decorated functions
```

`main.py` mounts the MCP app and imports `mcp_tools` as a side effect:

```python
import src.modules.{domain}.mcp_tools  # noqa: F401    ← registers tools
from src.modules.{domain}.mcp_server import mcp

mcp_app = mcp.http_app(path="/", transport="streamable-http")
app = FastAPI(lifespan=combine_lifespans(lifespan, mcp_app.lifespan))
```

## 2. Tool Annotations

Every tool MUST declare one annotation reflecting its intent:

| Annotation          | When to use                                      |
|---------------------|--------------------------------------------------|
| `readOnlyHint`      | Reads data, no side effects (list, get, resolve) |
| `idempotentHint`    | Safe to retry; create-or-update pattern          |
| `destructiveHint`   | Deletes or irreversibly modifies data            |

```python
@mcp.tool(annotations={"readOnlyHint": True})
async def get_all_configs_tool(...) -> list[dict[str, Any]]:
    ...
```

## 3. Tool Anatomy

A tool opens its own DB session and delegates **immediately** to `service.py`. No logic between session open and service call.

```python
from typing import Annotated, Any, Optional
from sqlmodel.ext.asyncio.session import AsyncSession
from src.tools.db import engine          # imported at module level — replaced by test fixture
from src.modules.{domain}.service import get_domain_config  # ← always delegates to service.py

@mcp.tool(annotations={"readOnlyHint": True})
async def get_config_tool(
    uuid_str: Annotated[str, "The UUID of the configuration to retrieve."],
) -> dict[str, Any]:
    """One clear sentence what this tool does.

    Additional lines explaining when to use it, what it returns, and any caveats.
    This docstring IS the MCP tool description — make it agent-friendly.
    """
    async with AsyncSession(engine, expire_on_commit=False) as session:
        try:
            result = await get_domain_config(session, uuid.UUID(uuid_str))  # ← service call
            return result.model_dump(mode="json")
        except HTTPException as e:
            return {"error": e.detail, "status_code": e.status_code}
        except ValueError:
            return {"error": "Invalid UUID format"}
```

### Session management

MCP tools MUST manage their own database sessions using `async with AsyncSession(engine, ...)`.
Do NOT use FastAPI's `get_session` dependency — it is not available outside the request lifecycle.
Use `expire_on_commit=False` to allow model attribute access after commit.

### Return values

- Always return `dict[str, Any]` or `list[dict[str, Any]]` — MCP cannot serialize SQLModel objects.
- Use `model.model_dump(mode="json")` to convert SQLModel/Pydantic objects.
- On success: `{"result": "Created successfully", "config": obj.model_dump(mode="json")}`.
- On not-found: `{"match_found": False, "message": "..."}` or `{"error": "...", "status_code": 404}`.

## 4. Parameter Annotations

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
    customer_name: Annotated[
        Optional[str], "Exact customer name. Required if customer_subname is provided."
    ] = None,
) -> dict[str, Any]:
```

Guidelines:
- Required parameters → no default value, describe constraints in the annotation.
- Optional parameters → `= None`, clarify what happens when omitted.
- Describe hierarchical dependencies explicitly (e.g., "Requires pickup_country to be set").
- Use concrete examples where helpful (e.g., `'US'`, `'MX'`).

## 5. Error Handling

MCP tools MUST NOT raise exceptions — agents cannot handle Python exceptions. Always catch and return error dicts:

```python
try:
    ...
    return {"result": "...", "config": obj.model_dump(mode="json")}
except ValueError as e:
    return {"error": str(e), "message": "Validation failed checking constraints."}
except HTTPException as e:
    return {"error": e.detail, "status_code": e.status_code}
except Exception as e:
    return {"error": str(e)}
```

Order of exception clauses: `ValueError` → `HTTPException` → `Exception`.

## 6. Upsert Pattern (Create-or-Update)

Configuration services expose a single `set_{domain}` tool instead of separate create/update tools:

```python
@mcp.tool(annotations={"idempotentHint": True})
async def set_domain_config(
    margin_percent: Annotated[float, "..."],
    uuid_str: Annotated[Optional[str], "Provide to update. Omit to create."] = None,
    # ... all config fields
) -> dict[str, Any]:
    """Create or update a configuration rule.

    If 'uuid_str' is provided, the existing rule is updated (new version created).
    If 'uuid_str' is omitted, a new rule is created with version=1.
    """
    async with AsyncSession(engine, expire_on_commit=False) as session:
        ...
        try:
            if uuid_str:
                result = await update_domain_config(session, uuid.UUID(uuid_str), req, created_by="mcp-agent")
                return {"result": "Updated successfully", "config": result.model_dump(mode="json")}
            result = await create_domain_config(session, req, created_by="mcp-agent")
            return {"result": "Created successfully", "config": result.model_dump(mode="json")}
        except HTTPException as e:
            return {"error": e.detail, "status_code": e.status_code}
        except ValueError as e:
            return {"error": str(e), "message": "Validation failed checking constraints."}
        except Exception as e:
            return {"error": str(e)}
```

- `created_by` is always `"mcp-agent"` for MCP-initiated operations.

## 7. List & Filter Tools

The `get_all_configs_tool` MUST mirror all filters available on the REST `GET /` endpoint:

```python
@mcp.tool(annotations={"readOnlyHint": True})
async def get_all_configs_tool(
    field_a: Annotated[Optional[str], "Filter by exact field_a value"] = None,
    field_b: Annotated[Optional[str], "Filter by exact field_b value"] = None,
) -> list[dict[str, Any]]:
    """Retrieve active configurations, optionally filtered.

    Returns the latest version of each distinct configuration matching the filters.
    """
    async with AsyncSession(engine, expire_on_commit=False) as session:
        configs = await list_domain_configs(session, field_a=field_a, field_b=field_b)
        return [c.model_dump(mode="json") for c in configs]
```

## 8. Resolve Tool

The resolve tool represents the primary business operation — finding the best-matching config for a real context.

```python
@mcp.tool(annotations={"readOnlyHint": True})
async def resolve_applicable_{domain}(
    # All context fields REQUIRED (no Optional) — a real-world entity always has full context
    customer_name: Annotated[str, "REQUIRED. ..."],
    pickup_country: Annotated[str, "REQUIRED. ..."],
    ...
    # Truly optional fields (e.g., postal code in some systems)
    drop_postal_code: Annotated[Optional[str], "Optional. ..."] = None,
) -> dict[str, Any]:
    """Resolve and return the applicable {Domain} configuration for a specific load or entity.

    Use when calculating the correct value to apply on a real shipment/load.
    Unlike configurations (which can be generic), the real-world context always has specific values.
    Provide ALL known context — the engine uses a priority weight system to find the best match.
    """
    async with AsyncSession(engine, expire_on_commit=False) as session:
        req = ResolveRequest(...)
        result = await resolve_domain_config(session, req)
        if result:
            return {"match_found": True, "config": result.model_dump(mode="json")}
        return {"match_found": False, "message": "No matching configuration found."}
```

- Required context fields are NOT `Optional` — force the agent to provide them.
- Return `{"match_found": bool, ...}` consistently so agents can branch on the result.

## 9. Testing MCP Tools

### Fixture

```python
@pytest_asyncio.fixture(scope="function")
async def mcp_client(test_db, clean_table):
    import src.modules.{domain}.mcp_tools as mcp_tools_module
    from fastmcp import Client
    from src.modules.{domain}.mcp_server import mcp

    mcp_tools_module.engine = test_db    # redirect DB access to test database

    async with Client(mcp) as c:
        yield c
```

### Test pattern

```python
async def test_set_domain_config(mcp_client: Client):
    result = await mcp_client.call_tool("set_domain_config", {"field": "value", ...})
    assert result.data["result"] == "Created successfully"
    assert result.data["config"]["version"] == 1

    uid = result.data["config"]["uuid"]
    update = await mcp_client.call_tool("set_domain_config", {"uuid_str": uid, "field": "new_value"})
    assert update.data["result"] == "Updated successfully"
    assert update.data["config"]["version"] == 2
```

- One test per tool covering the create → update cycle (for upsert tools) or the single operation.
- Access results via `result.data` — it is the dict returned by the tool function.
- The `mcp_client` fixture already includes `clean_table` — do not add it separately.
- No `@pytest.mark.asyncio` needed when `asyncio_mode = "auto"` is configured.
