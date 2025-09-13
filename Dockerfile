FROM python:3.12.4-slim-bookworm

ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1

# Create non-root user early
RUN useradd -m -u 10001 appuser

WORKDIR /app

# System deps kept minimal; clean apt lists (Checkov)
RUN apt-get update && apt-get install -y --no-install-recommends \
    curl ca-certificates \
  && rm -rf /var/lib/apt/lists/*

# Install Python deps
COPY requirements.txt .
RUN python -m pip install --upgrade pip && \
    pip install --no-cache-dir -r requirements.txt

# Copy app code and set ownership
COPY . .
RUN chown -R appuser:appuser /app

# Run as non-root (Checkov happy)
USER appuser

EXPOSE 5000

# Liveness probe (Checkov)
HEALTHCHECK --interval=30s --timeout=3s --start-period=10s \
  CMD curl --fail http://127.0.0.1:5000 || exit 1

CMD ["python", "app.py"]
