# High-Quality Agentic Development Guidelines

## 1. Core Philosophy: The Quality Gates
- **STRICT RED-GREEN-REFACTOR (RGR):** Non-negotiable. 
  - **RED:** Write a test that fails with a *specific, expected message*. 
  - **GREEN:** Write the minimal code to satisfy the test.
  - **REFACTOR:** Optimize for readability and performance *after* green.
- **SELF-DOCUMENTING CODE:** Comments are code smells. Code must be expressive and idiomatic. Use comments ONLY for non-obvious "Why" (business logic constraints or architectural decisions), never for "What" or "How".
- **ZERO PLACEHOLDERS:** Never use `// TODO` or `// implementation here`. Deliver complete, functional units.

## 2. Cybersecurity & Trust (Mandatory)
- **SECRET BLINDNESS:** Never hardcode keys, tokens, or credentials. Use `.env` and verify `.gitignore` before every write.
- **DEPENDENCY GUARD:** Verify package names for typosquatting before installation. Check `npm audit` (or equivalent) for new dependencies.
- **THREAT MODELING:** Assume all external input (API, CLI, User) is hostile. Mandate sanitization, escaping, and parameterized queries.
- **LEAST PRIVILEGE:** Use minimal system and file permissions. Never suggest broad `chmod` (e.g., `777`) or insecure shell execution (`eval`, raw shell spawning).

## 3. Generalist Discovery Protocol
- **ENVIRONMENT AWARENESS:** The first step of every session MUST be to identify the tech stack and architecture (e.g., `package.json`, `Cargo.toml`, `go.mod`, `pyproject.toml`).
- **CI/CD RECONNAISSANCE:** Before assuming test or build commands, check for `.github/workflows`, `Makefile`, `Justfile`, or custom scripts. Always use the project's established scripts to ensure parity with the CI pipeline.
- **IDIOMATIC PRECEDENCE:** Match the project's native style conventions rigorously (e.g., Pythonic for Python, Go-idiomatic for Go). 
- **GOLD STANDARD (JS/TS):** When starting or working in JS/TS ecosystems without strict pre-existing constraints, prefer `pnpm`, `Vitest`, `Zod`, and `Bun`.

## 4. Workflow & Output
- **PERSISTENT PLANNING:** For complex, multi-step tasks or architectural changes, always persist plans to `.opencode/plans/*.md`. Do NOT pollute the project root.
- **PARALLEL EXPLORATION:** Use multiple, concurrent tool calls (e.g., `glob` and `grep` together) in a single response to maximize search efficiency.
- **VERIFIED TYPES:** Reject `any` or loose types. Use `unknown` or define strict schemas at trust boundaries.
- **GITHUB INTEGRATION:** Prefer using the `gh` CLI for managing Issues, Pull Requests, and checking CI status.

## 5. Logic Verification
- **TEST BEHAVIOR, NOT INTERNALS:** Tests must interact solely with the public API of the module. 
- **FACTORY PATTERNS:** Use factory functions for generating test data; avoid shared mutable state in test suites.
- **FAIL STATE VALIDATION:** Explicitly state the exact expected failure message or condition during the RED phase before writing implementation code.

## 6. Agent Behavioral Guardrails
- **SYSTEMATIC DEBUGGING (ANTI-LOOP):** Never "guess and check". If a test or command fails, you must explicitly state a hypothesis for *why* it failed before changing code. If you fail 3 times on the same issue, STOP and ask the user for guidance. Do not brute-force solutions.
- **EXPLICIT AMBIGUITY RESOLUTION:** If a requirement is missing or ambiguous, STOP and ask the user. Never invent or hallucinate business logic, schema requirements, or architectural constraints.
- **CLEAN COMMITS:** Final code must be production-ready. Always remove exploratory debugging statements (e.g., `console.log`, `print`, `dbg!`), unused imports, and mock data before declaring a task complete.