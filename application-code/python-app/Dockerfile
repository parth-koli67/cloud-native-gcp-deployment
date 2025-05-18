# Use an official Python runtime as a parent image
FROM python:3

# Set the working directory in the container
WORKDIR /app

# Copy the application code into the container
COPY . /app

# Install any dependencies (e.g., from requirements.txt)
# If you don't have a requirements.txt, create one with:
# pip freeze > requirements.txt
RUN pip install --no-cache-dir -r requirements.txt

LABEL com.googleapis.cloudmarketplace.product.service.name=services/mp-k8s-amer-poc-1

# Expose port 5000 to the outside world
EXPOSE 5000

# Set environment variables (optional, but good practice)
ENV FLASK_APP=main.py
ENV FLASK_RUN_HOST = 0.0.0.0  # Listen on all interfaces

# Command to run the application
CMD ["gunicorn", "--bind", "0.0.0.0:5000", "main:app"]
