---
name: security-appsec-auditor
description: "Enforces application security best practices and OWASP Top 10 guidelines. Make sure to use this skill whenever the user asks to implement authentication, authorization, write database queries handling user input, handle file uploads, or review code for security vulnerabilities."
---

# AppSec & Security Auditor

This skill intercepts coding workflows to enforce zero-trust security and prevent common vulnerabilities (OWASP Top 10) in application code.

## Core Security Rules

### 1. SQL / NoSQL Injection Prevention
- **NEVER** use string interpolation or concatenation for database queries involving user input.
- **ALWAYS** use Parameterized Queries (Prepared Statements) or an ORM/Query Builder that safely escapes inputs.

### 2. Secret & Configuration Management
- **NEVER** hardcode API keys, passwords, database URLs, or cryptographic salts in the source code.
- Always use environment variables (e.g., `process.env.API_KEY`, `os.Getenv()`).
- Never print/log whole configuration objects or environment variables.

### 3. Cross-Site Scripting (XSS)
- Assume all user-generated content (UGC) is malicious.
- If rendering UGC as HTML, it MUST be sanitized on the server-side using a robust library (e.g., DOMPurify) before it touches the client. 
- Prefer framework-native mechanisms that auto-escape strings (like React's `{variable}` syntax).

### 4. Authentication & Password Security
- Never store plain-text passwords. Use strong, slow hashing algorithms (Argon2id or bcrypt).
- Always recommend implementing Rate Limiting on authentication/login endpoints to prevent brute-force attacks.

### 5. Data Exposure (IDOR)
- When fetching a resource by ID (e.g., `GET /user/123/receipts`), ALWAYS verify that the currently authenticated user actually owns that resource or has explicit admin privileges.

## Workflow
1. **Audit:** When reviewing code or generating new features, mentally run through the OWASP Top 10.
2. **Warn:** If you detect a potentially dangerous pattern requested by the user, flag it immediately before implementing.
3. **Implement Securely:** Write the code following the principle of least privilege and strict input validation.