# src/app.py
# This is a very simple Flask web application.
from flask import Flask
import os

# Create a Flask web application instance
app = Flask(__name__)

# Define the application version. We'll get this from an environment variable
# during deployment, so we can see which version is "running".
APP_VERSION = os.getenv("APP_VERSION", "v1.0.0 (Initial Online Demo)")

# Define a route for the root URL ("/")
@app.route('/')
def hello_world():
    # This function returns a message including the current application version.
    return f"Hello from our Zero-Downtime Online Demo! This is {APP_VERSION}"

# Define a health check endpoint ("/health")
@app.route('/health')
def health_check():
    # This endpoint is used to check if the application is running and responsive.
    return "OK", 200 # Returns "OK" with a 200 HTTP status code

# This block runs the Flask development server when the script is executed directly.
# In a real deployment, a production-ready server like Gunicorn (which we'll use in Docker)
# would be used instead of app.run().
if __name__ == '__main__':
    # Run the app, listening on all network interfaces (0.0.0.0) on port 5000.
    app.run(host='0.0.0.0', port=5000)
