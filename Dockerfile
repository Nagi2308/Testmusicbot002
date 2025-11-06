# Base image with Python 3.10 + Node.js 19
FROM nikolaik/python-nodejs:python3.10-nodejs19

# Set working directory
WORKDIR /app

# Copy dependency files first for build cache
COPY requirements.txt .

# Install system dependencies (FFmpeg etc.)
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    ffmpeg \
    git \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Upgrade pip and install dependencies
RUN pip install --no-cache-dir --upgrade pip && \
    pip install --no-cache-dir -r requirements.txt

# Copy the full project into the container
COPY . .

# Expose port (optional if your bot runs a web server)
EXPOSE 8080

# Set environment variables
ENV PYTHONUNBUFFERED=1 \
    PYTHONDONTWRITEBYTECODE=1

# Start your bot
CMD ["bash", "start"]