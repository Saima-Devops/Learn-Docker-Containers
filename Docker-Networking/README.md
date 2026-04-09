# Docker Networking Overview

Docker networking allows containers to communicate with each other, the host, and the outside world. Think of containers as little houses, and networking as the roads connecting them.

## Types of Docker Networks

### 1. Bridge Network (Default)

- **Description:** Private neighborhood for containers.
- **IP Address:** Each container gets its own private IP.
- **Communication:** Containers can talk to each other using IP or container name.
- **External Access:** Requires port mapping to access services from the host.
- **Use Case:** Default network for most containers; isolated environment.

**Example:**
```bash
docker run -p 8080:80 my-container
# Access service at localhost:8080
```

-----

### 2. Host Network

- **Description:** Shares the host’s network directly.
- **IP Address:** Container uses the host’s IP.
- **Isolation:** Low (less isolated from host).
- **Performance:** High, no network translation overhead.
- **Use Case:** High-performance apps needing direct host access.

------

### 3. Overlay Network

- **Description:** Network that spans multiple Docker hosts.
- **Use Case:** For Docker Swarm or multi-host clusters (Kubernetes)
- **Benefit:** Multi-Host Communication. Enables container communication across different machines automatically.

------

### 4. None Network

- **Description:** No network connection.
- **Use Case:** Isolated tasks or security testing.

------

## How Containers Communicate

**Container → Container** (same network):  Use container name or IP.\
**Container → Host**:  Use host IP or port mapping (if on bridge network).\
**Container → Internet**:  Access via NAT on bridge networks (default).

------

## Custom Bridge Network in Docker

Docker allows you to create **custom bridge networks** to improve container communication, isolation, and control over IP addressing.

### Why Use a Custom Bridge Network?
- Containers can **communicate by name** without port mapping.
- Provides **better isolation** from other containers.
- Allows custom **IP subnets and gateways**.
- Useful when running **multiple projects** on the same host.

------

### Creating a Custom Bridge Network

#### 1. Create the network:

```bash
docker network create \
  --driver bridge \
  --subnet 172.25.0.0/16 \
  my_custom_network
```

- `--driver bridge` → Specifies a bridge network.
- `--subnet` → Optional; defines IP range for containers.
- `my_custom_network` → The name of your custom network.

------

#### 2. Run containers on this network:

```bash
docker run -d --name webapp --network my_custom_network nginx
docker run -d --name db --network my_custom_network mysql
```

- Containers on the same network can communicate using container names.
- Port mapping is not needed for internal communication.
  
------

#### 3. Inspect the network:

```bash
docker network inspect my_custom_network
```

- Displays connected containers, subnet, gateway, and other settings.

- Managing Containers on Custom Networks

**How to Connect an existing container to a network:**

```bash  
docker network connect my_custom_network existing_container
```

**How to Disconnect a container from a network:**

```bash
docker network disconnect my_custom_network existing_container
```

-----

### Benefits

- Name-based DNS: Containers can refer to each other by name.
- Isolation: Only containers on the same network can communicate.
- Custom IPs: Avoid conflicts with other networks.
- Reusable: Easily attach multiple containers from a project.

-----
