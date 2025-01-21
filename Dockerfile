FROM python:3.12-slim as base

WORKDIR /app

RUN apt-get update && apt-get install -y librdkafka-dev gcc libssl-dev zlib1g-dev git g++ make

COPY uv.lock pyproject.toml .

RUN pip install uv
RUN uv sync

COPY . .

CMD ["sh", "-c", "uv run ./manage.py collectstatic --noinput && uv run ./manage.py migrate && uv run ./manage.py runserver 0.0.0.0:8000"]
