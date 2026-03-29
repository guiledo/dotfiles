---
name: frontend-semantic-auditor
description: "Enforces web semantics, Accessibility (A11y/WCAG), and On-Page SEO best practices. Make sure to use this skill whenever the user asks to create a landing page, finalize a UI component, audit a web page, or explicitly mentions SEO or accessibility."
---

# Frontend Semantic Auditor (A11y & SEO)

This skill ensures that all generated frontend code (HTML, React, Vue, etc.) is fully accessible to assistive technologies (screen readers) and highly optimized for search engine crawlers (Googlebot). Both domains rely on strict, semantic markup.

## Core Semantic Rules

### 1. The "Div" Ban (Semantic HTML First)
- **NEVER** use a `<div>` or `<span>` if a native semantic element exists for the task.
- Use `<nav>` for navigation links.
- Use `<main>` for the primary content of the page (only one per page).
- Use `<article>` for self-contained content (blog posts, product cards).
- Use `<aside>` for secondary content (sidebars).
- Use `<header>` and `<footer>` appropriately.
- *Why:* Both screen readers and search engines use these landmarks to understand page structure without needing to execute JavaScript or parse CSS.

### 2. Interaction & Keyboard Accessibility
- **Buttons vs. Links:**
  - If it navigates the user to a new URL, it MUST be an `<a>` tag with an `href`.
  - If it triggers an on-page action (open modal, submit form, toggle state), it MUST be a `<button>`.
- **NEVER** add `onClick` to a `<div>` or `<span>`. If you must make a non-interactive element clickable, you must also add `role="button"` and `tabIndex={0}`, and handle the `onKeyDown` event for `Enter` and `Space` keys.

### 3. Heading Hierarchy (H1-H6)
- Every page MUST have exactly one `<h1>` that describes the main topic.
- **NEVER** skip heading levels (e.g., jumping from `<h2>` directly to `<h4>`). Headings form the outline of the document for both SEO indexing and screen reader navigation.
- Do not use headings just to make text bold or large. Use CSS for styling; use headings for structure.

### 4. Forms & Inputs
- Every `<input>`, `<select>`, and `<textarea>` MUST have an associated `<label>`.
- Use the `htmlFor` (React) or `for` (HTML) attribute on the label pointing to the input's `id`.
- If a visible label breaks the design, use `aria-label` or `aria-labelledby` on the input.

### 5. Media & Assets
- Every `<img>` tag MUST have an `alt` attribute.
  - If the image is purely decorative, use an empty alt attribute (`alt=""`). Do not omit the attribute entirely.
  - If the image contains information, describe the *information*, not the visual appearance (e.g., `alt="Sales chart showing 20% growth"` instead of `alt="Red line going up"`).

### 6. Meta Tags & Document Setup
When generating full page structures or document heads (e.g., Next.js `metadata` or standard `<head>`):
- Ensure the `<html>` tag has a `lang` attribute (e.g., `lang="en"`).
- Always include a concise `<title>` and a `<meta name="description" content="..." />`.
- Use OpenGraph tags (`og:title`, `og:description`, `og:image`) for social sharing.

## Workflow
1. **Audit:** When reviewing UI code, scan for generic `div` soup and missing interactive boundaries.
2. **Refactor:** Replace generic containers with semantic landmarks.
3. **Validate:** Mentally verify: "Can I navigate this entire component using only the Tab key?" and "If I turn off CSS, does the content still make logical sense reading from top to bottom?"