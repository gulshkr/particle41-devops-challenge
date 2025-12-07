FROM python:3.9-slim

# Install dependencies
RUN apt-get update && apt-get install -y \
    gcc \
    && rm -rf /var/lib/apt/lists/*

# Copy app
WORKDIR /app
COPY simple_time_service.py .

# Install Python dependencies
RUN pip install --no-cache-dir flask

# Create non-root user
RUN useradd -m -u 1000 myuser && chown -R myuser:myuser /app

# Switch to non-root user
USER myuser

EXPOSE 8080

CMD ["python", "simple_time_service.py"]
