---
name: ts-stack
description: Use this skill whenever you are working on a JavaScript, TypeScript, or Node.js project. It provides the required ecosystem tools, testing frameworks, and validation libraries.
---
# TypeScript / JavaScript Stack Rules

When operating in a JS/TS environment, adhere to the following ecosystem preferences unless the project strictly dictates otherwise:

- **Package Manager:** Always prefer `pnpm` for installing dependencies.
- **Runtime:** Prefer `Bun` if the environment supports it, otherwise fallback to standard Node.js.
- **Testing:** Use `Vitest` as the primary test runner.
- **Validation:** Use `Zod` for strict schema validation at all trust boundaries.
- **Typing:** Strict TypeScript is mandatory. Never use `any`. Use `unknown` for unvalidated external input before passing it through Zod.