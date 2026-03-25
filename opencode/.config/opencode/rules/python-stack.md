# Python Stack Rules

When operating in a Python environment, adhere to the following ecosystem preferences unless the project strictly dictates otherwise:

- **Dependency Management:** Look for and respect `pyproject.toml` (e.g., Poetry, uv, or Hatch).
- **Testing:** Use `pytest`. Structure tests to use fixtures (`conftest.py`) rather than shared mutable state.
- **Validation & Typing:** Use `pydantic` for data validation and settings management. Strict type hinting (`typing` module) is mandatory for all function signatures.
- **Formatting:** Assume `ruff` or `black` for formatting and linting.