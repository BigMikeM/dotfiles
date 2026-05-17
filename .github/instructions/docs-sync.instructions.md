---
description: "Use when editing README, TODO, or setup docs in this repo. Keeps command examples, distribution notes, and feature status synchronized with scripts and package lists."
name: "Dotfiles Documentation Sync"
applyTo: "README.md, TODO.md, .github/copilot-instructions.md"
---
# Dotfiles Documentation Sync

- Treat every rule below as mandatory for matching files.
- Keep docs aligned with current script behavior in scripts/bootstrap, scripts/update, and scripts/package_list.
- When adding or changing flags, commands, or flows in scripts, update affected docs in the same change.
- Keep distribution-specific notes accurate for Fedora, Ubuntu or Debian, Arch, WSL, Pop!_OS, and Raspberry Pi.
- Do not mark work as complete in TODO unless implementation already exists.
- Prefer concise, copy-paste-safe command examples.
- If a feature is optional, document both default behavior and opt-in flags.
- If a package source changes (system, cargo, uv, npm, snap, flatpak), update docs that describe installation strategy.
- Preserve the repository style of practical guidance over marketing language.
