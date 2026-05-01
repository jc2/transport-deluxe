# MCP Server Integration Plan — base_margin_config with fastmcp

## Service Overview

The `base_margin_config` service has the following relevant pieces that affect the integration:

- `main.py` defines its own lifespan that does two things at startup: (1) runs Alembic migrations via subprocess and (2) pre-loads Casdoor JWKS. This lifespan cannot be removed or replaced.
- The FastAPI app has a sqladmin Admin panel mounted directly on the SQLAlchemy engine.
- The router exposes six endpoints: create, list, get, update, delete, and resolve. All require a JWT except `/resolve`, which is public.
- The database layer uses SQLModel's `AsyncSession` over asyncpg.
- The domain model is `BaseMarginConfig` with fields for customer, pickup, drop, `margin_percent`, and audit metadata.
- Business logic is encapsulated in `service.py` with independent async functions that receive a session.

---

## Goal

Mount an MCP server in the same FastAPI ASGI process, at the `/mcp` route, with domain-specific tools, resources, and prompts — without changing the existing REST API behavior.

---

## Step 1 — Add the dependency

In `local_services/base_margin_config/pyproject.toml`, add `fastmcp` to the project dependencies. No extras required. Minimum recommended version is `2.3.1` for official FastAPI mounting support.

---

## Step 2 — Create the module `src/mcp_server.py`

This file is the core of the MCP server. The `FastMCP` instance and all its components are defined here. It goes in its own module — not in `main.py` — to keep concerns separated.

The instance is created with `FastMCP("Base Margin Configuration")`. Then define:

**Tools** (actions the LLM can execute — equivalent to POST/PUT/DELETE):

- `create_base_margin_config_tool` — receives `CreateRequest` parameters and calls the service function. Gets an `AsyncSession` from the engine via a direct `async with AsyncSession(engine)` block. Returns the result as a dict.
- `update_base_margin_config_tool` — receives `uuid` and `UpdateRequest` parameters.
- `delete_base_margin_config_tool` — receives `uuid`.
- `resolve_applicable_margin` — the most valuable tool for an LLM. Receives `ResolveRequest` parameters and returns the matching margin percent or an empty response. Describes itself as "find the margin percentage that applies to a load matching a given customer, origin, and destination."

**Resources** (data the LLM can read — equivalent to GET):

- `base-margin://configs` — static resource that calls `list_base_margin_configs` and returns the list serialized as a JSON string.
- `base-margin://configs/{uuid}` — resource template that calls `get_base_margin_config` with the received uuid.

**Prompts** (templates to guide the LLM):

- `margin_analysis_context` — accepts optional `customer_name` and `truck_type`, returns a string with instructions for the LLM to analyze margin configurations consistently.
- `create_config_guide` — describes business rules for creating a valid configuration: unique combination of customer/pickup/drop, `margin_percent` between 0 and 100, etc.

---

## Step 3 — Modify `main.py` to mount the MCP server

Three changes are needed in `main.py`:

1. Import `combine_lifespans` from `fastmcp.utilities.lifespan` and import the `mcp` instance from `src.mcp_server`.
2. Create `mcp_app` by calling `mcp.http_app(path="/")` before creating the FastAPI app. `path="/"` means the MCP endpoint will be at the root of its mount point, which will be `/mcp`.
3. Change the FastAPI app construction to combine both lifespans:

```python
app = FastAPI(
    title="Base Margin Configuration Service",
    lifespan=combine_lifespans(lifespan, mcp_app.lifespan),
)
```

4. At the end of the file, add the mount:

```python
app.mount("/mcp", mcp_app)
```

The sqladmin Admin panel and exception handlers remain exactly as-is. The router is included as before. The MCP endpoint will be available at `/mcp`.

---

## Step 4 — Solve the async session problem in tools

fastmcp tools are plain async functions. They do not have access to FastAPI's `Depends` system. The correct way to get a session is:

