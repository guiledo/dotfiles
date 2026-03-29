---
name: database-architect
description: "Expert database modeling and safe migration workflow. Make sure to use this skill whenever the user asks to add a new table, modify a schema, create a migration, optimize a SQL query, or discuss database architecture."
---

# Database Architect

This skill enforces strict, production-ready database design and safe migration practices. State changes (database modifications) are the most critical and dangerous part of software engineering. We prioritize data integrity, zero-downtime, and performance.

## Core Rules

### 1. The "No Data Loss" Guarantee (Expand & Contract)
**NEVER** perform destructive operations (e.g., `DROP COLUMN`, `RENAME COLUMN`, or changing data types of populated columns) in a single step.
If a destructive change is requested, you MUST use the **Expand & Contract** pattern:
- **Phase 1 (Expand):** Add the new column/table. Write code to dual-write to both old and new structures.
- **Phase 2 (Migrate):** Write a script to backfill historical data from the old structure to the new one.
- **Phase 3 (Contract):** Once all data is migrated and code only reads from the new structure, drop the old column/table in a *separate* future migration.

### 2. Primary & Foreign Keys
- **IDs:** Prefer UUIDv7, ULID, or NanoID over auto-incrementing integers (`SERIAL` / `AUTO_INCREMENT`) for primary keys to prevent IDOR (Insecure Direct Object Reference) vulnerabilities and ease distributed system scaling.
- **Foreign Keys:** ALWAYS create explicit Foreign Key constraints to maintain referential integrity.
- **Indexing:** ALWAYS automatically create an index for every Foreign Key. Most databases do *not* do this automatically, leading to massive performance hits during `JOIN` or `DELETE cascade` operations.

### 3. Normalization vs. Performance
- Design schemas in the 3rd Normal Form (3NF) by default.
- Only introduce denormalization (e.g., JSONB columns, duplicated data) if there is a mathematically proven performance bottleneck or if dealing with explicitly unstructured/NoSQL requirements.

### 4. Auditability
Unless explicitly told otherwise, heavily consider adding `created_at` and `updated_at` (timestamp with timezone) to every new table.

## Workflow

When asked to create or modify a database schema:
1. **Analyze:** Understand the business entities and relationships.
2. **Draft:** Present a text-based schema representation (e.g., Mermaid ER diagram or simple SQL DDL) for user approval *before* generating ORM code or migration files.
3. **Execute:** Once approved, generate the specific migration file for the user's stack (e.g., Prisma, Drizzle, Alembic, raw SQL).