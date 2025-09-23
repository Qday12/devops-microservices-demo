from flask import Flask

app = Flask(__name__)

@app.route("/health")
def health():
    return {"status": "ok"}

@app.route("/users")
def users():
    return {"users": ["Alice", "Bob", "Charlie"]}

@app.route("/helloworld")
def helloworld():
    return "Hello, World!"

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)
