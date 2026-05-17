---
description: "Use when creating or editing Python utilities for this dotfiles repo. Enforces strict type hints, Google-style docstrings, and pathlib-based file handling."
name: "Dotfiles Python Utility Standards"
applyTo: "scripts/**/*.py, bin/**/*.py"
---
# Dotfiles Python Utility Standards

- Treat every rule below as mandatory for matching files.
- Use this header order:
  1. Shebang: #!/usr/bin/env python3
  2. Standard library imports, then third-party imports, then local imports.
- Add full type hints for all function parameters and return values.
- Use modern typing syntax such as list[str], dict[str, int], and Path | None.
- Use Google-style docstrings for public functions, with sections for Args, Returns, and Raises when applicable.
- Keep lines at 80 characters or fewer unless a clear readability exception is needed.
- Use pathlib.Path for filesystem paths instead of os.path.
- For boolean options in function signatures, prefer keyword-only parameters.
- Build exception messages in variables before raising.
- Keep code compatible with strict type checking.
- Enforce the use of `ruff` for linting Python code.
- Adopt the rules specified in the VS Code settings file, including `ruff.lint.extendSelect` and `ruff.lint.ignore` configurations.
