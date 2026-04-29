import logging

from fastapi import FastAPI, HTTPException, Request
from fastapi.responses import JSONResponse

from .modules.reports.router import router

logging.basicConfig(
    level=logging.INFO,
    format=('{"time": "%(asctime)s", "level": "%(levelname)s", "logger": "%(name)s", "message": "%(message)s"}'),
)
logger = logging.getLogger(__name__)

app = FastAPI(title="Transport Deluxe Core")


@app.exception_handler(HTTPException)
async def http_exception_handler(request: Request, exc: HTTPException) -> JSONResponse:
    if isinstance(exc.detail, dict):
        content = exc.detail
    else:
        content = {"status": exc.status_code, "messages": [str(exc.detail)]}
    return JSONResponse(status_code=exc.status_code, content=content)


@app.exception_handler(Exception)
async def unhandled_exception_handler(request: Request, exc: Exception) -> JSONResponse:
    logger.error("Unhandled exception: %s", exc, exc_info=True)
    return JSONResponse(
        status_code=503,
        content={"status": 503, "messages": ["Service temporarily unavailable"]},
    )


app.include_router(router, prefix="/reports")
