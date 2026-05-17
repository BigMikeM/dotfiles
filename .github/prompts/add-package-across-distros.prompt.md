---
description: "Use when adding a package to scripts/package_list with cross-distribution safety checks and documentation follow-up."
name: "Add Package Across Distros"
argument-hint: "Package name and where it should be installed"
agent: "agent"
---
Add a package to this dotfiles repo using the request: ${input}

Follow this workflow:
1. Open scripts/package_list and identify the best target arrays by platform and package manager.
2. Prefer system package managers first, then cargo, uv, npm, snap, or flatpak only when justified.
3. Check naming differences across Fedora, Ubuntu or Debian, Arch, WSL, Pop!_OS, and Raspberry Pi.
4. Keep existing grouping and comment style in scripts/package_list.
5. Avoid breaking lightweight Raspberry Pi package strategy.
6. If needed, update scripts/bootstrap or scripts/update so installation and updates stay consistent.
7. If behavior or package strategy changes, update README.md and TODO.md when relevant.
8. Summarize:
   - Files changed
   - Which arrays were updated
   - Why each package manager target was chosen
   - Any distro caveats
   - Suggested verification commands
