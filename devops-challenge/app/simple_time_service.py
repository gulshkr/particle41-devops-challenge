from flask import Flask, request
import datetime

app = Flask(__name__)

@app.route('/')
def get_time():
    now = datetime.datetime.now().isoformat()
    ip = request.remote_addr or 'unknown'
    return {
        "timestamp": now,
        "ip": ip
    }

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=8080, debug=False)
