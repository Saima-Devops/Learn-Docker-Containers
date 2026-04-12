# 🚀 Node.js + Docker Demo (Step-by-Step Guide)

This guide walks you through creating a simple Node.js app using Express and running it inside a Docker container.

---

## 📦 Step 1: Setup Node.js App

### 1. Create a project folder

```bash
mkdir node-docker-demo
cd node-docker-demo
```

### 2. Initialize a Node.js project

```bash
npm init -y
```

### 3. Install Express

```bash
npm install express
```

---

## 🧩 Step 2: Create the Express App

### 1. Create `index.js`

```js
// index.js
const express = require('express');
const app = express();
const port = 3000;

app.get('/', (req, res) => {
  res.send('Hello from Saima Usman!');
});

app.listen(port, () => {
  console.log(`Server is running at http://localhost:${port}`);
});
```

### 2. Update `package.json` scripts

```json
"scripts": {
  "start": "node index.js"
}
```

---

## 🐳 Step 3: Add a Dockerfile

Create a file named `Dockerfile` (no extension):

```Dockerfile
# Use an official Node.js 22 image
FROM node:22

# Set the working directory
WORKDIR /app

# Copy package.json and install dependencies
COPY package*.json ./
RUN npm install

# Copy the rest of the app
COPY . .

# Expose port 3000
EXPOSE 3000

# Start the app
CMD ["npm", "start"]
```

---

## ▶️ Step 4: Build and Run the Docker Image

### 1. Build the Docker image

```bash
docker build -t node-docker-demo .
```

### 2. Run the container

```bash
docker run -p 3000:3000 node-docker-demo
```

### ✅ Expected output

```bash
Server is running at http://localhost:3000
```

### 🌐 Test in browser

Open:

```
http://localhost:3000
```

You should see:

```
Hello from Saima Usman!
```

---

## 🔁 Recommended: Auto-Reload with Nodemon (Development Only)

### 1. Install nodemon

```bash
npm install --save-dev nodemon
```

### 2. Update `package.json`

```json
"scripts": {
  "start": "nodemon index.js"
}
```

### 3. Run container with volume mounting

```bash
docker run -p 3000:3000 -v $(pwd):/app node-docker-demo
```

💡 Now your app will automatically restart when you change the code!

---

## 🎉 Done!

You now have a Dockerized Node.js app with live-reload support for development.

