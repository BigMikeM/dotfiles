---
name: distro-package-verification
summary: Reusable validation steps for verifying package names and manager selection across distributions.
description: |
  This skill provides reusable validation steps for verifying package names and manager selection across distributions. It is designed to complement the package maintenance agent by ensuring that package names are valid and compatible with the target distribution. The skill also handles Raspberry Pi constraints, Flatpak or Snap decisions, and other distribution-specific considerations.

  Use this skill when:
  - Validating package names for compatibility with a specific distribution.
  - Selecting the appropriate package manager for a given distribution.
  - Handling special cases like Raspberry Pi constraints or Flatpak/Snap decisions.

  Do not use this skill for:
  - Adding, removing, or updating packages (use the package maintenance agent instead).
  - General-purpose package management tasks outside the scope of distribution-specific validation.

  This skill is intended to be used in conjunction with the package maintenance agent for a comprehensive package management workflow.

examples:
  - "Validate if 'curl' is available for Fedora and Ubuntu."
  - "Check if 'snapd' is supported on Raspberry Pi."
  - "Determine the correct package manager for Arch Linux."

---

# Distro Package Verification Skill

## Purpose
This skill ensures that package names and manager selections are valid and compatible with the target distribution. It handles distribution-specific considerations, including:
- Package name validation.
- Package manager selection.
- Special cases like Raspberry Pi constraints.
- Flatpak or Snap decisions.

## Usage
Use this skill to validate package names and select the appropriate package manager for a given distribution. It is designed to complement the package maintenance agent for a comprehensive package management workflow.

## Examples
- Validate if 'curl' is available for Fedora and Ubuntu.
- Check if 'snapd' is supported on Raspberry Pi.
- Determine the correct package manager for Arch Linux.

## Limitations
- This skill does not handle adding, removing, or updating packages. Use the package maintenance agent for those tasks.
- It is not intended for general-purpose package management tasks outside the scope of distribution-specific validation.

## Implementation
This skill uses existing helpers from `scripts/utils` and follows the project's cross-distribution compatibility strategy. It ensures that validation steps are reusable and maintainable.
