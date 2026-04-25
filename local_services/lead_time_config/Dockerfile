FROM python:3.14-slim

WORKDIR /app

RUN pip install uv

COPY pyproject.toml .
COPY alembic.ini .
RUN uv pip install --system -e . && uv pip install --system pytest pytest-asyncio anyio[trio]

COPY src/ ./src/
COPY tests/ ./tests/

EXPOSE 8004

CMD ["uvicorn", "src.main:app", "--host", "0.0.0.0", "--port", "8004"]
