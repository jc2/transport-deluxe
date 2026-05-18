from fastmcp import FastMCP
from src.tools.auth import get_mcp_auth

mcp = FastMCP("Driver Tariff Configuration", auth=get_mcp_auth())
