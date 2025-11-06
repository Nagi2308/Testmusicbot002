# Use an updated Python + Node.js image (Debian Bullseye base)
FROM nikolaik/python-nodejs:python3.10-nodejs20-bullseye

# Set working directory
WORKDIR /app

# Copy all project files
COPY . .

# Install system dependencies
RUN apt-get update && \
    apt-get install -y --no-install-recommends ffmpeg && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Upgrade pip & install dependencies
RUN pip install --upgrade pip && \
    pip install -r requirements.txt

# Optional: for PyTgCalls stability
RUN pip install pytgcalls==0.9.0

# Expose bot port (if any webhooks)
EXPOSE 8080

# Set environment (important for Render/Heroku)
ENV PYTHONUNBUFFERED=1

# Start the bot
CMD ["python3", "main.py"]