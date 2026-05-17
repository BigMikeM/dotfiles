# GitHub Copilot Instructions for Dotfiles Repository

> **Maintenance note:** Keep this file short and high signal. Put detailed or
> file-type-specific rules in scoped instruction files under
> `.github/instructions/`.
>
> **Last Updated:** May 17, 2026

## Purpose

This repository automates Linux environment setup and maintenance across multiple
platforms. Copilot should optimize for safety, idempotency, and
cross-distribution compatibility.

## Always-On Rules (Project-Wide)

- Prefer minimal, targeted edits that preserve existing script style and flow.
- Keep shell automation idempotent and safe to rerun.
- Preserve dry-run behavior and interactive prompt semantics where they exist.
- Preserve cross-distribution behavior for Fedora, Ubuntu or Debian, Arch, WSL,
  Pop!_OS, and Raspberry Pi.
- Reuse existing helpers from `scripts/utils` and existing script patterns
  before introducing new abstractions.
- If behavior changes in `scripts/bootstrap`, `scripts/update`,
  `scripts/package_list`, or `install.conf.yaml`, update docs in the same
  change.
- Do not edit `dotbot/` unless explicitly requested.

## Source of Truth

When uncertain, verify behavior from source files, not assumptions:

- `scripts/bootstrap`
- `scripts/update`
- `scripts/package_list`
- `scripts/utils`
- `install.conf.yaml`
- `lib/alias.zsh`
- `scripts/check-docs`

## Customization Layout (Use the Right Primitive)

Use this file only for universal repo rules. Use scoped customizations for
better relevance and lower context noise.

### Separate Instruction Files

- `.github/instructions/shell-script-standards.instructions.md`
  - Mandatory shell and zsh editing standards for script-like files.
- `.github/instructions/python-utility-standards.instructions.md`
  - Mandatory Python utility standards (typing, docstrings, pathlib, strictness).
- `.github/instructions/docs-sync.instructions.md`
  - Documentation synchronization rules for README, TODO, and repo guidance.

### Prompt Files

- `.github/prompts/add-package-across-distros.prompt.md`
  - Repeatable package-add workflow with distro and package-manager checks.

### Candidate Agent / Skill Split

Use custom agents or skills when a task is multi-stage and repeated.

- Candidate custom agent: package maintenance
  - Best for multi-step work across `scripts/package_list`, `scripts/bootstrap`,
    `scripts/update`, and docs.
  - Goal: isolate a repeatable workflow with clear output sections and checks.
- Candidate skill: distro package verification
  - Best for reusable validation steps (name mapping, manager selection,
    Raspberry Pi constraints, Flatpak or Snap decisions).

## Maintenance Triggers

Update this file when project-wide behavior changes, especially:

- Supported distributions or global compatibility strategy changes.
- Project-wide safety rules or contribution standards change.
- Instruction architecture changes (new core files under `.github/`).

For detailed policy updates, prefer editing the scoped files in
`.github/instructions/` instead of expanding this file.

## Validation

After instruction updates:

- Run `./scripts/check-docs`.
- Confirm referenced customization files exist.
- Keep this file concise to reduce always-on token overhead.
