# Base image with Python 3.10 + Node.js 19
FROM nikolaik/python-nodejs:python3.10-nodejs19

# Set working directory
WORKDIR /app

# Copy requirements first for caching
COPY requirements.txt .

# Install system dependencies
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    ffmpeg \
    git \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Upgrade pip and install dependencies
RUN pip install --no-cache-dir --upgrade pip && \
    pip install --no-cache-dir -r requirements.txt

# ✅ Correct PyTgCalls install
RUN pip install --no-cache-dir py-tgcalls==2.2.8

# Copy all project files
COPY . .

# Optional: expose web port if you have Flask or web status page
EXPOSE 8080

# Set environment variables
ENV PYTHONUNBUFFERED=1 \
    PYTHONDONTWRITEBYTECODE=1

# Start command for Render
CMD ["bash", "start"]