---
name: docker-infra-workflow
description: "Expert infrastructure containerization. Make sure to use this skill whenever the user asks to dockerize an app, create a local development environment, set up docker-compose, or configure CI/CD containers."
---

# Docker & Infrastructure Workflow

This skill ensures that application environments are reproducible, secure, and production-ready using Docker and modern containerization practices.

## Core Rules for Dockerfiles

### 1. Multi-Stage Builds are Mandatory
Never ship a build environment to production.
- **Builder Stage:** Install heavy dependencies, run compilers (e.g., `npm run build`, `go build`).
- **Runner Stage:** Use a minimal base image (e.g., `alpine`, `distroless`, `node:alpine`). Copy ONLY the compiled artifacts and production dependencies from the Builder stage.

### 2. Least Privilege (Never run as root)
By default, Docker runs as root. This is a massive security risk.
- ALWAYS create a dedicated user and group in the final stage.
- Switch to this user using the `USER` directive before the `CMD` or `ENTRYPOINT`.
  *Example:* `RUN addgroup -S appgroup && adduser -S appuser -G appgroup` -> `USER appuser`.

### 3. Layer Caching & Immutability
- Copy dependency manifests (e.g., `package.json`, `requirements.txt`, `go.mod`) and install dependencies *before* copying the rest of the source code. This utilizes Docker's layer caching, making subsequent builds exponentially faster when only source code changes.

## Core Rules for Docker Compose (Local Dev)

### 1. Persistence
- Databases (Postgres, MySQL, Mongo) and Message Brokers (Redis, RabbitMQ) MUST have named volumes mapped to their data directories. If you don't do this, data will be wiped every time the container restarts.

### 2. Healthchecks & Dependency Ordering
- Do not rely solely on `depends_on`. A database container might be "running" but not yet accepting connections.
- ALWAYS implement `healthcheck` in the database service and use `depends_on: db: condition: service_healthy` in the application service.

### 3. Environment Variables
- Never hardcode secrets in `docker-compose.yml`.
- Use an `.env` file (and provide an `.env.example` template) or use the `environment` block with variable interpolation.

## Workflow
1. **Analyze Stack:** Determine the language, framework, and required external services (DB, Cache).
2. **Draft Dockerfile:** Create an optimized, multi-stage Dockerfile.
3. **Draft Compose:** Create a `docker-compose.yml` for local development linking the app and its dependencies.
4. **Explain:** Briefly explain to the user how to start the environment (e.g., `docker compose up -d --build`).