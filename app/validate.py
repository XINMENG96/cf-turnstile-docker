import json
from flask import Flask, request, jsonify

app = Flask(__name__)

@app.route("/validate", methods=["POST"])
def validate_turnstile():
    data = request.json
    if 'token' in data:
        # 在此验证 Turnstile token
        # 这里可以根据需要进行实际验证，示例中假设验证通过
        return jsonify({"message": "Turnstile validation successful!"}), 200
    return jsonify({"error": "Missing token"}), 400

if __name__ == "__main__":
    app.run(debug=True, host="0.0.0.0", port=5000)
