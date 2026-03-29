# High-Quality Agentic Development Guidelines

## 1. Cybersecurity & Trust (Mandatory)
- **SECRET BLINDNESS:** Never hardcode keys, tokens, or credentials. Use `.env` and verify `.gitignore` before every write.
- **DEPENDENCY GUARD:** Verify package names for typosquatting before installation. Check `npm audit` (or equivalent) for new dependencies.
- **THREAT MODELING:** Assume all external input (API, CLI, User) is hostile. Mandate sanitization, escaping, and parameterized queries.
- **LEAST PRIVILEGE:** Use minimal system and file permissions. Never suggest broad `chmod` (e.g., `777`) or insecure shell execution (`eval`, raw shell spawning).

## 2. Generalist Discovery & Context Loading
- **ENVIRONMENT AWARENESS:** The first step of every session MUST be to identify the tech stack and architecture (e.g., `package.json`, `Cargo.toml`, `go.mod`, `pyproject.toml`).
- **CI/CD RECONNAISSANCE:** Before assuming test or build commands, check for `.github/workflows`, `Makefile`, `Justfile`, or custom scripts. Always use the project's established scripts to ensure parity with the CI pipeline.
- **IDIOMATIC PRECEDENCE:** Match the project's native style conventions rigorously (e.g., Pythonic for Python, Go-idiomatic for Go).

## 3. Workflow & Output
- **PARALLEL EXPLORATION:** Use multiple, concurrent tool calls (e.g., paralel file reading and searching) in a single response to maximize search efficiency and minimize context window usage.
- **VERIFIED TYPES:** Reject `any` or loose types. Use `unknown` or define strict schemas at trust boundaries.

## 4. Logic Verification
- **TEST BEHAVIOR, NOT INTERNALS:** Tests must interact solely with the public API of the module. 
- **FACTORY PATTERNS:** Use factory functions for generating test data; avoid shared mutable state in test suites.
- **FAIL STATE VALIDATION:** Explicitly state the exact expected failure message or condition before writing implementation code.

## 5. Agent Behavioral Guardrails
- **SYSTEMATIC DEBUGGING (ANTI-LOOP):** Never "guess and check". If a test or command fails, you must explicitly state a hypothesis for *why* it failed before changing code. If you fail 3 times on the same issue, STOP and ask the user for guidance. Do not brute-force solutions.
- **EXPLICIT AMBIGUITY RESOLUTION:** If a requirement is missing or ambiguous, STOP and ask the user. Never invent or hallucinate business logic, schema requirements, or architectural constraints.
- **CLEAN COMMITS:** Final code must be production-ready. Always remove exploratory debugging statements (e.g., `console.log`, `print`, `dbg!`), unused imports, and mock data before declaring a task complete.