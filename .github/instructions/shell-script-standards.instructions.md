---
description: "Use when editing shell automation in this repo (scripts, bin, install). Enforces strict mode, safe quoting, and existing utility patterns for cross-distribution compatibility."
name: "Dotfiles Shell Script Standards"
applyTo: "scripts/**, bin/**, install, lib/**/*.zsh, home/.zsh*"
---
# Dotfiles Shell Script Standards

- Treat every rule below as mandatory for matching files.
- Use bash for automation scripts unless the file is explicitly zsh config.
- Keep strict mode enabled near the top: `set -euo pipefail`.
- Keep existing trap/error patterns intact when present.
- Quote variable expansions and paths (use `"$var"` style).
- In functions, split `local` declaration and command substitution into separate lines.
- Prefer existing helpers from `scripts/utils` (for example `_exists`, `info`, `warn`, `error`, `run_command`) instead of re-implementing logic.
- Preserve idempotency and dry-run behavior for install/update/bootstrap flows.
- Keep changes cross-distribution safe (Fedora, Ubuntu/Debian, Arch, WSL, Raspberry Pi).