```python
async def create_base_margin_config_tool(...):
    async with AsyncSession(engine, expire_on_commit=False) as session:
        result = await create_base_margin_config(session, req, created_by="mcp_agent")
        return result.model_dump()
```

The `engine` is imported from `src.tools.db`. It is the same singleton used by the REST API.

---

## Step 5 — Authentication

MCP tools are not JWT-protected at the MCP layer for now. This is acceptable because:

- The MCP server is typically consumed by an internal agent or the team's LLM, not external users directly.
- The existing REST API continues to require JWT — MCP tools bypass that layer by calling the engine directly.
- If access control is needed in the future, fastmcp supports `TokenVerifier` and auth settings that can be added to the `FastMCP` instance without changing any tools.

---

## Step 6 — Tool naming and descriptions

Do not duplicate REST endpoints literally. MCP tool descriptions must be written for the LLM, not for a developer. For example:

- Instead of `"Create a base margin config"` → `"Configure the base margin percentage that applies to loads matching a specific customer, origin, and destination combination."`
- Instead of `"resolve_config"` → `"resolve_applicable_margin"`

---

## Step 7 — Verification

Start the service normally. The MCP Inspector (`npx @modelcontextprotocol/inspector`) connected to `http://localhost:PORT/mcp` should show all defined tools, resources, and prompts. Existing tests are not affected because they do not touch `/mcp`. The sqladmin Admin panel continues to work at `/admin`.

---

## Best Practices for Documenting MCP Components

These rules come from the official MCP specification (2025-06-18), the fastmcp documentation at gofastmcp.com, and Jeremiah Lowin's essay *Stop Converting Your REST APIs to MCP* (July 2025).

---

### The three-field mental model

Every MCP component (tool, resource, prompt) has three distinct fields that serve different audiences:

| Field | Audience | Purpose |
|---|---|---|
| `name` | Programmatic identifier | Used in code, routing, and protocol messages. Must be stable and unique. |
| `title` | Human / UI | Shown in client interfaces. Can be a plain-English label. Never used by the LLM. |
| `description` | The LLM | The only field the model reads to decide whether and how to call the component. This is your primary documentation surface. |

Write `description` as if you are instructing a capable but literal assistant: be explicit about when to use the component, what it requires, and what it produces.

---

### Tools

**Write descriptions for the LLM, not for a developer.**

The description should explain the *agent-level intent*: when would an autonomous agent choose to call this tool? Avoid repeating the function signature.

- Bad: `"Create a base margin config."`
- Good: `"Configure the margin percentage that applies to loads matching a specific customer, origin, and destination. Call this when the user wants to register a new pricing rule for a customer lane."`

**Annotate every parameter.**

FastMCP reads Python type annotations to generate the JSON Schema sent to the LLM. Add a short string description to every parameter using the `Annotated` shorthand. The LLM uses these to fill in values correctly:

```python
from typing import Annotated

@mcp.tool
async def resolve_applicable_margin(
    customer_name: Annotated[str, "Exact name of the customer as stored in the system"],
    pickup_country: Annotated[str, "ISO 3166-1 alpha-2 country code for pickup location"],
    drop_country: Annotated[str, "ISO 3166-1 alpha-2 country code for drop location"],
    margin_percent: Annotated[float, "Margin to apply, as a decimal percentage (e.g. 12.5 means 12.5%)"],
) -> dict:
    """Find the margin percentage that applies to a load matching the given customer and lane."""
    ...
```

Use `Annotated[type, Field(description=..., ge=0, le=100)]` when you also need validation constraints (e.g. `margin_percent` must be between 0 and 100).

**Always annotate return types.**

FastMCP auto-generates an `outputSchema` from Python return type annotations. This lets clients deserialize the result as structured data and enables LLMs to reference field names in follow-up reasoning.

