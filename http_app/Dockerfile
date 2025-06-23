FROM python:3.11-slim
WORKDIR /app

COPY test/http_app/app.py .
COPY tests/ ./tests/
ENV PYTHONPATH=/app
RUN pip install flask prometheus_client pytest
EXPOSE 8080
CMD ["python", "app.py"]
