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

**Description:** Shares the host’s network directly.
**IP Address:** Container uses the host’s IP.
**Isolation:** Low (less isolated from host).
**Performance:** High, no network translation overhead.
**Use Case:** High-performance apps needing direct host access.

------

### 3. Overlay Network

**Description:** Network that spans multiple Docker hosts.
**Use Case:** For Docker Swarm or multi-host clusters (Kubernetes)
**Benefit:** Multi-Host Communication. Enables container communication across different machines automatically.

------

### 4. None Network
**Description:** No network connection.
**Use Case:** Isolated tasks or security testing.

------

## How Containers Communicate

**Container → Container** (same network):  Use container name or IP.\
**Container → Host**:  Use host IP or port mapping (if on bridge network).\
**Container → Internet**:  Access via NAT on bridge networks (default).

------
