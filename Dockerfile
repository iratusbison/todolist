# Use Python base image
FROM python:3.12-slim

# Set environment variables
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

# Set the working directory
WORKDIR /app

# Install dependencies
COPY requirements.txt .  
RUN pip install --no-cache-dir -r requirements.txt  

# Copy project files
COPY . .

# Run migrations and collect static files
RUN python manage.py migrate && python manage.py collectstatic --noinput

# Expose the port (used in Kubernetes)
EXPOSE 8000

# Start the server
CMD ["gunicorn", "todo_project.wsgi:application", "--bind", "0.0.0.0:8000"]
