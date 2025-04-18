# Use Python base image
FROM python:3.9-slim

# Set the working directory
WORKDIR /app

# Copy dependency files first (best practice for caching)
COPY requirements.txt .

# Install dependencies
RUN pip install -r requirements.txt

# Copy the rest of the app
COPY . .

# Run database migrations
RUN python manage.py migrate

# Expose the Django port
EXPOSE 8000

# Start the Django server
CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]
