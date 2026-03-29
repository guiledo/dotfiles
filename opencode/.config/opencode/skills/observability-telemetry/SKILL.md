---
name: observability-telemetry
description: "Enforces production-grade logging, tracing, and metrics. Make sure to use this skill whenever the user asks to add logging, handle errors, debug production issues, or set up monitoring."
---

# Observability & Telemetry

This skill replaces amateur debugging practices with production-ready observability. A system without telemetry is a black box.

## Core Observability Rules

### 1. Structured Logging
- **NEVER** use plain string logs (e.g., `console.log('User created: ', id)` or `print("Error happened")`) for production applications.
- **ALWAYS** emit logs in structured JSON format using a dedicated library (e.g., Winston/Pino in Node, slog in Go, Python's `logging` with JSON formatter).
- **Mandatory Fields:** Every log must contain a `timestamp`, `level` (INFO, WARN, ERROR), and relevant contextual metadata.

### 2. Context Propagation
- An isolated log is useless in a distributed system. 
- Always ensure that a `request_id` or `trace_id` is generated at the system edge (middleware) and propagated through the application context. This allows tracing a single request across multiple functions or microservices.

### 3. Actionable Errors
- Do not log generic errors like `"Database failed"`.
- Error logs must include:
  - The exact operation being attempted.
  - The stack trace.
  - The identifiers involved (e.g., `user_id`, `resource_id`).
  - **WARNING:** Never log PII (Personally Identifiable Information), passwords, or credit card details. Mask these fields if logging request payloads.

### 4. Metrics vs Logs
- Use logs for discrete events (e.g., "User authenticated").
- Use metrics (counters, histograms) for aggregates (e.g., "Number of requests per minute", "Average database response time").

## Workflow
1. **Intercept Error Handling:** If asked to write a `catch` block, do not silently swallow the error. Implement structured logging.
2. **Setup Middleware:** When creating APIs, always ensure there is a middleware dedicated to assigning trace IDs and logging request/response durations.