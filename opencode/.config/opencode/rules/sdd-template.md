# System Design Document (SDD) Template

Every SDD written to `.opencode/plans/` MUST follow this structure to ensure all architectural and security constraints are addressed before implementation begins.

## 1. Architecture Overview
- **Goal:** A brief summary of what is being built and why.
- **Context:** How this feature fits into the broader system.

## 2. Public API Contracts
- **Interfaces:** Define the exact functions, classes, or endpoints exposed to other parts of the system.
- **Inputs/Outputs:** Specify the expected arguments and return values.

## 3. Data Schemas & Types
- **Models:** Define the data structures (e.g., database tables, JSON payloads).
- **Strict Typing:** Specify the exact types (e.g., avoiding `any` in TypeScript, using `Pydantic` models in Python).

## 4. Trust Boundaries & Security
- **Input Validation:** Identify where external data enters the system and how it will be sanitized/validated.
- **Permissions:** Note any authorization checks required.

## 5. Testing Strategy (The "RED" Phase Setup)
- **Scenarios:** Outline the specific test cases that will be written.
- **Expected Failures:** State the exact failure messages or conditions expected before the implementation is written.