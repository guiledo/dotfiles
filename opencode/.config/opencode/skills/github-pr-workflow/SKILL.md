---
name: github-pr-workflow
description: Clean Room workflow for rigorous CI/CD execution, versioning, and Pull Request submission. Use this skill whenever the user asks to "wrap up", "finalize a feature", "create a PR", "submit code", or explicitly requests the PR workflow.
---

# GitHub PR & CI/CD Workflow

This skill enforces a "Clean Room" workflow. We do this to protect the main branch, ensure all code is peer-reviewable, and guarantee that CI checks pass in an isolated environment.

## Workflow Steps

### 1. Ephemeral Branches
All work must occur on an ephemeral branch. This isolates our changes.
- Checkout a new branch: `git checkout -b feat/<name>` or `fix/<name>`.

### 2. Self-Review & Cleanup
Before committing, review the changes to ensure quality.
- Run `git diff` to check for debugging artifacts (e.g., `console.log`, `print`, commented-out code). Remove them.

### 3. Local Validation
Never push broken code. Validate everything locally first to save CI resources and time.
- Run the project's linters (e.g., `npm run lint`, `flake8`).
- Run type checkers (e.g., `tsc`, `mypy`).
- Run the native test suite.
- If any checks fail, fix them before proceeding.

### 4. Atomic & Semantic Commits
Commits should tell a story. Use Conventional Commits to make the history readable and automatable.
- **Format**: `<type>(<scope>): <description>`
- **Types**: `feat`, `fix`, `docs`, `style`, `refactor`, `test`, `chore`.
- Example: `feat(auth): implement JWT validation`

### 5. Create Pull Request
Propose the changes for review.

1. Attempt to use the GitHub CLI: `gh pr create --title "..." --body "..."`
2. **Fallback**: If `gh` is not installed or fails due to authentication, push the branch (`git push -u origin HEAD`) and provide the user with the PR creation URL returned by Git so they can open it in their browser.

### PR Description Template
When creating the PR (via CLI or providing text for the user), use this structure to explain the *why* and *how*:

```markdown
## Context
Why is this change necessary? (Link to issue or explain the initial failing state).

## Solution
What was done to fix the issue or implement the feature? 

## How to Validate
Steps the reviewer can take to verify the change locally.
```