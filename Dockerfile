# Use combined Python + NodeJS image
FROM nikolaik/python-nodejs:python3.10-nodejs20-slim

# Set working directory
WORKDIR /app

# Copy requirements first for caching
COPY requirements.txt .

# Fix outdated APT sources and install dependencies
RUN sed -i 's|deb.debian.org|archive.debian.org|g' /etc/apt/sources.list \
 && sed -i 's|security.debian.org|archive.debian.org|g' /etc/apt/sources.list \
 && apt-get clean && apt-get update -o Acquire::Check-Valid-Until=false -o Acquire::AllowInsecureRepositories=true \
 && apt-get install -y --no-install-recommends \
      ffmpeg \
      git \
      curl \
 && rm -rf /var/lib/apt/lists/*

# Upgrade pip & install dependencies
RUN pip install --no-cache-dir --upgrade pip \
 && pip install --no-cache-dir -r requirements.txt

# Copy rest of the project
COPY . .

# Set environment variables (optional)
ENV PYTHONUNBUFFERED=1 \
    PIP_NO_CACHE_DIR=1 \
    NODE_ENV=production

# Expose your app port (if bot uses webhooks)
EXPOSE 8080

# Start command
CMD ["python3", "main.py"]