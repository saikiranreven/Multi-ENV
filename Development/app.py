from flask import Flask

app = Flask(__name__)

@app.route('/')
def welcome():
    return """
    <html>
        <head>
            <title>Welcome</title>
            <style>
                body {
                    font-family: Arial, sans-serif;
                    text-align: center;
                    margin-top: 100px;
                    background-color: #f0f8ff;
                }
                h1 {
                    color: #2c3e50;
                }
            </style>
        </head>
        <body>
            <h1>Welcome to Our Service!</h1>
            <p>This is a custom welcome message served from Cloud Run</p>
        </body>
    </html>
    """

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=int(os.environ.get('PORT', 8080)))