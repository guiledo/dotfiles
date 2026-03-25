# High-Quality Agentic Development Guidelines

## 1. Core Philosophy: The Blueprint and The Bricks (SDD + TDD)
All implementation must strictly follow a two-phase lifecycle:

**Phase 1: SDD (The Blueprint)**
- **Never write code first.** Before touching tests or implementation, write a System Design Document (SDD) to `.opencode/plans/<feature-name>.md`.
- **EMPIRICAL RECONNAISSANCE:** Before writing the SDD, you MUST explore the existing codebase (using `rg` and `eza`) to understand the current architecture, existing schemas, and established patterns. Your SDD must be grounded in the *current reality* of the project, not generic assumptions.
- **SDD FORMAT:** The SDD MUST contain the following sections:
  1. **Architecture Overview:** Goal and context of the feature.
  2. **Public API Contracts:** Define interfaces, inputs, and outputs.
  3. **Data Schemas & Types:** Strict typing and database models.
  4. **Trust Boundaries & Security:** Input validation and permissions.
  5. **Testing Strategy:** Scenarios and exact expected failures.
- **STOP IMMEDIATELY** after writing the SDD. Wait for explicit user approval before proceeding to Phase 2.

**Phase 2: TDD (The Bricks) (STRICT RED-GREEN-REFACTOR)**
- Implement the approved SDD using strict Red-Green-Refactor methodologies.
- **RED:** Write tests that validate the exact API contracts defined in the SDD. The test must fail with a *specific, expected message*.
- **GREEN:** Write the minimal code to satisfy the SDD and pass the tests.
- **REFACTOR:** Optimize for readability and performance *after* green.
- **SELF-DOCUMENTING CODE:** Comments are code smells. Code must be expressive and idiomatic. Use comments ONLY for non-obvious "Why" (business logic constraints or architectural decisions), never for "What" or "How".
- **ZERO PLACEHOLDERS:** Never use `// TODO` or `// implementation here`. Deliver complete, functional units.

## 2. Cybersecurity & Trust (Mandatory)
- **SECRET BLINDNESS:** Never hardcode keys, tokens, or credentials. Use `.env` and verify `.gitignore` before every write.
- **DEPENDENCY GUARD:** Verify package names for typosquatting before installation. Check `npm audit` (or equivalent) for new dependencies.
- **THREAT MODELING:** Assume all external input (API, CLI, User) is hostile. Mandate sanitization, escaping, and parameterized queries.
- **LEAST PRIVILEGE:** Use minimal system and file permissions. Never suggest broad `chmod` (e.g., `777`) or insecure shell execution (`eval`, raw shell spawning).

## 3. Generalist Discovery & Context Loading
- **ENVIRONMENT AWARENESS:** The first step of every session MUST be to identify the tech stack and architecture (e.g., `package.json`, `Cargo.toml`, `go.mod`, `pyproject.toml`).
- **DYNAMIC RULE LOADING:** Once the stack is identified, check both the global rule directory (`~/.config/opencode/rules/`) and the project-local rule directory (`.opencode/rules/`) for applicable specialized instructions (e.g., `ts-stack.md`, `python-stack.md`, `ci-cd-flow.md`). **Read and internalize those files before proceeding.**
- **CI/CD RECONNAISSANCE:** Before assuming test or build commands, check for `.github/workflows`, `Makefile`, `Justfile`, or custom scripts. Always use the project's established scripts to ensure parity with the CI pipeline.
- **IDIOMATIC PRECEDENCE:** Match the project's native style conventions rigorously (e.g., Pythonic for Python, Go-idiomatic for Go).

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

## 7. Tool Preference Rules
- **PREFER MODERN TOOLS:** Always use `rg` (ripgrep) instead of `grep` and `eza --icons --git` instead of `ls` when available.
- **VERBOSE LISTING:** When using `eza`, prefer `-la` for a comprehensive view of the directory state.
- **SMART SEARCH:** Use `rg` with its default smart filtering (respecting `.gitignore`) unless explicitly asked to search ignored files.
- **CONTEXT SAFETY:** When doing initial discovery, always prefer `rg -l` (list matching files) or `rg -C 0` (no surrounding context) to gauge the volume of results before dumping massive file contents into your workspace.

## 8. Clean Room & CI/CD Execution Protocol
- **ISOLATED WORKSPACES:** All development MUST occur in a disposable, short-lived environment (a dedicated Git branch like `feat/<feature-name>` or `fix/<bug-name>`). Never commit directly to `main` or `master`.
- **ATOMIC COMMITS (THE "SAVE GAME" RULE):** Do not wait until a feature is completely finished to commit. You MUST commit your work locally every time you successfully complete a "GREEN" phase in the TDD cycle. Use conventional commit messages (e.g., `feat:`, `fix:`, `test:`).
- **PIPELINE AS THE JUDGE:** Local RED-GREEN-REFACTOR is the baseline, but the CI pipeline is the ultimate gatekeeper. The agent must run all project-level validation (linters, type-checkers, full test suites) within its isolated environment before proceeding.
- **PUSHING & PULL REQUESTS:** NEVER push directly to `main` or `master`. You may only push code to your isolated feature branch. Only push to the remote when a feature is fully completed and verified locally, immediately followed by packaging the changes into a Pull Request (using `gh pr create` or equivalent). The PR description must explicitly document the original failing state (RED) and the implemented solution (GREEN).
- **EPHEMERAL BRANCHING (STATE RESET):** If an approach fundamentally fails, results in a complex/tangled Git history, or hallucinates beyond the scope, ABANDON THE BRANCH. Do not try to fix a poisoned context. Create a fresh branch from the main repository to ensure a clean slate.
- **TRIVIAL EXCEPTION:** For minor typo fixes, single-file scripts, or explicit 'quick hacks', you may commit directly to the current branch. All architectural changes or multi-file features MUST use the full Pull Request pipeline.