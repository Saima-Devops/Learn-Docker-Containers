
##  Dockerfile for Python Application

```
FROM python:3.9-slim 
 
WORKDIR /app 
 
COPY requirements.txt . 
RUN pip install --no-cache-dir -r requirements.txt 
 
COPY . . 
 
EXPOSE 5000 
 
CMD ["python", "app.py"]
```

---

##  Dockerfile for Node.js Application

```
FROM node:16-alpine 
 
WORKDIR /app 
 
# Copy package.json and package-lock.json first for better caching 
COPY package*.json ./ 
RUN npm install 
 
# Copy the rest of the application 
COPY . . 
 
EXPOSE 3000 
 
CMD ["node", "index.js"]
```

---

##  Dockerfile for Go Application

```
FROM golang:1.18-alpine AS builder 
 
WORKDIR /app 
 
COPY go.mod go.sum ./ 
RUN go mod download 
 
COPY . . 
RUN go build -o main . 
 
# Use a smaller image for the final container 
FROM alpine:latest 
 
WORKDIR /app 
 
COPY --from=builder /app/main . 
 
EXPOSE 8080 
 
CMD ["./main"]
```

---

##  Dockerfile for Ruby on Rails Application

```
FROM ruby:3.0 
 
WORKDIR /app 
 
# Install dependencies 
COPY Gemfile Gemfile.lock ./ 
RUN bundle install 
 
# Copy application code 
COPY . . 
 
EXPOSE 3000 
 
CMD ["rails", "server", "-b", "0.0.0.0"]
```

----

##  Dockerfile for Java Spring Boot Application

```
FROM openjdk:17-jdk-slim 
 
WORKDIR /app 
 
COPY build/libs/*.jar app.jar 
 
EXPOSE 8080 
 
CMD ["java", "-jar", "app.jar"]
```

-----
