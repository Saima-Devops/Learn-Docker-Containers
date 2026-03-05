# Lab-01: Docker Hub and Docker Compose

**Objective**: Master Docker Hub operations and build production-ready multi-container applications

---

## Pre-Lab Checklist

Before starting, ensure:
- ✅ Docker is installed and running
- ✅ Completed Session 1 successfully
- ✅ Docker Hub account created and verified
- ✅ Internet connection active
- ✅ Terminal/Command Prompt open

---

## Lab 1: Docker Hub Operations

### Objective
Learn the complete workflow: build → tag → push → pull from Docker Hub

### Step 1: Login to Docker Hub

```bash
docker login
```

**Prompts:**
```
Username: <your-docker-id>
Password: <your-password>
```

**Expected Output:**
```
Login Succeeded

Logging in with your password grants your terminal complete access to your account.
For better security, log in with a limited-privilege personal access token.
```

✅ **Success:** You're now authenticated!

---

### Step 2: Create a Simple Application

```bash
mkdir docker-hub-demo && cd docker-hub-demo
```

Create `app.py`:
```python
from datetime import datetime

def main():
    print("=" * 50)
    print("Hello from Docker Hub!")
    print(f"Current time: {datetime.now()}")
    print(f"This image was pulled from Docker Hub")
    print("=" * 50)

if __name__ == "__main__":
    main()
```

Create `Dockerfile`:
```dockerfile
FROM python:3.9-alpine

WORKDIR /app

COPY app.py .

CMD ["python", "app.py"]
```

---

### Step 3: Build the Image

```bash
docker build -t hub-demo-app .
```

**Expected Output:**
```
[+] Building 5.2s (8/8) FINISHED
 => [1/3] FROM docker.io/library/python:3.9-alpine
 => [2/3] WORKDIR /app
 => [3/3] COPY app.py .
 => exporting to image
Successfully built abc123def456
Successfully tagged hub-demo-app:latest
```

Test locally:
```bash
docker run hub-demo-app
```

---

### Step 4: Tag for Docker Hub

**Important:** Replace `YOUR-USERNAME` with your actual Docker Hub username!

```bash
# Tag with version
docker tag hub-demo-app:latest YOUR-USERNAME/hub-demo-app:v1.0

# Tag as latest
docker tag hub-demo-app:latest YOUR-USERNAME/hub-demo-app:latest

# Tag with date
docker tag hub-demo-app:latest YOUR-USERNAME/hub-demo-app:$(date +%Y%m%d)
```

Verify tags:
```bash
docker images | grep hub-demo-app
```

**Expected Output:**
```
YOUR-USERNAME/hub-demo-app    v1.0        abc123...   2 min ago   52MB
YOUR-USERNAME/hub-demo-app    latest      abc123...   2 min ago   52MB
YOUR-USERNAME/hub-demo-app    20260206    abc123...   2 min ago   52MB
hub-demo-app                  latest      abc123...   2 min ago   52MB
```

----

### Step 5: Push to Docker Hub

```bash
docker push YOUR-USERNAME/hub-demo-app:v1.0
docker push YOUR-USERNAME/hub-demo-app:latest
docker push YOUR-USERNAME/hub-demo-app:$(date +%Y%m%d)
```

**Expected Output:**
```
The push refers to repository [docker.io/YOUR-USERNAME/hub-demo-app]
5f70bf18a086: Pushed
v1.0: digest: sha256:abc123... size: 1234
```

----

### Step 6: Verify on Docker Hub Website

1. Open browser: https://hub.docker.com
2. Login with your credentials
3. Click "Repositories"
4. You should see `hub-demo-app`
5. Click on it to view:
   - All tags (v1.0, latest, date)
   - Image size
   - Last updated time

✅ **Success Criteria:** Your image is public on Docker Hub!

---

### Step 7: Simulate Pulling from Another Machine

Remove all local copies:
```bash
docker rmi -f YOUR-USERNAME/hub-demo-app:v1.0
docker rmi -f YOUR-USERNAME/hub-demo-app:latest
docker rmi -f YOUR-USERNAME/hub-demo-app:$(date +%Y%m%d)
docker rmi -f hub-demo-app:latest
```

Verify they're gone:
```bash
docker images | grep hub-demo-app
```

Now pull from Docker Hub:
```bash
docker pull YOUR-USERNAME/hub-demo-app:v1.0
```

**Expected Output:**
```
v1.0: Pulling from YOUR-USERNAME/hub-demo-app
...
Status: Downloaded newer image for YOUR-USERNAME/hub-demo-app:v1.0
docker.io/YOUR-USERNAME/hub-demo-app:v1.0
```

Run the pulled image:
```bash
docker run YOUR-USERNAME/hub-demo-app:v1.0
```

----

### Step 8: Clean Up

```bash
docker logout
cd ..
rm -rf docker-hub-demo
```

### ✅ Lab 1 is Completed!
You've mastered the Docker Hub workflow: **build → tag → push → pul
