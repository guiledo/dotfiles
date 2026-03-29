---
name: sdd-tdd-workflow
description: Rigorous planning and test-driven implementation (TDD) workflow. Make sure to use this skill whenever the user mentions creating a new feature from scratch, requests system architecture, asks for an SDD, mentions TDD, or wants to build something complex that requires upfront design.
---

# SDD & TDD Workflow

This skill enforces strict engineering standards for complex features and architectural work by focusing on upfront alignment and test-driven reliability.

## Phase 1: System Design Document (SDD)

Before writing production code, we must align on the architecture and contracts. The SDD serves as our blueprint to prevent late-stage refactoring and scope creep.

1.  **Empirical Reconnaissance**: Analyze the current codebase using search tools to understand existing patterns, types, and dependencies.
2.  **Spike (Optional)**: If the solution is highly uncertain, you may write temporary exploratory code ("Spike") to validate assumptions. This code must be discarded or fully test-covered later.
3.  **Create SDD**: Draft a System Design Document in `.opencode/plans/<feature>.md`.

### SDD Template
ALWAYS use this structure for the SDD to ensure we cover all critical boundaries:

```markdown
# [Feature Name] Architecture

## 1. Objective & Non-Goals
- **Objective**: What are we building and why?
- **Non-Goals**: What is explicitly out of scope? (Crucial for preventing scope creep).

## 2. Architecture Overview
- How does this fit into the existing system?

## 3. Public API Contracts
- Exact signatures of functions, classes, or endpoints we will expose.

## 4. Data Schemas & Trust Boundaries
- Data structures and where validation occurs.

## 5. Testing Strategy
- What edge cases and happy paths will we test?
```

4.  **Request Approval**: Present the drafted SDD to the user and ask for explicit approval before proceeding to implementation.

## Phase 2: Test-Driven Development (TDD)

Once the SDD is approved, we implement it using the Red-Green-Refactor cycle. This ensures our API design is consumer-focused (the test is the first consumer) and that our code is provably correct.

1.  **Red (Test First)**: Write a failing test based on the SDD's contracts. The test must fail with a clear message indicating what is missing.
2.  **Green (Make it Pass)**: Write the *minimum* amount of code necessary to make the test pass.
3.  **Refactor**: Clean up the code, improve naming, and remove duplication without changing behavior. Ensure tests still pass.

### Engineering Standards
- **No Placeholders**: Write complete, functional code. Never use `// TODO` or `// ... rest of code`.
- **Self-Documenting Code**: Explain *why* something is done in comments, not *what*. Let the code structure explain the *what*.