# Use a lightweight base image with Python + Node.js
FROM nikolaik/python-nodejs:python3.10-nodejs19

# Set working directory
WORKDIR /app

# Install system dependencies (ffmpeg is often required for PyTgCalls)
RUN apt-get update && \
    apt-get install -y --no-install-recommends ffmpeg && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Copy project files into container
COPY . .

# Install Python dependencies
RUN pip install --no-cache-dir -U -r requirements.txt

# Render automatically runs CMD, not bash scripts — define explicitly
# You can replace 'start.py' with your actual bot starter script.
CMD ["python3", "start.py"]