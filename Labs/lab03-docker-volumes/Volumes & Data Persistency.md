## Objective
Understand data persistence with volumes.

### What is Docker Volume?
A Docker volume is a persistent storage mechanism that allows data to exist independently of a container’s lifecycle.

It stores data outside the container’s filesystem, so the data remains even if the container is stopped or deleted.

---

### Step 1: Demonstrate Data Loss Without Volumes

```bash
# Run container and create data
docker run -it --name temp-container alpine sh

# Inside container:
echo "Important data!" > /data.txt
cat /data.txt
exit

# Remove container
docker rm temp-container

# Try to find the data - IT'S GONE!
```

**Problem:** Data is lost when the container is deleted!

---

### Step 2: Create a Named Volume

```bash
# Create volume
docker volume create my-data

# List volumes
docker volume ls

# Inspect volume
docker volume inspect my-data
```

---

### Step 3: Use Volume for Persistence

```bash
# Run container with volume
docker run -it --name persistent-container \
  -v my-data:/app/data \
  alpine sh

# Inside container:
cd /app/data
echo "This will persist!" > important.txt
echo "Even after container deletion!" >> important.txt
cat important.txt
exit
```
---

### Step 4: Verify Data Persists

```bash
# Remove the container
docker rm persistent-container

# Create NEW container with SAME volume
docker run -it --name new-container \
  -v my-data:/app/data \
  alpine sh

# Inside NEW container:
cd /app/data
cat important.txt
# DATA IS STILL THERE!
exit
```
---

### Step 5: Bind Mount Example (Development)

```bash
# Create a directory on host
mkdir ~/docker-demo
cd ~/docker-demo
echo "Hello from host!" > index.html

# Mount host directory into container
docker run -d --name web-server \
  -v $(pwd):/usr/share/nginx/html \
  -p 8080:80 \
  nginx

# Visit http://localhost:8080
# You'll see your HTML file!

# Edit file on host
echo "<h1>Updated from host!</h1>" > index.html

# Refresh browser - changes appear immediately!

# Cleanup
docker stop web-server
docker rm web-server
```
---

### Step 6: Volume Cleanup

```bash
# List volumes
docker volume ls

# Remove specific volume
docker volume rm my-data

# Remove all unused volumes
docker volume prune
```
<br>

✅ **Lab 3 is Completed!**  
Volumes persist data across containers throughout the whole lifecycle!


---
