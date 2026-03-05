# Lab 2: Two-Tier Flask + PostgreSQL Application

### Objective
Build a complete web application with database using Docker Compose.

### Step 1: Create Project Structure

```bash
mkdir flask-postgres-app && cd flask-postgres-app
```

### Step 2: Create Flask Application

Create `app.py`:
```python
from flask import Flask, jsonify, render_template_string
import psycopg2
import os
import time

app = Flask(__name__)

# Database configuration
DB_CONFIG = {
    'host': os.getenv('DB_HOST', 'db'),
    'database': os.getenv('DB_NAME', 'testdb'),
    'user': os.getenv('DB_USER', 'postgres'),
    'password': os.getenv('DB_PASSWORD', 'secret123')
}

# HTML template
HTML_TEMPLATE = '''
<!DOCTYPE html>
<html>
<head>
    <title>Flask + PostgreSQL</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            max-width: 800px;
            margin: 50px auto;
            padding: 20px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
        }
        .container {
            background: rgba(255,255,255,0.1);
            padding: 30px;
            border-radius: 10px;
            backdrop-filter: blur(10px);
        }
        button {
            background: #4CAF50;
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 16px;
            margin: 5px;
        }
        button:hover { background: #45a049; }
        .status { margin: 20px 0; padding: 15px; background: rgba(255,255,255,0.2); border-radius: 5px; }
        .user-list { margin-top: 20px; }
        .user { padding: 10px; margin: 5px 0; background: rgba(255,255,255,0.15); border-radius: 5px; }
    </style>
</head>
<body>
    <div class="container">
        <h1>🐘 Flask + PostgreSQL Demo</h1>
        <p>Multi-container application running with Docker Compose</p>
        
        <div>
            <button onclick="location.href='/health'">Check Health</button>
            <button onclick="location.href='/users'">View Users</button>
            <button onclick="location.href='/init'">Initialize Database</button>
        </div>
    </div>
</body>
</html>
'''

def get_db_connection():
    """Establish database connection with retry logic"""
    max_retries = 5
    retry_delay = 2
    
    for attempt in range(max_retries):
        try:
            conn = psycopg2.connect(**DB_CONFIG)
            return conn
        except psycopg2.OperationalError as e:
            if attempt < max_retries - 1:
                print(f"Database connection attempt {attempt + 1} failed. Retrying in {retry_delay}s...")
                time.sleep(retry_delay)
            else:
                raise

@app.route('/')
def home():
    return render_template_string(HTML_TEMPLATE)

@app.route('/health')
def health():
    try:
        conn = get_db_connection()
        cursor = conn.cursor()
        cursor.execute('SELECT version();')
        db_version = cursor.fetchone()[0]
        cursor.close()
        conn.close()
        
        return jsonify({
            'status': 'healthy',
            'database': 'connected',
            'postgres_version': db_version
        })
    except Exception as e:
        return jsonify({
            'status': 'unhealthy',
            'database': 'disconnected',
            'error': str(e)
        }), 500

@app.route('/init')
def init_db():
    try:
        conn = get_db_connection()
        cursor = conn.cursor()
        
        # Create table
        cursor.execute('''
            CREATE TABLE IF NOT EXISTS users (
                id SERIAL PRIMARY KEY,
                name VARCHAR(100),
                email VARCHAR(100),
                created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
            )
        ''')
        
        # Check if table is empty
        cursor.execute('SELECT COUNT(*) FROM users')
        count = cursor.fetchone()[0]
        
        if count == 0:
            # Insert sample data
            sample_users = [
                ('Alice Johnson', 'alice@example.com'),
                ('Bob Smith', 'bob@example.com'),
                ('Charlie Brown', 'charlie@example.com'),
                ('Diana Prince', 'diana@example.com'),
                ('Eve Davis', 'eve@example.com')
            ]
            
            cursor.executemany(
                'INSERT INTO users (name, email) VALUES (%s, %s)',
                sample_users
            )
            conn.commit()
            message = f'Database initialized with {len(sample_users)} users'
        else:
            message = f'Database already has {count} users'
        
        cursor.close()
        conn.close()
        
        return jsonify({
            'status': 'success',
            'message': message
        })
    except Exception as e:
        return jsonify({
            'status': 'error',
            'error': str(e)
        }), 500

@app.route('/users')
def users():
    try:
        conn = get_db_connection()
        cursor = conn.cursor()
        
        cursor.execute('SELECT id, name, email, created_at FROM users ORDER BY id')
        users_data = cursor.fetchall()
        
        cursor.close()
        conn.close()
        
        return jsonify({
            'count': len(users_data),
            'users': [
                {
                    'id': u[0],
                    'name': u[1],
                    'email': u[2],
                    'created_at': str(u[3])
                }
                for u in users_data
            ]
        })
    except Exception as e:
        return jsonify({
            'status': 'error',
            'error': str(e)
        }), 500

if __name__ == '__main__':
    print("Starting Flask application...")
    print(f"Database host: {DB_CONFIG['host']}")
    app.run(host='0.0.0.0', port=5000, debug=True)
```

