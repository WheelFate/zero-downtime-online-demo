# Dockerfile
# This file defines how our application is packaged into a Docker container.

# Use a lightweight Python base image
FROM python:3.9-slim-buster

# Set the working directory inside the container to /app
WORKDIR /app

# Copy the requirements file from our project into the container's /app directory
COPY src/requirements.txt .

# Install the Python dependencies listed in requirements.txt
# --no-cache-dir ensures that pip doesn't store downloaded packages, keeping the image smaller.
RUN pip install --no-cache-dir -r requirements.txt

# Copy the rest of our application code from src/ into the container's /app directory
COPY src/ .

# Inform Docker that the container will listen on port 5000 at runtime
EXPOSE 5000

# Define the command to run when the container starts.
# We use Gunicorn to run our Flask application ('app:app' refers to the Flask instance named 'app'
# within the 'app.py' file). It binds to all network interfaces on port 5000.
CMD ["gunicorn", "--bind", "0.0.0.0:5000", "app:app"]