Return a Pydantic model or dataclass when the result has multiple fields. Primitive returns (e.g. `-> float`) are wrapped automatically under a `{"result": ...}` key.

**Use annotations to communicate behavior.**

Mark every read-only tool explicitly. MCP clients like Claude and ChatGPT skip confirmation dialogs for read-only operations. Mark destructive operations so clients can present appropriate warnings:

```python
@mcp.tool(annotations={"readOnlyHint": True, "openWorldHint": False})
async def get_base_margin_config_tool(uuid: Annotated[str, "UUID of the config to retrieve"]) -> dict:
    """Retrieve a single base margin configuration by its UUID."""
    ...

@mcp.tool(annotations={"destructiveHint": True})
async def delete_base_margin_config_tool(uuid: Annotated[str, "UUID of the config to delete"]) -> dict:
    """Permanently delete a base margin configuration. This action cannot be undone."""
    ...
```

**Design for the agent story, not the REST API.**

The strongest argument against one-to-one mapping of REST endpoints to tools: *agentic iteration is brutally expensive*. Each tool call is a full LLM reasoning round-trip. Prefer composite, high-value tools over atomic CRUD ones. For this service, the most valuable single tool is `resolve_applicable_margin` — it answers the question the agent actually needs to ask.

From Jeremiah Lowin (fastmcp author): *"Start with the agent story: 'As an agent, given {context}, I use {tools} to achieve {outcome}.' Then build only the tools required to fulfill that story."*

**Include input/output examples in the description (few-shot at the tool level).**

The `description` field is plain text — the LLM reads it entirely before deciding whether and how to call the tool. You can include short input/output examples for tools where the parameter format or the output shape is not obvious. This is standard few-shot prompting applied at the tool definition level.

Keep examples short: 1–2 cases maximum. Every character in a description is a token paid on every LLM reasoning step.

Most useful for:
- Tools where parameter format is non-obvious (country codes, UUID vs name, percentage as float vs int)
- Tools where the output shape matters for the agent's next step (e.g. what does "no match found" look like?)
- Tools with conditional required fields (like upsert: "if uuid is omitted, a new record is created")

```python
@mcp.tool(annotations={"readOnlyHint": True})
async def resolve_applicable_margin(
    customer_name: Annotated[str, "Exact customer name as stored in the system"],
    pickup_country: Annotated[str, "ISO 3166-1 alpha-2 code, e.g. 'ES'"],
    drop_country: Annotated[str, "ISO 3166-1 alpha-2 code, e.g. 'FR'"],
) -> dict:
    """Find the margin percentage that applies to a load for a given customer and lane.

    Returns the most specific matching configuration, or an empty result if none applies.

    Example input:
      customer_name="Acme Logistics", pickup_country="ES", drop_country="FR"

    Example output (match found):
      {"uuid": "abc-123", "margin_percent": 12.5, "customer_name": "Acme Logistics"}

    Example output (no match):
      {"uuid": null, "margin_percent": null}
    """
    ...
```

For the upsert tool, the example is especially valuable because the create-vs-update behavior depends on whether `uuid` is provided:

```python
@mcp.tool(annotations={"idempotentHint": True})
async def set_base_margin_config(
    customer_name: Annotated[str, "Customer name"],
    margin_percent: Annotated[float, Field(description="e.g. 12.5 means 12.5%", ge=0, le=100)],
    uuid: Annotated[str | None, "Omit to create a new config; provide to update an existing one"] = None,
    ...
) -> dict:
    """Create or update the margin rule for a customer lane.

    - If uuid is omitted: creates a new configuration and returns it with a new uuid.
    - If uuid is provided and exists: updates that configuration in place.
    - If uuid is provided but does not exist: raises an error.

    Example — create:
      Input:  customer_name="Acme", margin_percent=10.0 (no uuid)
      Output: {"uuid": "new-uuid-here", "margin_percent": 10.0, ...}

    Example — update:
      Input:  uuid="abc-123", customer_name="Acme", margin_percent=15.0
      Output: {"uuid": "abc-123", "margin_percent": 15.0, ...}
    """
    ...
```

