# 🧪 Lab 01 – Docker Basics - Hands-on Lab Guide

## 🎯 Objective

In this lab, you will:

- Run your first container
- Understand images vs containers
- Explore basic Docker commands
- Remove containers and images

By the end of this lab, you’ll be comfortable running and managing containers.

---

## Pre-Lab Checklist

Before starting, ensure:
- ✅ Docker is installed and running
- ✅ You can run: `docker --version`
- ✅ You have an internet connection
- ✅ Terminal/Command Prompt is open

---

## 🛠️ Step 1 – Verify Docker Installation

Check if Docker is installed:

```bash
docker --version
```

Check if Docker is running:
```bash
docker info
```
---

## Lab 1: Pull Your First Image

### Objective

📦 Learn to pull and run a pre-built container, then interact with it through your browser.

### Step 1: Pull the nginx Image

```bash
docker pull nginx:alpine
```

**Expected Output:**
```
alpine: Pulling from library/nginx
...
Status: Downloaded newer image for nginx:alpine
```

**What's happening?**
- Downloads the nginx web server image from Docker Hub
- `alpine` is a lightweight Linux distribution
- Image is very small! (check the size)

---

### 🏃 Step 2: Run Your First Container
```bash
docker run -d -p 8080:80 --name my-nginx nginx:alpine
```

**Command breakdown:**
- `-d` = detached mode (runs in background)
- `-p 8080:80` = map host port 8080 to container port 80
- `--name my-nginx` = give container a friendly name
- `nginx:alpine` = the image to use

**Expected Output:**
```
a1b2c3d4e5f6... (container ID)
```
---

### Step 3: Verify Container is Running

```bash
docker ps
```

**Expected Output:**
```
CONTAINER ID   IMAGE          COMMAND                  CREATED         STATUS         PORTS                  NAMES
a1b2c3d4e5f6   nginx:alpine   "/docker-entrypoint.…"   10 seconds ago  Up 9 seconds   0.0.0.0:8080->80/tcp   my-nginx
```
---

### 🌐 Step 4: Access via Browser

Open your browser and visit: **http://localhost:8080** 

✅ **Success Criteria**: You should see "Welcome to nginx!" page 🎉

---

### 🔍 Step 5: Inspect the Container

View Container Logs:

```bash
docker logs my-nginx
```

**Expected Output:**
```
/docker-entrypoint.sh: Launching /docker-entrypoint.d/...
...
nginx: [notice] start worker processes
```

Inspect container details:

```bash
docker inspect my-nginx
```

View running processes inside the container:
```bash
docker exec -it my-nginx bash
```

Inside the container:
```bash
ls /usr/share/nginx/html
exit
```
---

### 🛑 Step 6: Stop the Container

```bash
docker stop my-nginx
```

**Verify it stopped:**
```bash
docker ps
```

Should show no running containers.

---

### Step 7: View All Containers (Including Stopped)

```bash
docker ps -a
```

You'll see `my-nginx` with STATUS "Exited"

---

### 🧹 Step 8: Remove the Container

```bash
docker rm my-nginx
```

**Verify removal:**
```bash
docker ps -a
```

`my-nginx` should be gone.

---

### 🧹 Step 9: Remove the Image (Optional)

```bash
docker rmi nginx
```


### ✅ Lab 1 is Completed!
You've successfully pulled, run, accessed, stopped, and removed a Docker container.

---

## 🧠 Key Takeaways

- Images are blueprints.

- Containers are running instances of images.

- Containers are isolated.

- Port mapping exposes container services to your machine.

- Containers are temporary unless data is persisted.

---

## 🎯 Challenge Section

1. Run an Apache (`httpd`) container on port `9090`.
2. Run two Nginx containers at the same time on different ports.
3. Rename a container.
4. Use `docker stats` to monitor resource usage.

---

## 🚀 Bonus Exploration

Try:
```bash
docker container prune
docker image prune
```

Understand what they do before running them.


