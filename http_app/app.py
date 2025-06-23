from flask import Flask
from prometheus_client import Counter, Histogram, generate_latest
import time, random

app = Flask(__name__)

REQUEST_COUNT = Counter('api_requests_total', 'Total API Requests', ['method', 'endpoint'])
REQUEST_LATENCY = Histogram('api_request_latency_seconds', 'Request latency', ['endpoint'])

@app.route("/checkout")
def checkout():
    REQUEST_COUNT.labels(method='GET', endpoint='/checkout').inc()
    with REQUEST_LATENCY.labels(endpoint='/checkout').time():
        time.sleep(random.uniform(0.1, 0.5))
        return "Checkout complete", 200

@app.route("/metrics")
def metrics():
    return generate_latest(), 200, {'Content-Type': 'text/plain'}

@app.route("/health")
def health():
    return "OK", 200

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=8080)
