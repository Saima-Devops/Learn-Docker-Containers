# 🧪 Lab-02– Docker Cleanup & Disk Management

## 🎯 Objective

In this lab, you will learn how to:

- Inspect Docker disk usage
- Remove stopped containers
- Remove unused images
- Remove unused volumes
- Remove unused networks
- Perform safe system-wide cleanup

By the end of this lab, you’ll understand how to manage Docker storage efficiently.

---

## 📊 Step 1 – Check Docker Disk Usage

Before deleting anything, inspect what is consuming space:

```bash
docker system df
```

This shows:

- Images size

- Containers size

- Local volumes size

- Build cache usage

For more detailed output:

```bash
docker system df -v
```
---

## 🧹 Step 2 – Remove Stopped Containers

List all containers:

```bash
docker ps -a
```

Remove all stopped containers:

```bash
docker container prune
```

✔ Removes:

- Containers with status Exited

- Containers created but never started

❌ Does NOT remove:

- Running containers

- Images

- Volumes

---

## 🧼 Step 3 – Remove Unused Images

Remove dangling images:

```bash
docker image prune
```

Remove all unused images (be careful):

```bash
docker image prune -a
```

✔ Removes:

- Images not used by any container

❌ Does NOT remove:

- Images tied to running containers

---

## 💾 Step 4 – Remove Unused Volumes

List volumes:

```bash
docker volume ls
```

Remove unused volumes:

```bash
docker volume prune
```

### ⚠️ Warning:

- Volumes often store database data.
- Deleting unused volumes may permanently delete important data.

---

## 🌐 Step 5 – Remove Unused Networks

List networks:

```bash
docker network ls
```

Remove unused networks:

```bash
docker network prune
```

---

## 🧠 Understanding Docker Storage

**Docker stores data in:**

- /var/lib/docker (Linux)

- Docker Desktop VM (Mac/Windows)


Over time, unused images and containers accumulate and consume space.

**Regular cleanup helps:**

- Improve performance

- Free disk space

- Keep development environments clean

---

## 🎯 Challenge Section

1. Create 3 containers and stop them.

2. Build an image multiple times to generate dangling images.

3. Check disk usage using docker system df.

4. Clean everything using docker system prune -a.

5. Verify that space has been freed.

---

## 🏁 Final Check

Run:

```bash
docker system df
```

You should see significantly reduced disk usage.


🎉 Congratulations! You now know how to safely manage Docker storage.

<br>
Next, we’ll move into building custom images with Dockerfiles.
