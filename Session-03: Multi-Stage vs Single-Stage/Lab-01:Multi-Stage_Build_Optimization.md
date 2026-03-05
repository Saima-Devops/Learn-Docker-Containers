# Lab 1: Multi-Stage Build Optimization

**Objective**: Master production patterns and deploy AI applications

---

## Pre-Lab Checklist

Before starting, ensure:
- ✅ Docker is running (4GB+ RAM allocated)
- ✅ Completed Sessions 1 & 2
- ✅ 10GB+ free disk space
- ✅ Internet connection for downloading models
- ✅ Terminal/Command Prompt open

---

## Lab 1: Multi-Stage Build Optimization

### Objective
Transform a bloated single-stage image into an optimized multi-stage build.

### Step 1: Create a Go Application

```bash
mkdir go-multistage && cd go-multistage
```

Create `main.go`:
```go
package main

import (
    "fmt"
    "log"
    "net/http"
    "time"
)

func handler(w http.ResponseWriter, r *http.Request) {
    html := `
    <!DOCTYPE html>
    <html>
    <head>
        <title>Optimized Go App</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                max-width: 600px;
                margin: 100px auto;
                padding: 20px;
                text-align: center;
                background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                color: white;
            }
            .container {
                background: rgba(255,255,255,0.1);
                padding: 40px;
                border-radius: 15px;
                backdrop-filter: blur(10px);
            }
        </style>
    </head>
    <body>
        <div class="container">
            <h1>🚀 Multi-Stage Build Success!</h1>
            <p>This is a highly optimized Docker image</p>
            <p>Build time: %s</p>
        </div>
    </body>
    </html>
    `
    fmt.Fprintf(w, html, time.Now().Format("2006-01-02 15:04:05"))
}

func main() {
    http.HandleFunc("/", handler)
    fmt.Println("Server starting on :8080...")
    log.Fatal(http.ListenAndServe(":8080", nil))
}
```

### Step 2: Single-Stage Dockerfile (Bad Example)

Create `Dockerfile.single`:
```dockerfile
FROM golang:1.21

WORKDIR /app

COPY main.go .

RUN go build -o server main.go

EXPOSE 8080

CMD ["./server"]
```

Build and check size:
```bash
docker build -f Dockerfile.single -t go-app:single .
docker images | grep go-app
```

**Expected Size:** ~800MB+ (includes entire Go toolchain!) ❌

### Step 3: Multi-Stage Dockerfile (Best Practice)

Create `Dockerfile`:
```dockerfile
# Build stage
FROM golang:1.21-alpine AS builder

WORKDIR /app

COPY main.go .

# Build with optimizations
RUN CGO_ENABLED=0 GOOS=linux go build -ldflags="-w -s" -o server main.go

# Runtime stage
FROM alpine:latest

WORKDIR /app

# Copy only the binary
COPY --from=builder /app/server .

EXPOSE 8080

CMD ["./server"]
```

Build and compare:
```bash
docker build -t go-app:multi .
docker images | grep go-app
```

**Expected Size:** ~15-20MB (97% reduction!) ✅

### Step 4: Test Both Images

```bash
# Run single-stage
docker run -d -p 8080:8080 --name single go-app:single

# Check it works
curl http://localhost:8080

# Stop and remove
docker stop single && docker rm single

# Run multi-stage
docker run -d -p 8080:8080 --name multi go-app:multi

# Check it works (same functionality!)
curl http://localhost:8080
# Or visit: http://localhost:8080 in browser

# Clean up
docker stop multi && docker rm multi
```

### Step 5: Analyze the Difference

```bash
# Compare image details
docker history go-app:single
docker history go-app:multi

# See layers count
docker inspect go-app:single | grep -A 20 "Layers"
docker inspect go-app:multi | grep -A 20 "Layers"
```

✅ Lab 1 is Completed!

> **Key Learning:** Multi-stage builds reduce image size while maintaining functionality!

---
