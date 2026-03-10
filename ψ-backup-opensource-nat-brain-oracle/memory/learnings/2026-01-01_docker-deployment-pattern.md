# Docker Deployment Pattern for Bun + Vite Projects

**Date**: 2026-01-01
**Context**: Data-Aware RAG v3 - production deployment
**Impact**: Single command to run full system: `docker-compose up -d`

## The Pattern

Multi-stage Dockerfile for Bun + React/Vite:

```dockerfile
# Stage 1: Build frontend
FROM oven/bun:1.1 AS frontend-builder
WORKDIR /app/frontend
COPY frontend/package.json frontend/bun.lock* ./
RUN bun install --frozen-lockfile
COPY frontend/ ./
RUN bun run build

# Stage 2: Build backend
FROM oven/bun:1.1 AS backend-builder
WORKDIR /app
COPY package.json bun.lock* ./
RUN bun install --frozen-lockfile --production
COPY src/ ./src/
COPY scripts/ ./scripts/

# Stage 3: Production
FROM oven/bun:1.1-slim AS production
WORKDIR /app
COPY --from=backend-builder /app/node_modules ./node_modules
COPY --from=backend-builder /app/src ./src
COPY --from=frontend-builder /app/frontend/dist ./frontend/dist
CMD ["bun", "run", "dashboard"]
```

## Key Decisions

| Decision | Why |
|----------|-----|
| **oven/bun:1.1-slim** | 60% smaller than full image |
| **Multi-stage** | Don't ship build tools to production |
| **--frozen-lockfile** | Reproducible builds |
| **--production** | Skip devDependencies |

## docker-compose.yml

```yaml
services:
  rag:
    build: .
    ports: ["8001:8001"]
    volumes:
      - ./data:/app/data        # Persist database
      - ./docs:/data:ro         # Read-only content to index
    healthcheck:
      test: ["CMD", "curl", "-f", "http://localhost:8001/api/stats"]

  chromadb:
    image: chromadb/chroma:latest
    profiles: ["with-vector"]   # Optional: docker-compose --profile with-vector up
```

## .dockerignore Essentials

```
node_modules
frontend/node_modules
data/*.db
.git
cli-rust/target
```

## Config Priority Pattern

```typescript
// Priority: env > local > global > defaults
const config = deepMerge(
  deepMerge(
    deepMerge(DEFAULT_CONFIG, loadUserConfig()),
    loadLocalConfig()
  ),
  loadEnvConfig()
);
```

## Usage

```bash
# Build and run
docker-compose up -d

# With vector search
docker-compose --profile with-vector up -d

# View logs
docker-compose logs -f rag

# Index data from mounted volume
docker exec data-aware-rag bun run cli index /data --incremental
```

## Key Statement

> Multi-stage builds separate concerns: frontend has its own node_modules, backend has different dependencies. Slim base image for production, full image for build stages.
