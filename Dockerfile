FROM python:3.12.4-slim-bookworm

ENV PYTHONDONTWRITEBYTECODE=1 
    PYTHONUNBUFFERED=1

RUN useradd -m -u 10001 appuser
WORKDIR /app

RUN apt-get update && apt-get install -y --no-install-recommends 
    curl ca-certificates 
  && rm -rf /var/lib/apt/lists/*

COPY requirements.txt .
RUN python -m pip install --upgrade pip && 
    pip install --no-cache-dir -r requirements.txt

COPY . .
RUN chown -R appuser:appuser /app

USER appuser
EXPOSE 5000

HEALTHCHECK --interval=30s --timeout=3s --start-period=10s 
  CMD curl --fail http://127.0.0.1:5000 || exit 1

CMD ["python", "app.py"]
