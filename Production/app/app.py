import os
from flask import Flask

app = Flask(__name__)

@app.route('/')
def hello():
    return os.environ.get("MESSAGE", "Hello from CLOUDRUN -- PRODUCTION!")