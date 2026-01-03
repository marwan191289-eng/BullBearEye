# 🐳 Docker Setup Guide

## Overview

This project uses Docker and Docker Compose to containerize the TradeXray application stack:
- **Backend**: FastAPI with Python 3.11
- **Frontend**: Next.js with Node 18
- **Database**: PostgreSQL 15
- **Cache**: Redis 7
- **Proxy**: Nginx (optional)

## Prerequisites

- Docker Desktop (includes Docker Engine and Docker Compose)
- At least 4GB RAM available for Docker
- Ports 3000, 8000, 5432, 6379, and 80 should be available

## Quick Start

### 1. Environment Setup

Copy the example environment file and configure your variables:

```bash
# Copy the example file
cp .env.example .env

# Edit the .env file with your API keys and passwords
```

**Important**: Update these values in `.env`:
- `POSTGRES_PASSWORD` - Set a strong database password
- `REDIS_PASSWORD` - Set a strong Redis password
- API keys (ETH_RPC_URL, ETHERSCAN_API_KEY, etc.)

### 2. Development Mode

Start all services with hot-reload enabled:

```bash
docker-compose up
```

Or run in detached mode:

```bash
docker-compose up -d
```

Access the services:
- Frontend: http://localhost:3000
- Backend API: http://localhost:8000
- API Docs: http://localhost:8000/docs
- PostgreSQL: localhost:5432
- Redis: localhost:6379

### 3. Production Mode

For production deployment:

```bash
# Copy production environment template
cp .env.prod.example .env.prod

# Edit .env.prod with production values
# IMPORTANT: Change all passwords and secrets!

# Build and start production stack
docker-compose -f docker-compose.prod.yml up -d --build
```

## 🏗️ Architecture

### Multi-Stage Builds

Both backend and frontend use multi-stage Docker builds for:
- **Smaller image sizes**: Only production dependencies included
- **Better security**: Separate build and runtime stages
- **Faster builds**: Better layer caching

### Backend Dockerfile Features
- Multi-stage build with builder and runtime stages
- Non-root user for security
- Health checks
- Optimized Python package installation
- Support for PyTorch/ML models

### Frontend Dockerfile Features
- Three-stage build (deps, builder, runner)
- Next.js standalone output for minimal size
- Non-root user for security
- Optimized for production performance
- Health checks

## 📋 Common Commands

### View Logs

```bash
# All services
docker-compose logs -f

# Specific service
docker-compose logs -f backend
docker-compose logs -f frontend
```

### Rebuild Services

```bash
# Rebuild all
docker-compose up --build

# Rebuild specific service
docker-compose up --build backend
```

### Stop Services

```bash
# Stop all services
docker-compose down

# Stop and remove volumes (⚠️ deletes data)
docker-compose down -v
```

### Execute Commands in Containers

```bash
# Backend shell
docker-compose exec backend sh

# Frontend shell
docker-compose exec frontend sh

# Database shell
docker-compose exec postgres psql -U admin -d tradexray
```

### Database Operations

```bash
# Create database backup
docker-compose exec postgres pg_dump -U admin tradexray > backup.sql

# Restore database backup
docker-compose exec -T postgres psql -U admin -d tradexray < backup.sql

# Connect to database
docker-compose exec postgres psql -U admin -d tradexray
```

## 🔧 Configuration

### Environment Variables

#### Development (.env)
- `POSTGRES_PASSWORD` - Database password
- `REDIS_PASSWORD` - Redis password
- `BACKEND_PORT` - Backend port (default: 8000)
- `FRONTEND_PORT` - Frontend port (default: 3000)
- API keys for external services

#### Production (.env.prod)
Same as development plus:
- `SECRET_KEY` - Application secret key
- `JWT_SECRET` - JWT authentication secret
- `NEXT_PUBLIC_API_URL` - Public API URL

### Nginx Reverse Proxy

To use Nginx as a reverse proxy:

```bash
# With nginx profile
docker-compose --profile with-nginx up
```

Features:
- Rate limiting
- Gzip compression
- Security headers
- WebSocket support
- Static file caching

## 🛡️ Security Best Practices

1. **Change Default Passwords**: Always update default passwords in production
2. **Use Secrets Management**: Consider Docker secrets or external vaults
3. **Non-Root Users**: All containers run as non-root users
4. **Health Checks**: All services have health checks configured
5. **Resource Limits**: Production compose file includes resource limits
6. **Network Isolation**: Services communicate through internal Docker network

## 🧪 Testing

Run tests inside containers:

```bash
# Backend tests
docker-compose exec backend pytest

# Frontend tests (if configured)
docker-compose exec frontend npm test
```

## 📊 Monitoring

View container stats:

```bash
docker stats
```

Check health status:

```bash
docker-compose ps
```

## 🐛 Troubleshooting

### Container won't start
```bash
# Check logs
docker-compose logs backend

# Check if port is in use
netstat -an | grep 8000  # Windows: netstat -an | findstr 8000
```

### Database connection issues
```bash
# Verify PostgreSQL is healthy
docker-compose exec postgres pg_isready -U admin

# Check database logs
docker-compose logs postgres
```

### Frontend build fails
```bash
# Clear Next.js cache
rm -rf frontend/.next  # Windows: rmdir /s frontend\.next

# Rebuild
docker-compose up --build frontend
```

### Out of disk space
```bash
# Remove unused images
docker system prune -a

# Remove volumes (⚠️ deletes data)
docker volume prune
```

## 📦 File Structure

```
.
├── backend/
│   ├── Dockerfile           # Backend container definition
│   ├── .dockerignore       # Files to exclude from build
│   ├── requirements.txt    # Python dependencies
│   └── app/                # Application code
├── frontend/
│   ├── Dockerfile          # Frontend container definition
│   ├── .dockerignore      # Files to exclude from build
│   ├── next.config.js     # Next.js configuration
│   └── package.json       # Node dependencies
├── docker-compose.yml      # Development stack
├── docker-compose.prod.yml # Production stack
├── nginx.conf             # Nginx configuration
├── .env.example           # Environment template
└── .env.prod.example      # Production environment template
```

## 🚀 Deployment

### Deploy to Production Server

1. Copy files to server
2. Configure `.env.prod`
3. Build and start:
   ```bash
   docker-compose -f docker-compose.prod.yml up -d --build
   ```

### Use with CI/CD

Example GitHub Actions workflow:

```yaml
- name: Build and push images
  run: |
    docker-compose -f docker-compose.prod.yml build
    docker-compose -f docker-compose.prod.yml push
```

## 🔄 Updates

Pull and rebuild:

```bash
# Pull latest changes
git pull

# Rebuild and restart
docker-compose up -d --build
```

## 📝 Notes

- **Development**: Uses volume mounts for hot-reload
- **Production**: Builds standalone images without volume mounts
- **Database**: Data persists in Docker volumes
- **Node Modules**: Frontend uses named volume to avoid conflicts

## 🆘 Support

For issues:
1. Check logs: `docker-compose logs`
2. Verify configuration: `docker-compose config`
3. Check resource usage: `docker stats`

## 📄 License

[Your License Here]