Do not add examples to tools whose behavior is self-evident from the parameter names and types alone (e.g. `delete_base_margin_config(uuid: str)`).

---

**Handle expected errors with `ToolError`.**

Expected business logic failures (record not found, constraint violated) should raise `ToolError` with a clear message. This sends an informative error back to the LLM so it can retry or inform the user, rather than crashing the tool call silently:

```python
from fastmcp.exceptions import ToolError

@mcp.tool
async def get_base_margin_config_tool(uuid: str) -> dict:
    """..."""
    async with AsyncSession(engine, expire_on_commit=False) as session:
        result = await get_base_margin_config(session, uuid)
        if result is None:
            raise ToolError(f"No base margin configuration found with UUID {uuid}.")
        return result.model_dump()
```

---

### Resources

Resources are application-controlled data the LLM reads — equivalent to GET endpoints. The key difference from tools: the application decides what data to include; the LLM does not trigger side effects by reading a resource.

**Use a custom URI scheme** that clearly identifies the service domain (`base-margin://`). This avoids collisions across services in the same agent context and makes the resource origin immediately visible to the LLM.

**Use RFC6570 URI templates for parameterized resources:**

```python
@mcp.resource("base-margin://configs/{uuid}")
async def get_config_resource(uuid: str) -> str:
    """A single base margin configuration record identified by its UUID."""
    ...
```

**Document every resource with a `description`** that explains what the data represents and when an agent should read it versus calling a tool. The `mimeType` field should be set explicitly (`application/json` for JSON strings).

**Use resource annotations to signal priority and audience.** From the MCP spec:
- `audience: ["assistant"]` — the data is meant to be included in the LLM context.
- `priority: 1.0` — the resource is required reading; `priority: 0.0` — optional.
- `lastModified` — ISO 8601 timestamp telling the LLM how fresh the data is.

---

### Prompts

Prompts are user-controlled templates. They are triggered explicitly by the user (e.g. a slash command in a chat interface) rather than autonomously by the LLM.

**Write descriptions as "Asks the LLM to..."** to make the user-facing intent clear. Examples:

- `"Asks the LLM to analyze the current base margin configurations for a given customer and suggest whether the margins are competitive."`
- `"Asks the LLM to walk the user through creating a new base margin configuration step by step, validating each field."`

**Document all arguments with `required` flags.** The MCP spec requires each argument to declare `name`, `description`, and `required`. Arguments that have reasonable defaults should be optional; arguments whose absence makes the prompt meaningless should be required.

**Consider multi-turn structure.** Prompts can include both `user` and `assistant` turns. Pre-populating an `assistant` turn with a partial analysis or a confirmation question creates more natural agent conversations.

**Embed resources inside prompts.** When the prompt requires current data (e.g. the list of existing configurations for a given customer), use an embedded resource reference in the prompt message rather than asking the LLM to call the resource separately. This reduces round-trips and keeps the prompt self-contained.

---

### General naming conventions

- Tool names should be verb-first and describe the *action* and *object*: `resolve_applicable_margin`, `create_base_margin_config`, `delete_base_margin_config`.
- Resource URIs should be noun-first and hierarchical: `base-margin://configs`, `base-margin://configs/{uuid}`.
- Prompt names should describe the *workflow intent*: `margin_analysis_context`, `create_config_guide`.
- Avoid technical abbreviations in `description` fields. The LLM has no context for internal jargon — write as if describing the domain to a smart outsider.

---

### Agent skill patterns to consider

When an LLM agent implements or extends this MCP server, the following reusable patterns apply:

1. **Composite tool pattern**: Instead of exposing `list`, `get`, and `resolve` separately, offer a single `find_margin_for_load` tool that accepts a full load description and internally calls resolve (with fallback to list). The LLM calls one tool, not three.

