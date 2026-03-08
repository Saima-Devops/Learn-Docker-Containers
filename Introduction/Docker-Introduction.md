# What is Docker?

**Docker** is a core tool in DevOps for building, shipping, and running applications in **containers**. Its architecture has several basic components that work together.
<br>


-----

## 📦 What Are Containers and How Do They Work?

### 🧱 What Is a Container?

A **container** is a lightweight, standalone package that includes:
- Application code
- Runtime (e.g., Node, Python, Java)
- System tools
- Libraries
- Dependencies
- Configuration

Everything the application needs to run is bundled together.

👉 This means the application runs the same way everywhere — on your laptop, on a server, or in the cloud.

---

### 🖥️ Why Not Just Install Software Normally?

Traditionally:
- Applications depend on specific versions of libraries.
- Different environments (dev, test, prod) behave differently.
- “It works on my machine” becomes a common problem.

Containers solve this by packaging the entire runtime environment.

---

### ⚙️ How Containers Work (Under the Hood)

Containers use features built into the operating system:

- **Namespaces** → Isolate processes (so containers don’t see each other)
- **Control Groups (cgroups)** → Limit CPU and memory usage
- **Union file systems** → Make images lightweight and layered

Unlike virtual machines:
- Containers share the host OS kernel.
- They are much lighter and start in seconds.

---

### 🐳 Containers vs Virtual Machines

| Containers | Virtual Machines |
|------------|------------------|
| Share host OS kernel | Include full OS |
| Lightweight | Heavy |
| Start in seconds | Take minutes |
| Ideal for microservices | Ideal for full OS isolation |

---

### 🏗️ Key Concepts

- **Image** → Blueprint (read-only template)
- **Container** → Running instance of an image
- **Docker Engine** → Tool that builds and runs containers

Think of it like this:

> 🧁 Image = Recipe  
> 🍰 Container = Cake made from the recipe  

---

### 🎯 Why Containers Matter

- Consistent environments
- Faster deployments
- Easier scaling
- Better resource utilization
- Simplified CI/CD pipelines

---

## Basic Components of Docker


## 1️⃣ Docker Client


<img width="3000" height="3000" alt="how-does-docker-work-01" src="https://github.com/user-attachments/assets/d60d610c-d47a-454f-a638-d83d8f07ece2" />

<img width="1233" height="651" alt="docker-architecture-01" src="https://github.com/user-attachments/assets/144ee1e4-b78c-4daa-aeab-0e73c2be633a" /><br>


The **Docker Client** is the interface developers use to interact with Docker.

- Usually the `docker` CLI command

- Sends commands to the Docker daemon

- Can run locally or connect to a remote Docker server

**Example commands:**
```bash
docker build
docker pull
docker run
docker ps
```

**Example:**
```bash
docker run nginx
```
This tells Docker to start an Nginx container.

-----

## 2️⃣ Docker Daemon (Docker Engine)

<img width="1009" height="527" alt="Docker_Architecture_Diagram_-02" src="https://github.com/user-attachments/assets/1df2fbec-85a5-42c0-9905-edc9d72592f8" />

<img width="800" height="517" alt="docker-arch-02" src="https://github.com/user-attachments/assets/0072d606-a0f1-4722-beea-0bba36c15485" />

The **Docker Daemon (dockerd)** is the background service that actually manages Docker.

### Responsibilities:

- Builds images

- Runs containers

- Manages networks

- Manages storage volumes

- Communicates with Docker registries

```bash
Docker Client → Docker Daemon → Containers
```
-----

## 3️⃣ Docker Images

<img width="711" height="632" alt="docker-filesystem-arch" src="https://github.com/user-attachments/assets/d41dacfb-6a29-4464-8708-e3054ee2e3ff" />

<img width="787" height="633" alt="docker-works-3" src="https://github.com/user-attachments/assets/30ec2f81-93d7-4e3d-ab05-f3bccf2d9207" /><br>


**A Docker Image is a read-only template used to create containers.**

It includes:

- Application code

- Runtime (Python, Node, Java, etc.)

- Libraries

- Environment configuration

- Images are layered to improve performance and reuse.

**Example:**

```bash
docker pull nginx
```

This downloads the Nginx image.

Images are usually created using a Dockerfile.

-----

## 4️⃣ Docker Containers

<img width="1085" height="625" alt="vm-dockCont" src="https://github.com/user-attachments/assets/95009f80-4d6b-42b9-835a-9c132a4570c8" /><br>


**A Docker Container is a running instance of a Docker image.**

### Characteristics:

- Lightweight

- Isolated environment

- Runs applications consistently across systems

**Example:**

```bash
docker run -d -p 80:80 nginx
```

This runs an Nginx container in the background.

> You can run multiple containers from the same image.

-----

## 5️⃣ Docker Registry


<img width="1468" height="840" alt="taxonomy-of-docker-terms-and-concepts" src="https://github.com/user-attachments/assets/75a1c083-b147-419a-9790-45047994f1c0" />
<br>

**A Docker Registry stores Docker images.**

### Popular registries:

- Docker Hub

- Amazon Elastic Container Registry

- Google Container Registry

- GitHub Container Registry

<br>

### Common operations:

```bash
docker pull nginx
docker push myimage:1.0
```

<img width="675" height="242" alt="shared" src="https://github.com/user-attachments/assets/d39284f7-b4bb-4f5f-bb40-fba71631e77d" />

<img width="675" height="357" alt="pub;ic-priv" src="https://github.com/user-attachments/assets/cf09e919-ed38-4e2c-9aa8-f9c43b8e2459" />

-----

In the next lab, you'll run your first container and see this in action 🚀

- Labs/lab-01-docker-basics (https://github.com/Saima-Devops/Learn-Docker-Containers/tree/main/Labs)
