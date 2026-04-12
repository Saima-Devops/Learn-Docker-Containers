#!/bin/bash

echo "🔍 Checking system dependencies..."
echo "-----------------------------------"

# ----------------------------
# Helper function
# ----------------------------
check_cmd() {
  if command -v $1 &> /dev/null; then
    echo "✅ $2 is installed"
    return 0
  else
    echo "❌ $2 is missing"
    return 1
  fi
}

# ----------------------------
# 1. Node.js + npm
# ----------------------------
if check_cmd node "Node.js" && check_cmd npm "npm"; then
  echo "✔ Node.js & npm are ready"
else
  echo "📦 Installing Node.js + npm..."

  if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    curl -fsSL https://deb.nodesource.com/setup_lts.x | sudo -E bash -
    sudo apt-get install -y nodejs
  else
    echo "👉 Please install Node.js manually from https://nodejs.org"
  fi
fi

echo "-----------------------------------"

# Re-check npm after install
if ! command -v npm &> /dev/null; then
  echo "❌ npm installation failed. Please reinstall Node.js."
  exit 1
fi

# ----------------------------
# 2. Git
# ----------------------------
if ! command -v git &> /dev/null; then
  echo "❌ Git is missing"
  read -p "👉 Install Git? (y/n): " choice

  if [[ "$choice" == "y" ]]; then
    sudo apt update
    sudo apt install -y git
  fi
else
  echo "✅ Git is installed"
fi

echo "-----------------------------------"

# ----------------------------
# 3. Docker
# ----------------------------
if command -v docker &> /dev/null; then
  echo "✅ Docker is installed"
else
  echo "❌ Docker is missing"
  echo "👉 Install Docker from: https://www.docker.com/products/docker-desktop/"
fi

echo "-----------------------------------"

# ----------------------------
# 4. nodemon (safe install with sudo)
# ----------------------------
if command -v nodemon &> /dev/null; then
  echo "✅ nodemon is installed"
else
  echo "❌ nodemon is missing"

  read -p "👉 Install nodemon globally using sudo npm? (y/n): " choice

  if [[ "$choice" == "y" ]]; then
    echo "📦 Installing nodemon globally..."
    sudo npm install -g nodemon
  else
    echo "💡 Skipping global install"
    echo "👉 You can use: npx nodemon index.js"
  fi
fi

echo "-----------------------------------"


if [ -f package.json ]; then
  echo "📦 Installing project dependencies..."
  npm install
else
  echo "⚠️ No package.json found. Skipping npm install."
fi

echo "-----------------------------------"

echo "🎉 Setup complete!"

echo "-----------------------------------"


# RUN THESE COMMANDS TO EXECUTE THIS FILE
# chmod +x setup.sh
#./setup.sh