2. **Context injection via `Depends`**: For values that should not be visible in the tool schema (e.g. internal `created_by` metadata), use fastmcp's `Depends()` injection. This hides the parameter from the LLM's schema while still passing it to the function at runtime.

3. **Read-only resource + mutating tool split**: Expose read access exclusively through resources (`base-margin://configs`) and write access exclusively through tools. This keeps the LLM's mental model clean: resources are for reading, tools are for acting.

4. **Structured output + backward-compatible text**: Always return both `structuredContent` (for agents that parse JSON) and a `TextContent` summary (for clients that only support text). FastMCP does this automatically when you return a Pydantic model or dict — no extra work required.

---

## Tool Design: How Many Tools and What Shape

### Option A — One tool per REST endpoint (6 tools)

Map each HTTP endpoint to a tool 1:1: `create_base_margin_config`, `list_base_margin_configs`, `get_base_margin_config`, `update_base_margin_config`, `delete_base_margin_config`, `resolve_applicable_margin`.

**Problems:**
- The LLM pays the full schema cost of 6 tools on every reasoning step, even for simple tasks.
- Creates ambiguous decisions: the LLM has to choose between `create` and `update` without always knowing whether the record exists.
- `list` and `get` as tools invite the LLM to call them repeatedly for reading, which it should do via resources instead.

**Verdict: avoid for production.**

---

### Option B — Dispatcher with an `action` parameter

A single tool that accepts an `action: Literal["create", "update", "delete", "resolve"]` and all possible fields as optional parameters.

```python
@mcp.tool
async def manage_base_margin_config(
    action: Annotated[Literal["create", "update", "delete", "resolve"], "Action to perform"],
    uuid: Annotated[str | None, "Required for update and delete"] = None,
    margin_percent: Annotated[float | None, "Required for create and update"] = None,
    # ... all other fields optional
) -> dict:
    ...
```

**Problems:**
- The JSON Schema becomes a union of incompatible field sets. Every field is technically optional, so the LLM gets no guidance on which fields are required for a given action.
- The LLM must make two sequential decisions: pick an action, then pick the right fields. Each uncertainty compounds hallucination risk.
- Validation becomes manual: you must check inside the function that the right fields are present for the given action, and raise `ToolError` to inform the LLM.

**Verdict: avoid. The schema ambiguity causes measurably worse LLM performance.**

---

### Option C — Upsert + Delete + Resolve (recommended for single-record management)

Three tools, each with a clean, unambiguous schema:

```python
@mcp.tool(annotations={"idempotentHint": True})
async def set_base_margin_config(
    customer_name: Annotated[str, "Customer name as stored in the system"],
    pickup_country: Annotated[str, "ISO 3166-1 alpha-2 pickup country code"],
    drop_country: Annotated[str, "ISO 3166-1 alpha-2 drop country code"],
    margin_percent: Annotated[float, Field(description="Margin percentage, e.g. 12.5", ge=0, le=100)],
    uuid: Annotated[str | None, "Omit to create; provide to update an existing config"] = None,
    # ... remaining optional lane fields
) -> dict:
    """Create or update the margin rule for a customer lane.
    If uuid is provided and a config with that uuid exists, it is updated.
    If uuid is omitted, a new config is created.
    Use this whenever the user wants to establish or change a margin rule."""
    ...

@mcp.tool(annotations={"destructiveHint": True})
async def delete_base_margin_config(
    uuid: Annotated[str, "UUID of the config to permanently delete"],
) -> dict:
    """Permanently remove a margin configuration rule. This cannot be undone."""
    ...

@mcp.tool(annotations={"readOnlyHint": True})
async def resolve_applicable_margin(
    customer_name: Annotated[str, "Customer name"],
    pickup_country: Annotated[str, "Pickup country code"],
    drop_country: Annotated[str, "Drop country code"],
    # ... remaining ResolveRequest fields
) -> dict:
    """Find the margin percentage that applies to a load for a given customer and lane."""
    ...
```

