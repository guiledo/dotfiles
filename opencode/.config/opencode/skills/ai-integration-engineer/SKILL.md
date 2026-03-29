---
name: ai-integration-engineer
description: "Enforces production-ready AI/LLM integration patterns. Make sure to use this skill whenever the user asks to integrate with OpenAI, Anthropic, Gemini, build an AI agent, create a RAG pipeline, or write prompt templates."
---

# AI Integration Engineer

This skill ensures that integrations with Large Language Models (LLMs) are resilient, secure, and predictable. AI models are non-deterministic by nature; our code must aggressively wrap them in deterministic constraints.

## Core Integration Rules

### 1. Structured Outputs are Mandatory
- **NEVER** ask an LLM to "return JSON" using just plain text instructions (e.g., `"Return a JSON with the keys name and age"`).
- **ALWAYS** use the provider's native Structured Output features (e.g., `response_format: { type: "json_object" }`, OpenAI's Structured Outputs, or Function Calling / Tool Use).
- You MUST validate the LLM's response against a strict schema (using Zod in TypeScript, Pydantic in Python, etc.) *before* letting the application use the data.

### 2. Prompt Architecture (Separation of Concerns)
- **NEVER** mix instructions and user data in a single string (e.g., `const prompt = "Summarize this: " + userInput`). This is highly susceptible to Prompt Injection.
- **ALWAYS** strictly separate the `System Message` (which dictates persona, rules, and output format) from the `User Message` (which should contain only the data to be processed).

### 3. Resilience and Cost Control
- **Timeouts & Retries:** AI APIs are notoriously slow and prone to 529/503 errors. Always wrap calls in a robust retry mechanism with exponential backoff (e.g., using `p-retry`, `tenacity`, or native SDK utilities).
- **Max Tokens:** Always explicitly set `max_tokens` (or `max_completion_tokens`) to prevent runaway generation that spikes billing and latency.

### 4. RAG (Retrieval-Augmented Generation) Constraints
- If fetching data from a Vector Database to feed the LLM, always instruct the LLM to *only* use the provided context.
- Example System Instruction snippet: `"Answer the user's question using ONLY the provided context. If the answer is not contained in the context, say 'I do not have enough information'."`

### 5. Logging and Telemetry
- Never log the full user prompt or completion if it might contain PII (Personally Identifiable Information).
- Do log token usage (prompt tokens, completion tokens) and latency for every call to monitor costs and performance.

## Workflow
1. **Define Schema:** Before writing the API call, define the Zod/Pydantic schema of what the LLM *must* return.
2. **Draft Prompts:** Write the System Prompt as a constant.
3. **Implement Call:** Write the API call using native Structured Outputs, including retry logic and schema validation.