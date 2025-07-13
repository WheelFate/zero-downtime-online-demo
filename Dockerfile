# Dockerfile
# This file defines how our application is packaged into a Docker container.

# Use a lightweight Python base image based on Debian Bullseye (a newer, supported release)
FROM python:3.9-slim-bullseye

# Install curl inside the container.
# We first update the package lists and then install curl.
# rm -rf /var/lib/apt/lists/* cleans up the package lists to keep the image size small.
RUN apt-get update && apt-get install -y curl --no-install-recommends && rm -rf /var/lib/apt/lists/*

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
