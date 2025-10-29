# Contributing to BigMikeM's Dotfiles

Thank you for your interest in this dotfiles repository! While this is primarily a personal configuration repository, contributions and suggestions are welcome.

## Getting Started

This repository uses:
- **Dotbot** for installation and symlink management
- **Bash** for automation scripts
- **Zsh** for shell configuration
- Multiple package managers across different distributions

## How to Contribute

### Reporting Issues

If you find bugs or have suggestions:
1. Check existing issues to avoid duplicates
2. Provide your OS/distribution version
3. Include relevant error messages or logs
4. Describe expected vs actual behavior

### Submitting Changes

1. **Fork** the repository
2. **Create a branch** for your changes
3. **Test thoroughly** with `--dry-run` mode
4. **Follow coding standards** (see below)
5. **Update documentation** (see Documentation Maintenance)
6. Submit a **pull request** with clear description

## Development Guidelines

### Testing Changes

```bash
# Always test scripts with dry-run first
./scripts/bootstrap --dry-run --verbose
./scripts/update --dry-run --verbose

# Test on clean environment if possible
# VM or container recommended for major changes
```

### Code Quality

```bash
# Run shellcheck on modified bash scripts
shellcheck scripts/bootstrap
shellcheck scripts/update
shellcheck scripts/utils

# Check for broken symlinks after install
./install
find ~ -xtype l -maxdepth 3
```

### Coding Standards

**Shell Scripts (Bash):**
- Use `#!/bin/bash` or `#!/usr/bin/env bash`
- Include `# -*- mode: sh -*-` for editor hints
- Start with `set -euo pipefail`
- Add error traps: `trap on_error ERR SIGTERM SIGINT`
- Quote all variables: `"$variable"`
- Use descriptive function names: `install_package()`
- Prefix private functions with underscore: `_exists()`
- Return 0 for success, non-zero for failure
- Add comments explaining complex logic

**Shell Scripts (Zsh):**
- Use `#!/bin/zsh` or `#!/usr/bin/env zsh`
- Use zsh array syntax: `array=(item1 item2)`
- Use `[[ ... ]]` for conditionals
- Declare local variables: `local variable_name`

**CLI Arguments:**
- Support `--help`, `--verbose`, `--dry-run`, `--yes`
- Use consistent flag naming across scripts
- Provide usage() function with examples

## Documentation Maintenance

### ⚠️ CRITICAL: Keep Copilot Instructions Updated

The `.github/copilot-instructions.md` file is essential for GitHub Copilot to understand this repository. **Always update it** when making significant changes.

**Update Copilot Instructions when changing:**
- ✏️ Scripts or utilities (add/remove/modify)
- 🔧 Core functionality in bootstrap/update
- 📦 Package lists or installation strategies
- ⚙️ Configuration files or tools
- 📋 Coding standards or best practices
- 🐧 Supported distributions or requirements
- 📝 Shell aliases or functions

**Also update:**
- `README.md` - User-facing documentation and examples
- `TODO.md` - Mark completed items, add new planned features
- Function comments - For significant logic changes
- **Last Updated date** in copilot-instructions.md header

### Documentation Checklist

Before submitting a pull request:

- [ ] Updated `.github/copilot-instructions.md` if applicable
- [ ] Updated `README.md` with new features/changes
- [ ] Updated `TODO.md` if implementing planned features
- [ ] Added/updated function comments for new code
- [ ] Tested with `--dry-run` mode
- [ ] Ran `shellcheck` on modified bash scripts
- [ ] Verified symlinks work correctly
- [ ] Updated examples if command syntax changed

## Package Management

When adding packages to `scripts/package_list`:

**Priority Strategy:**
1. **System packages** (rpm, apt, pacman) - Best integration
2. **Cargo packages** - Modern, fast alternatives
3. **Python/Node packages** - Development tools
4. **Snap packages** - Only when necessary (VS Code)
5. **Flatpak packages** - Only for exclusive apps

**Checklist for new packages:**
- [ ] Added to correct array for each distribution
- [ ] Checked package name across distros (names differ!)
- [ ] Grouped by category with comments
- [ ] Documented why non-system package manager chosen
- [ ] Tested installation on target distribution

## Distribution Support

This repository targets:
- **Fedora/RHEL/CentOS** (DNF/YUM)
- **Ubuntu/Debian** (APT)
- **Arch Linux** (Pacman/Paru)
- **WSL** (Windows Subsystem for Linux)

When adding distribution-specific code:
- Use utility functions: `_get_distro()`, `_is_wsl()`
- Test on target distribution if possible
- Document any distribution-specific quirks
- Consider package name variations

## Questions?

- Review the [Copilot Instructions](.github/copilot-instructions.md) for detailed architecture
- Check existing code for patterns and examples
- Open an issue for clarification before major changes

## License

This is personal configuration, use at your own risk. Originally based on [denysdovhan/dotfiles](https://github.com/denysdovhan/dotfiles).

---

**Thank you for helping improve this dotfiles repository!** 🚀
