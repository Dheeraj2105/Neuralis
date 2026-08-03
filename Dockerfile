# Use Python 3.10 base image
FROM python:3.10-slim

# Set working directory
WORKDIR /app

# Install system dependencies
RUN apt-get update && apt-get install -y \
    nodejs \
    npm \
    gcc \
    g++ \
    libglib2.0-0 \
    libsm6 \
    libxext6 \
    libxrender-dev \
    libgomp1 \
    libgl1 \
    && rm -rf /var/lib/apt/lists/*

# Copy backend requirements and install Python dependencies
COPY backend/requirements.txt /app/
RUN pip install --no-cache-dir -r requirements.txt

# Copy React frontend
COPY parkinsons-prediction-app /app/frontend

# Build React app
WORKDIR /app/frontend
RUN npm install --legacy-peer-deps
RUN npm run build

# Copy backend code
WORKDIR /app
COPY backend /app/backend

# Create necessary directories
RUN mkdir -p /app/backend/models \
    /app/backend/generated_reports \
    /app/backend/temp_files \
    /app/static

# Move built React files to static folder for Flask to serve
RUN cp -r /app/frontend/dist/* /app/static/ || cp -r /app/frontend/build/* /app/static/

# Copy models (if you have them locally)
COPY backend/models/ /app/backend/models/

# Set environment variables
ENV PORT=7860
ENV PYTHONUNBUFFERED=1

# Expose port 7860 (HF Spaces requirement)
EXPOSE 7860

# Run the Flask application
CMD ["python", "backend/app.py"]
