
# Lab-1: Security & Resource Management

### Objective
Implement production security and resource controls.

---

### Step 1: Create Project Structure

```bash
mkdir flask-postgres-app-sec && cd flask-postgres-app-sec
```
---

### Step 2: Create Flask Application

Create `app.py`:
```python
from flask import Flask, jsonify

app = Flask(__name__)

@app.route("/")
def home():
    return jsonify({"message": "Hello from Flask inside Docker!"})

@app.route("/health")
def health():
    return jsonify({"status": "ok"})

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)
```
---

### Step 3: Create Requirements File

Create `requirements.txt`:
```
flask==3.0.0
```
---

### Step 4: Create Dockerfile

Create `Dockerfile.secure`:
```dockerfile
FROM python:3.9-alpine

# Create non-root user
RUN addgroup -g 1000 appgroup && \
    adduser -D -u 1000 -G appgroup appuser

WORKDIR /app

# Install dependencies as root
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy app
COPY app.py .

# Switch to non-root user
USER appuser

EXPOSE 5000

CMD ["python", "app.py"]
```
---

### Step 5: Build the Image

```bash
docker build -f Dockerfile.secure -t flask-app .
```
---

### Step 6: Verify the Image

```bash
docker images | grep flask-app
```
---

### Step 7: Run the Container

```bash
docker run -d --name myflask -p 5000:5000 flask-app
```
---

### Step 8: Exec into the Container

```bash
# Open a shell inside the running container
docker exec -it myflask /bin/bash

# Once inside, try these:
ls
cat app.py
whoami
python --version
exit
```
---

### Step 9: Resource-Limited Compose

Create `docker-compose.secure.yml`:
```yaml
version: '3.8'

services:
  app:
    build:
      context: .
      dockerfile: Dockerfile.secure
    read_only: true
    security_opt:
      - no-new-privileges:true
    deploy:
      resources:
        limits:
          cpus: '1.0'
          memory: 512M
        reservations:
          cpus: '0.5'
          memory: 256M
    restart: unless-stopped
    healthcheck:
      test: ["CMD", "python", "-c", "import requests; requests.get('http://localhost:5000/health')"]
      interval: 30s
      timeout: 3s
      retries: 3
```
---

### Step 10: Test Resource Limits

```bash
# Run with limits
docker run -d \
  --name limited-app \
  --memory="256m" \
  --cpus="0.5" \
  python:3.9-alpine sleep 3600

# Check stats
docker stats limited-app

# Try to exceed memory (will be killed)
docker exec limited-app sh -c 'python -c "s = \"a\" * 10**9"'

# Clean up
docker stop limited-app && docker rm limited-app
```

✅ Lab 2 is Completed!

> Security and Resource Controls Mastered!

---
