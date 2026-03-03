## 🐳 Docker Fundamentals

Before building real-world applications with Docker, you need to understand four core building blocks:

- 📦 Images  
- 🏃 Containers  
- 💾 Volumes  
- 🌐 Networks  

Let’s break them down.

---

### 📦 Docker Images

A **Docker Image** is a read-only blueprint used to create containers.

It contains:
- Application code
- Runtime (Node, Python, etc.)
- Dependencies
- System libraries
- Environment configuration

**Images are built using a `Dockerfile`**

You can:

```bash
docker pull nginx
docker build -t my-app .
docker images
```
---

### 🏃 Containers

A Container is a running instance of an image.

It is:

- Lightweight

- Isolated

- Fast to start

- Ephemeral by default (data is lost if not persisted)

**Run a container:**

```bash
docker run -d -p 8080:80 nginx
docker ps
docker stop <container_id>
```

**Multiple containers can be created from the same image.**

---

### 💾 Volumes

Containers are temporary by default.
If a container is deleted, its data is lost.

Volumes solve this problem.

**A volume:**

- Stores persistent data

- Lives outside the container lifecycle

- Can be shared between containers

Example:

```bash
docker volume create my-data
docker run -v my-data:/app/data my-app
```

**Use volumes for:**

- Databases

- Logs

- Uploaded files

- Application state

---

### 🌐 Networks

By default, containers are isolated — even from each other.

Docker Networks allow containers to communicate securely.

**Common network types:**

- `bridge` (default)

- `host`

- `none`


**Create and use a custom network:**

```bash
docker network create my-network
docker run --network my-network --name app1 my-app
docker run --network my-network --name app2 my-app
```

Now `app1` can talk to `app2` using container names as hostnames.

---

### 🧠 How They Work Together

In a real-world setup:

- Image → Defines the app

- Container → Runs the app

- Volume → Stores the data

- Network → Connects services

Example:

- A Node.js container

- A MongoDB container

- A shared volume for database data

- A custom network connecting both

That’s the foundation of Docker 🚀


**In the next lab, you’ll build and run your first custom image.**

Happy Learning Docker :)

