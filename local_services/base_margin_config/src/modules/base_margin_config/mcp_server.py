from fastmcp import FastMCP  # type: ignore
from src.tools.auth import get_mcp_auth

mcp = FastMCP("Base Margin Configuration", auth=get_mcp_auth())