### Step 3: Create Requirements File

Create `requirements.txt`:
```
Flask==3.0.0
psycopg2-binary==2.9.9
```

### Step 4: Create Dockerfile

Create `Dockerfile`:
```dockerfile
FROM python:3.9-slim

WORKDIR /app

# Install dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy application
COPY app.py .

EXPOSE 5000

CMD ["python", "app.py"]
```

### Step 5: Create docker-compose.yml

Create `docker-compose.yml`:
```yaml
version: '3.8'

services:
  web:
    build: .
    container_name: flask-app
    ports:
      - "5000:5000"
    environment:
      DB_HOST: db
      DB_NAME: testdb
      DB_USER: postgres
      DB_PASSWORD: secret123
    depends_on:
      - db
    networks:
      - app-network
    restart: unless-stopped

  db:
    image: postgres:14-alpine
    container_name: postgres-db
    environment:
      POSTGRES_DB: testdb
      POSTGRES_USER: postgres
      POSTGRES_PASSWORD: secret123
    volumes:
      - postgres-data:/var/lib/postgresql/data
    networks:
      - app-network
    restart: unless-stopped
    healthcheck:
      test: ["CMD-SHELL", "pg_isready -U postgres"]
      interval: 10s
      timeout: 5s
      retries: 5

volumes:
  postgres-data:
    driver: local

networks:
  app-network:
    driver: bridge
```

### Step 6: Start the Application

```bash
docker compose up -d
```

**Expected Output:**
```
[+] Running 4/4
 ✔ Network flask-postgres-app_app-network       Created
 ✔ Volume "flask-postgres-app_postgres-data"    Created
 ✔ Container postgres-db                        Started
 ✔ Container flask-app                          Started
```

### Step 7: Verify Services are Running

```bash
docker compose ps
```

**Expected Output:**
```
NAME           IMAGE                      STATUS         PORTS
flask-app      flask-postgres-app-web     Up 10 seconds  0.0.0.0:5000->5000/tcp
postgres-db    postgres:14-alpine         Up 11 seconds  5432/tcp
```

### Step 8: Test the Application

Open browser and visit:
- **http://localhost:5000** - Home page
- Click "Initialize Database" button
- Click "View Users" to see JSON data
- **http://localhost:5000/health** - Database health check

Or use curl:
```bash
curl http://localhost:5000/health
curl http://localhost:5000/init
curl http://localhost:5000/users
```

✅ **Success Criteria:**
- Home page loads with styled interface
- Health endpoint shows database connection
- Users endpoint returns 5 sample users

### Step 9: View Logs

```bash
# All services
docker compose logs

# Specific service
docker compose logs web
docker compose logs db

# Follow logs in real-time
docker compose logs -f web
```

Press `Ctrl+C` to stop following logs.

### Step 10: Execute Commands in Containers

**Connect to PostgreSQL:**
```bash
docker compose exec db psql -U postgres -d testdb
```

Inside PostgreSQL, try:
```sql
\dt                          -- List tables
SELECT * FROM users;         -- View all users
SELECT COUNT(*) FROM users;  -- Count users
\q                           -- Quit
```

**Get shell in web container:**
```bash
docker compose exec web /bin/bash
```

Inside container:
```bash
ls -la
env | grep DB_
exit
```

### Step 11: Test Data Persistence

Stop containers:
```bash
docker compose stop
```

Start again:
```bash
docker compose start
```

Visit http://localhost:5000/users - data is still there! ✅

### Step 12: Complete Cleanup

```bash
# Stop and remove containers (keeps volumes)
docker compose down

# Stop and remove everything including volumes
docker compose down -v
```

### ✅ Lab 2 Complete!
You've built a production-ready two-tier application!

---
