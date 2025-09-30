from flask import Flask
from prometheus_flask_exporter import PrometheusMetrics

app = Flask(__name__)
metrics = PrometheusMetrics(app)

@app.route("/health")
def health():
    return {"status": "ok"}

@app.route("/users")
def users():
    return {"users": ["Alice", "Bob", "Charlie"]}

@app.route("/")
def helloworld():
    return "Hello, World!"

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)
