---
name: api-contract-designer
description: "Enforces API-First design principles. Make sure to use this skill whenever the user asks to create a new backend route, design an API, build a Backend-For-Frontend (BFF), or document endpoints."
---

# API Contract Designer

This skill ensures that backend development is driven by robust, consumer-centric contracts. The API contract is the ultimate source of truth, dictating both backend implementation and frontend integration.

## Core Rules

### 1. API-First Approach
Before writing any routing logic (e.g., Express, FastAPI, Go standard library), you must design the contract. 
- If the project uses OpenAPI/Swagger, create or update the `openapi.yaml` or `swagger.json` file first.
- If the project uses GraphQL, define the `.graphql` schema first.
- If the project uses tRPC/tSOA, define the router inputs/outputs first.

### 2. Standardized HTTP Semantics (REST)
Stop guessing HTTP status codes. Use them semantically:
- `200 OK`: Successful read/update.
- `201 Created`: Successful creation of a resource (must return the created resource or a Location header).
- `204 No Content`: Successful deletion.
- `400 Bad Request`: Client error (e.g., validation failed). **MUST** return a structured error body detailing exactly which fields failed.
- `401 Unauthorized`: Missing or invalid authentication token.
- `403 Forbidden`: Authenticated, but lacks permissions for this specific action.
- `404 Not Found`: Resource does not exist.
- `429 Too Many Requests`: Rate limiting.

### 3. Pagination is Mandatory
**NEVER** return an unbounded array for a list endpoint (e.g., `GET /users`). 
- Always implement pagination by default.
- Use cursor-based pagination (e.g., `?cursor=xyz&limit=20`) for high-performance feeds.
- Use offset-based pagination (e.g., `?page=1&limit=20`) only for simple admin tables.

### 4. Security by Design
- Never expose internal database IDs if they are sequential integers.
- Assume all inputs are malicious. Ensure the contract enforces strict type validation (e.g., using Zod, Pydantic, or JSON Schema) before business logic executes.

## Workflow
1. **Understand Request:** Identify the consumer's needs (Frontend, Mobile, 3rd Party).
2. **Draft Contract:** Write the Schema/Endpoint definition and present it to the user.
3. **Implement:** Once the contract is approved, write the backend code that strictly adheres to the input validation and output formatting defined in the contract.