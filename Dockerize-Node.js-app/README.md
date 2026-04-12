# 🚀 Node.js + Docker Demo (with LIVE Reload Support)

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

### 2. Update `package.json` script with the following:

```json
{
  "name": "app1",
  "version": "1.0.0",
  "description": "Node.js application with Express",
  "main": "index.js",
  "type": "commonjs",
  "scripts": {
    "start": "node index.js",
    
  },
  "keywords": [],
  "author": "",
  "license": "ISC",
  "dependencies": {
    "express": "^5.2.1"
  },

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

### 2. Updated `package.json` (Replace the old code with the following)

```json
{
  "name": "app1",
  "version": "1.0.0",
  "description": "Node.js application with Express",
  "main": "index.js",
  "type": "commonjs",
  "scripts": {
    "start": "node index.js",
    "dev": "nodemon index.js"
  },
  "keywords": [],
  "author": "",
  "license": "ISC",
  "dependencies": {
    "express": "^5.2.1"
  },
  "devDependencies": {
    "nodemon": "^3.1.14"
  }
}
```

### 3. Run container with volume mounting

```bash
docker run -p 3000:3000 -v $(pwd):/app node-docker-demo
```

<img width="1147" height="361" alt="image" src="https://github.com/user-attachments/assets/70312806-b394-4439-b3ec-4425e5952fdd" />

----

💡 Now your app will automatically restart when you change the code!

----

### 4. When you edit index.json

- Let the **Running Server Terminal** OPEN!!
- Open the code file in another terminal tab
- Save the Changes
- OR Pull the changes from Github repo
- That's it!!

🎉 Your app will automatically accept the changes. No need of restarting the server again and again. Hurrey!!

---

## ✅ Nodemon + Volume - Development Mode with Live Reload

Run your command with **volume + nodemon**:

```bash
docker run -p 3000:3000 -v $(pwd):/app node-docker-demo npm run dev
```

After you edit & save:

✔ NOTHING TO DO\
✔ Just refresh browser

Because:

✔ volume syncs files\
✔ nodemon restarts automatically

------

## Done!

You now have a Dockerized Node.js app with live-reload support for development.

----

## 🔄 What is Nodemon?

Nodemon is a development tool that automatically restarts your **Node.js app** whenever you change your code.

Normally, without nodemon:

```bash
node index.js
```

If you edit your code:

❌ You must manually stop and restart the server every time.

<br>

## ⚡ What Nodemon Does

With nodemon:

```bash
nodemon index.js
```

✔ Watches your files\
✔ Detects changes\
✔ Restarts the server automatically

----