**Why this works:**
- The LLM makes exactly one decision per call: which tool?
- `set_` collapses create/update into a single intent ("ensure this config exists with these values"), which is almost always the agent's actual goal.
- `delete_` and `resolve_` are unambiguous by nature.
- `list` and `get` live as resources (`base-margin://configs`, `base-margin://configs/{uuid}`), not tools.

**Verdict: the default choice for this service.**

---

### Option D — Bulk upsert tool (for many configs at once)

When the agent story involves importing, synchronizing, or batch-updating configs (e.g. "apply these pricing rules from a spreadsheet"), a single record per call is too expensive. One LLM reasoning cycle per record multiplied by 50 records is 50 round-trips.

The solution is a second upsert tool that accepts a list:

```python
from pydantic import BaseModel, Field
from typing import Annotated

class MarginConfigInput(BaseModel):
    uuid: str | None = None  # omit to create, provide to update
    customer_name: str
    pickup_country: str
    drop_country: str
    margin_percent: float = Field(ge=0, le=100)
    # ... remaining lane fields

class BulkUpsertResult(BaseModel):
    created: int
    updated: int
    failed: list[dict]  # [{uuid_or_index, error_message}]

@mcp.tool(
    annotations={"idempotentHint": True},
    timeout=60.0,  # bulk ops can be slow
)
async def bulk_set_base_margin_configs(
    configs: Annotated[
        list[MarginConfigInput],
        "List of margin configurations to create or update. Each item is processed independently."
    ],
) -> BulkUpsertResult:
    """Create or update multiple margin configurations in a single call.
    Each entry is processed independently: failures in one do not affect the others.
    Returns a summary of how many were created, updated, and failed.
    Use this when applying a batch of pricing rules at once."""
    created, updated, failed = 0, 0, []
    async with AsyncSession(engine, expire_on_commit=False) as session:
        for i, config in enumerate(configs):
            try:
                if config.uuid:
                    await update_base_margin_config(session, config.uuid, ...)
                    updated += 1
                else:
                    await create_base_margin_config(session, ...)
                    created += 1
            except Exception as e:
                failed.append({"index": i, "error": str(e)})
    return BulkUpsertResult(created=created, updated=updated, failed=failed)
```

**Key design decisions for bulk tools:**

- **Process independently, never abort on first failure.** The LLM sent a list; if one item fails the others should still be processed. Collect failures and report them in the return value.
- **Return a structured summary, not a list of results.** `created/updated/failed` counts are what the LLM needs to report back to the user. A list of 50 full records as output is wasted tokens.
- **Set a `timeout`.** Bulk operations are the most common source of tool timeouts. Set an explicit ceiling (e.g. `timeout=60.0`) so the LLM gets a clean error instead of hanging indefinitely.
- **Input validation at the model level.** Use Pydantic constraints on `MarginConfigInput` (e.g. `ge=0, le=100` on `margin_percent`). This way invalid items are rejected before any database work happens, and the error message is automatically descriptive.
- **Keep `set_base_margin_config` (single) alongside the bulk tool.** Do not replace the single-record tool. The LLM will use the single tool for interactive user conversations and the bulk tool for import/sync workflows. Having both is intentional.

**When to add the bulk tool:** only when you have a concrete agent story that involves processing more than ~5 records at once. Do not add it preemptively.

---

### Decision summary

| Agent story | Recommended tool shape |
|---|---|
| User asks to set/change one rule interactively | `set_base_margin_config` (upsert, single) |
| User asks to delete a rule | `delete_base_margin_config` |
| Agent checks margin for a load | `resolve_applicable_margin` |
| Agent imports/syncs a batch of rules | `bulk_set_base_margin_configs` |
| Agent reads existing rules to reason about them | Resource: `base-margin://configs` |
