from flask import Flask

app = Flask(__name__)

@app.get("/")
def home():
    return "Hello from SecurePipeline360! 🚀"

if __name__ == "__main__":
    # flask dev server
    app.run(host="0.0.0.0", port=5000, debug=True)