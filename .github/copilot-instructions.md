# GitHub Copilot Instructions for Dotfiles Repository

> **⚠️ MAINTENANCE NOTE:** This file should be kept in sync with repository
> changes.
>
> **When to update this file:**
>
> - Adding/removing scripts or utilities
> - Changing core functionality in bootstrap/update scripts
> - Modifying package lists or installation strategies
> - Adding new configuration files or tools
> - Changing coding standards or best practices
> - Updating supported distributions or requirements
>
> **Last Updated:** November 22, 2025

## Project Overview

This is a personal Linux dotfiles repository for maintaining consistent
configurations across multiple distributions and installations. It's based on
[denysdovhan/dotfiles](https://github.com/denysdovhan/dotfiles) but heavily
customized for personal use. The repository uses
[Dotbot](https://github.com/anishathalye/dotbot) as its installation framework.

**Repository Owner:** BigMikeM **Primary Use Case:** Automating Linux
environment setup with consistent configurations for development tools, shells,
editors, and GUI applications.

## Core Philosophy

1. **Cross-Distribution Compatibility:** Scripts must work across Fedora,
   Ubuntu/Debian, Arch Linux, and WSL
2. **Idempotent Operations:** All installation and update scripts should be safe
   to run multiple times
3. **User-Friendly:** Interactive prompts with sensible defaults, dry-run modes,
   and verbose output options
4. **Modular Design:** Clear separation between scripts, configurations, and
   utility functions
5. **Error Resilience:** Comprehensive error handling with helpful error
   messages and recovery paths

## Repository Structure

```
.dotfiles/
├── install                    # Main Dotbot installation script (bash)
├── install.conf.yaml          # Dotbot configuration (symlinks, directory creation)
├── bin/                       # Custom utility scripts and commands
│   ├── emptytrash            # System trash management
│   ├── git-cleanup           # Git repository maintenance
│   ├── git-fork              # Git fork setup utility
│   ├── git-upstream          # Git upstream sync utility
│   ├── nyan                  # Fun nyan cat display
│   └── password              # Random password generator
├── scripts/                   # Main automation scripts
│   ├── bootstrap             # Full system setup (670+ lines, bash)
│   ├── update                # System and package updates (400+ lines, bash)
│   ├── utils                 # Shared utility functions (269 lines, bash)
│   ├── package_list          # Package definitions by distro (442 lines, bash)
│   └── fg_colors             # Terminal color definitions (158 lines, bash)
├── lib/                       # Zsh configuration libraries
│   ├── alias.zsh             # Comprehensive shell aliases (480 lines)
│   └── lscolors.zsh          # LS_COLORS configuration (190 lines)
├── home/                      # User home directory configurations
│   └── config/               # XDG config directory files
│       ├── alacritty/        # Alacritty terminal config
│       ├── kitty/            # Kitty terminal config
│       ├── neovide/          # Neovide GUI config
│       ├── nvim/             # Neovim/AstroNvim configuration
│       ├── ranger/           # Ranger file manager config
│       └── sheldon/          # Sheldon plugin manager (plugins.toml)
└── dotbot/                   # Dotbot submodule (do NOT modify)
```

## Key Technologies & Tools

### Package Managers by Distribution

- **Fedora/RHEL/CentOS:** DNF 5 (modern Fedora default) (`rpm_packages`, `rpm_groups`, `rpm_nonfree`)
- **Ubuntu/Debian:** APT (`apt_packages`, `wsl_packages` for WSL)
- **Arch Linux:** Pacman/Paru (`arch_packages`)
- **Language-Specific:**
  - **Rust:** Cargo (`cargo_packages`) - Includes uv, sheldon, fd-find, ripgrep,
    lsd, etc.
  - **Python:** uv (`uv_packages`) - Fast Python package manager (Rust-based),
    development tools, Jupyter, data science basics
  - **Node.js:** npm (`npm_packages`) - Via fnm (Fast Node Manager), includes
    TypeScript, build tools, global utilities
  - **Snap:** (`snap_packages`) - Currently only VS Code
  - **Flatpak:** (`flatpak_packages`) - Discord, Spotify, Flatseal

### Development Environment Stack

- **Shell:** Zsh (required, set as default shell)
- **Shell Plugin Manager:** [Sheldon](https://sheldon.cli.rs/) (Rust-based)
- **Shell Plugins:** oh-my-zsh, zsh-syntax-highlighting, zsh-autosuggestions,
  zsh-autopair, zsh-z, alias-tips
- **Editor:** Neovim with [AstroNvim v5+](https://astronvim.com/)
- **Terminal Emulators:** Kitty (primary), Alacritty (alternative)
- **File Manager:** Ranger (CLI)
- **Version Control:** Git with custom utilities (gh CLI)
- **Languages:**
  - **Go:** Managed via official installer (optional)
  - **Node.js:** Managed via fnm (Fast Node Manager, multiple LTS versions)
  - **Rust:** Managed via rustup (required for cargo packages)
  - **Python:** System Python 3 with [uv](https://docs.astral.sh/uv/) for
    package management (fast pip replacement)

### Custom Utilities in `scripts/utils`

**Environment Detection:**

- `_exists()` - Check if command exists
- `_is_container()` - Detect container environment
- `_is_wsl()` - Detect Windows Subsystem for Linux
- `_is_root()` - Check root privileges
- `_get_distro()` - Get distribution name
- `_get_arch()` - Get system architecture (amd64, arm64, etc.)
- `find_package_manager()` - Auto-detect system package manager

**Output Functions:**

- `info()` - Cyan informational messages
- `success()` - Green success messages
- `error()` - Red error messages (stderr)
- `warn()` - Yellow warning messages (stderr)
- `debug()` - Purple debug messages (when DEBUG=1)
- `progress()` - Progress indicator with percentage

**Utility Functions:**

- `backup_file()` - Safe file backup with timestamp
- `ensure_dir()` - Safe directory creation with permissions
- `download_file()` - Download with curl/wget fallback
- `retry()` - Retry failed operations with backoff
- `_current_shell()` - Get current shell
- `_user_default_shell()` - Get user's default login shell

### Color System (`scripts/fg_colors`)

Comprehensive terminal color support with fallback for non-color terminals:

- 8 base ANSI colors + 8 bright variants
- Extended 256 colors (selected palette)
- Text formatting: BOLD, DIM, ITALIC, UNDERLINE, BLINK, REVERSE, STRIKETHROUGH
- Background colors
- Color functions: `red()`, `green()`, `cyan()`, etc.
- Check: `_supports_color()` for terminal capability detection

### UV Python Package Manager

**Why UV?** Fast, Rust-based Python package manager that replaces pip,
virtualenv, and poetry with a single tool. Up to 10-100x faster than traditional
pip.

**Installation:** Installed via cargo as part of `cargo_packages`

**Key Commands:**

- `uv tool install <package>` - Install Python CLI tools in isolated
  environments
- `uv tool upgrade --all` - Upgrade all installed tools
- `uv tool list` - List installed tools
- `uv pip install <package>` - Drop-in pip replacement
- `uv venv` - Create virtual environments (faster than venv)
- `uv run <script>` - Run Python scripts with automatic dependency management
- `uv sync` - Sync project dependencies from pyproject.toml
- `uv add <package>` - Add dependency to pyproject.toml

**Integration:**

- Replaces `pip install --user` with `uv tool install` for CLI tools
- Bootstrap script uses uv if available, falls back to pip
- Update script upgrades all uv-managed tools
- Helper utility: `bin/uv-helper` provides convenient wrappers
- Aliases in `lib/alias.zsh`: `uvinstall`, `uvupgrade`, `uvlist`, `uvrun`

**Package Installation Strategy:**

1. System Python 3 (via distro package manager)
2. UV (via cargo)
3. Python packages (via uv tool install)
   - ruff (linter)
   - jupyter/jupyterlab
   - ipython
   - pandas, numpy, matplotlib
   - uv

**Benefits:**

- Fast: 10-100x faster than pip
- Isolated: Each tool in its own environment (no conflicts)
- Reproducible: Lock files ensure consistent installs
- Modern: Better error messages, progress bars
- Compatible: Drop-in pip replacement

## Script Execution Patterns

### Bootstrap Script (`scripts/bootstrap`)

**Purpose:** Full system setup from scratch

**Key Features:**

- Interactive mode with confirmation prompts
- CLI flags: `--yes`, `--dry-run`, `--verbose`, `--skip-*` flags
- Progress tracking with `COMPLETED_TASKS` and `FAILED_TASKS` arrays
- Component installation order:
  1. System packages (via distro package manager)
  2. Rustup and Cargo packages (required)
  3. fnm and Node.js (optional, LTS + latest)
  4. NPM packages (only if fnm installed)
  5. Go (optional, latest version)
  6. Python uv packages (optional)
  7. Neovim AppImage (optional, v0.11.3+)
  8. AstroNvim (optional)
  9. GitUI (optional)
  10. ZSH as default shell

**Error Handling:**

- `set -euo pipefail` with `trap on_error`
- Per-task failure tracking without breaking entire bootstrap
- Summary report at end

**Installation Functions:**

- `install_software()` - System packages via detected package manager
- `install_rustup()` - Rust toolchain installation
- `cargo_install()` - Batch install cargo packages
- `install_fnm()` - fnm (Fast Node Manager) with Node LTS and optional latest
- `npm_install()` - Global npm packages with error tracking
- `install_uv()` - uv Python package manager installation
- `uv_install()` - Python CLI tools via uv tool install
- `install_neovim()` - Latest stable Neovim AppImage to `/usr/local/bin/nvim`
- `install_astronvim()` - AstroNvim with backup of existing config
- `install_go()` - Latest Go from official source
- `set_zsh()` - Change default shell to zsh

### Update Script (`scripts/update`)

**Purpose:** Update existing system installations

**Key Features:**

- Updates: dotfiles repo, system packages, Flatpak, Snap, Homebrew, Rust, Cargo
  packages, Node.js versions, npm packages
- CLI flags: `--skip-system`, `--skip-node`, `--skip-rust`, `--dry-run`,
  `--verbose`, `--backup`
- Progress tracking with summary
- Optional backup creation before updates

**Update Functions:**

- `update_dotfiles()` - Git pull and re-run Dotbot
- `update_system()` - System package updates via distro package manager
- `update_rust()` - `rustup update`
- `cargo_update()` - `cargo install-update -a` (requires cargo-update package)
- `update_all_node()` - Updates all installed Node versions via fnm
- `npm_update()` - `npm update -g` for global packages
- `uv_update()` - `uv self update` and `uv tool upgrade --all` for Python tools
- `flatpak_update()`, `snap_update()`, `homebrew_update()` - Additional package
  managers

**Node Version Management:**

- Tracks current, default, and all LTS versions
- Updates each version independently
- Restores original active version after updates

### Package List (`scripts/package_list`)

**Package Priority Strategy:**

1. System packages (rpm, apt, pacman) - Highest priority for system integration
2. Cargo packages - Rust tools (better maintained, faster, modern alternatives)
3. Python/Node packages - Development tools
4. Snap packages - Only VS Code (for auto-updates)
5. Flatpak packages - Apps exclusive to Flatpak or officially supported

**Key Package Categories:**

- **Core Development:** zsh, git, cmake, gcc, g++, make, build-essential
- **Modern CLI Tools:** bat (cat replacement), fd-find (find), ripgrep (grep),
  lsd (ls), du-dust (du)
- **Development:** neovim, ranger, shellcheck, shfmt, gitui, gh (GitHub CLI)
- **Terminal Emulators:** kitty, alacritty
- **Python:** Development tools (black, isort, flake8, mypy, pylint), Jupyter,
  data science basics
- **Node.js:** TypeScript, build tools (webpack, vite), linters (eslint,
  prettier), dev servers
- **Rust:** Modern replacements (fd, ripgrep, bat alternatives), sheldon, cargo
  utilities, starship

## Zsh Configuration

### Alias System (`lib/alias.zsh`)

**Core Principles:**

- Enable `sudo` with aliases: `alias sudo='sudo '`
- Use modern tools when available with fallbacks
- Safe operations (trash instead of rm when available)
- Platform-aware (macOS, WSL, Linux detection)

**Key Alias Categories:**

1. **File Operations:**

   - `rm`/`rmf`/`rmi` - Trash-based deletion when available, fallback to rm
   - `cp` - rsync with progress if available
   - `ll`, `la`, `l`, `lt` - Enhanced ls with lsd/exa/ls fallback

2. **Directory Navigation:**

   - Smart dots: `..`, `...`, `....`, `.....`
   - Quick jumps: `dl` (Downloads), `dt` (Desktop), `doc` (Documents), `pn`
     (Notes)
   - Projects: `pc`, `pcf` (Forks), `pcw` (Work), `pcp` (Playground), `pcr`
     (Repos), `pcl` (Learning)
   - Config: `conf` → `~/.config`

3. **Editor & Commands:**

   - `e`, `edit` - Open `$EDITOR` (defaults to nvim)
   - `+x`, `x+` - Make executable
   - `644`, `755`, `777` - Quick permission changes

4. **Process Management:**

   - `psg` - Process grep
   - `psme` - User processes
   - `pscpu`, `psmem` - Sort by CPU/memory usage

5. **Network:**

   - `myip` - External IP via ifconfig.me
   - `localip` - Local network IP
   - `ports`, `listening` - Network connections

6. **Git Shortcuts:**

   - Single letter: `g` (git)
   - Two letter: `gs` (status), `ga` (add), `gc` (commit), `gp` (push), `gl`
     (pull), `gd` (diff), `gb` (branch)
   - `gco` (checkout), `gcb` (checkout -b), `gm` (merge), `gr` (rebase)
   - `glog`, `glogall`, `glast` - Enhanced log views
   - `git-root` - cd to repository root

7. **Dotfiles Management:**

   - `update` - Run update script
   - `bootstrap` - Run bootstrap script
   - `dotfiles`, `dots` - Edit dotfiles repo
   - `reload`, `rezsh` - Reload/restart shell

8. **Utility Helpers:**
   - `path` - Pretty-print PATH
   - `help`, `h` - tldr pages (if available)
   - `m` - man pages
   - `cat` → `bat` (if available with syntax highlighting)

### LS Colors (`lib/lscolors.zsh`)

**Platform-Specific:**

- BSD/macOS: LSCOLORS format (11 pairs)
- GNU/Linux: Comprehensive LS_COLORS with 100+ file types

**File Type Categories:**

- Archives/Compressed (red)
- Images (bright magenta)
- Videos (bright magenta)
- Audio (green)
- Documents (yellow)
- Code/Config (yellow/blue)
- Shell scripts (bright green)
- Backups/Temp (dark gray)
- Special files (README, LICENSE, Makefile - bright yellow)
- Version control files (dark gray)

**Zsh Completion Colors:**

- Matches ls colors for consistency
- Custom colors for descriptions, corrections, warnings
- Enhanced process, host, and git completion colors

## Dotbot Configuration (`install.conf.yaml`)

**Installation Steps:**

1. **Defaults:**

   - Link: `relink: true`, `force: true`, `create: true`, `glob: true`
   - Shell: `stdout: true`, `stderr: true`

2. **Clean:** Home directory cleanup (careful!)

3. **Create Directories:**

   - `~/.config`, `~/Notes`, `~/Downloads`, `~/Desktop`
   - `~/Projects/{Work,Playground,Repos,Learning}`

4. **Symbolic Links:**

   - `~/.config/` → All items in `home/config/*` (glob)
   - `~/` → All dotfiles in `home/.*` (e.g., `.zshrc`, `.gitconfig`)
   - `~/.local/share/` → `extras/*`

5. **Shell Commands:**
   - Initialize git submodules
   - Echo bootstrap reminder

## Custom Git Utilities (`bin/`)

### git-cleanup

**Purpose:** Remove old local branches where remote is gone **Usage:**
`git-cleanup [--force]` **Safety:** Without `--force`, shows what would be
deleted

### git-fork

**Purpose:** Add upstream remote for forked repositories **Usage:**
`git-fork <original-author>` **Result:** Adds remote:
`https://github.com/<original-author>/<repo>.git`

### git-upstream

**Purpose:** Sync branch with upstream **Usage:** `git-upstream [branch]`
(defaults to master) **Operations:** Fetches upstream, checks out branch, merges
upstream

### Other Utilities

- **emptytrash:** Clear system trash (Linux/macOS)
- **password:** Generate random password to clipboard (xclip/xsel/wl-copy
  support)
- **nyan:** Display nyan cat ASCII art (fun)

## Sheldon Plugin Management

**Configuration:** `home/config/sheldon/plugins.toml`

**Plugins in Use:**

1. **oh-my-zsh** - Base framework
2. **zsh-defer** - Defer loading for faster startup (romkatv/zsh-defer)
3. **alias-tips** - Show alias hints (djui/alias-tips) [deferred]
4. **zsh-syntax-highlighting** - Command syntax highlighting [deferred]
5. **zsh-autosuggestions** - Fish-like autosuggestions [deferred]
6. **zsh-autopair** - Auto-close brackets/quotes [deferred]
7. **zsh-better-npm-completion** - Enhanced npm completions [deferred]
8. **auto-notify** - Desktop notifications for long-running commands [deferred]
9. **z** - Frecency-based directory jumping (agkozak/zsh-z) [deferred]
10. **lib** - Local custom library (loads alias.zsh, lscolors.zsh)

**Defer Template:** Uses `zsh-defer source` for performance optimization

## Neovim Configuration

**Editor:** AstroNvim v5+ template **Location:** `home/config/nvim/`
**Installation:** See `install_astronvim()` in bootstrap script

**Backup Strategy:**

- Backs up to `.bak` extensions: `~/.config/nvim.bak`,
  `~/.local/share/nvim.bak`, etc.
- Clean install approach (removes `.git` from template)

## Terminal Emulator Configurations

### Kitty

**Config:** `home/config/kitty/kitty.conf` **Backup:** `kitty-backup.conf`
available

### Alacritty

**Config:** `home/config/alacritty/alacritty.toml` **Format:** TOML
configuration

### Neovide

**Config:** `home/config/neovide/config.toml` **Type:** GUI wrapper for Neovim

## Coding Standards & Best Practices

### Python Scripts

**CRITICAL: All Python code must use strict and thorough type hinting.**

1. **Shebang:** Use `#!/usr/bin/env python3`
2. **Future Imports:** Always include `from __future__ import annotations` at
   the top
3. **Type Hints:** **MANDATORY** - All functions, methods, and variables must
   have complete type annotations
   - Function parameters: `def func(name: str, count: int) -> bool:`
   - Return types: Always specify, use `-> None` for procedures
   - Variable annotations: Use when type isn't obvious from assignment
   - Use modern syntax: `list[str]`, `dict[str, int]`, `Type | None` (not
     `Optional[Type]`)
4. **Docstrings:** Google-style docstrings with blank line after opening quotes

   ```python
   def function(arg: str) -> int:
       """
       Brief description on second line.

       Longer description here if needed.

       Args:
           arg: Description of argument

       Returns:
           Description of return value

       Raises:
           ValueError: When something goes wrong

       """
   ```

5. **Line Length:** Maximum 80 characters (Google Style Guide)
6. **Imports:** Group in order: standard library, third-party, local
7. **Boolean Arguments:** Use keyword-only arguments with `*` for clarity
   ```python
   def process(data: str, *, verbose: bool = False) -> None:
       """Process with optional verbosity."""
   ```
8. **Error Messages:** Store in variables, not string literals in exceptions
   ```python
   msg = f"Invalid value: {value}"
   raise ValueError(msg)
   ```
9. **Path Handling:** Use `pathlib.Path`, not `os.path`
10. **Linting:** Code must pass Ruff with strict configuration:
    - All rules enabled except explicitly ignored
    - D213/D211 docstring style (Google-aligned)
    - Security rules (bandit) enforced with selective script exceptions
    - Configuration: `home/config/ruff/ruff.toml` (installed to
      `~/.config/ruff/`)
11. **Type Checking:** Enable `python.analysis.typeCheckingMode: "strict"` in VS
    Code

**Type Hint Examples:**

```python
from __future__ import annotations

from pathlib import Path
from typing import TYPE_CHECKING

if TYPE_CHECKING:
    from collections.abc import Mapping, Sequence

def process_files(
    paths: Sequence[Path],
    *,
    config: Mapping[str, str] | None = None,
) -> list[str]:
    """Process multiple files and return results."""
    ...
```

### Shell Scripts (Bash)

1. **Shebang:** Use `#!/bin/bash` or `#!/usr/bin/env bash`
2. **Mode Comment:** `# -*- mode: sh -*-` for editor hints
3. **Strict Mode:** `set -euo pipefail` at start
4. **Error Traps:** `trap on_error ERR SIGTERM SIGINT`
5. **Sourcing:** Always check existence: `[[ -f file ]] && source file`
6. **Quoting:** Always quote variables: `"$variable"`, use arrays for lists
7. **Functions:** Use lowercase with underscores: `install_package()`
8. **Private Functions:** Prefix with underscore: `_exists()`
9. **Return Codes:** 0 for success, non-zero for failure, explicit returns
10. **Variable Declarations:** Separate `local` declarations from command
    substitution (SC2155):

    ```bash
    # Bad: Exit code from 'local', not from command
    local var=$(command)

    # Good: Exit code from command is properly captured
    local var
    var=$(command)
    ```

11. **Documentation:** Function comments explaining purpose, parameters, return
    values

### Shell Scripts (Zsh)

1. **Shebang:** Use `#!/bin/zsh` or `#!/usr/bin/env zsh`
2. **Arrays:** Use zsh array syntax: `array=(item1 item2)`
3. **Conditional Checks:** Use `[[ ... ]]` for better functionality
4. **Local Variables:** Always declare with `local` in functions
5. **Exports:** Export functions/variables needed by sourced scripts

### Utility Functions

**When adding new utilities to `scripts/utils`:**

1. Follow existing naming convention (`_` for internal checks, no `_` for
   user-facing)
2. Add descriptive comments
3. Handle errors gracefully with return codes
4. Export if needed by other scripts: `export -f function_name`
5. Test on multiple distributions

### Package Definitions

**When adding to `scripts/package_list`:**

1. Add to correct array for distribution/manager
2. Group by category with comments
3. Check package name across distributions (names may differ!)
4. Consider priority: system > cargo > pip/npm > snap/flatpak
5. Document why non-system package manager is chosen if applicable

### Color Usage

**When using colors in scripts:**

1. Always source `scripts/fg_colors` first
2. Use semantic functions: `info()`, `success()`, `error()`, `warn()`
3. Colors automatically disabled for non-TTY or dumb terminals
4. Use `${COLOR}text${NORMAL}` pattern for inline coloring
5. Always reset with `${NORMAL}` after colored text

### CLI Argument Parsing

**Standard patterns for scripts:**

```bash
while [[ $# -gt 0 ]]; do
    case $1 in
        -h|--help) usage; exit 0 ;;
        -v|--verbose) VERBOSE=true; shift ;;
        -d|--dry-run) DRY_RUN=true; shift ;;
        --skip-*) SKIP_COMPONENT=true; shift ;;
        --option) VARIABLE="$2"; shift 2 ;;
        *) error "Unknown option: $1"; usage; exit 1 ;;
    esac
done
```

**Common flags:**

- `-h`, `--help` - Show usage
- `-v`, `--verbose` - Enable verbose output
- `-d`, `--dry-run` - Show what would be done without executing
- `-y`, `--yes` - Auto-confirm all prompts
- `--skip-*` - Skip specific components

### Progress Tracking

**Pattern used in bootstrap and update scripts:**

```bash
declare -a COMPLETED_TASKS=()
declare -a FAILED_TASKS=()

track_task() {
    local task_name="$1"
    local task_function="$2"

    info "Starting: $task_name"
    if "$task_function"; then
        COMPLETED_TASKS+=("$task_name")
        success "✓ $task_name completed"
    else
        FAILED_TASKS+=("$task_name")
        error "✗ $task_name failed"
    fi
}

# Usage:
track_task "System Packages" install_software
```

## Common Tasks & Examples

### Adding a New Package

1. **Identify correct package manager and array** in `scripts/package_list`
2. **Add package name** to appropriate array (check name variations across
   distros)
3. **Test installation** with `./scripts/bootstrap --dry-run`
4. **Document** if non-obvious why that package manager was chosen

### Adding a New Configuration File

1. **Place file** in appropriate `home/config/` subdirectory
2. **Update `install.conf.yaml`** if new symlink pattern needed
3. **Test** with `./install`
4. **Consider backup** strategy for existing configs

### Creating a New Utility Script

1. **Place in `bin/`** with executable permissions: `chmod +x`
2. **Add shebang:** `#!/usr/bin/env bash`
3. **Source utilities** if needed: `source "${DOTFILES}/scripts/utils"`
4. **Follow error handling** patterns
5. **Add usage documentation**

### Modifying Bootstrap/Update Scripts

1. **Test with `--dry-run` first**
2. **Maintain error handling** with trap and return codes
3. **Update progress tracking** with `track_task()`
4. **Add CLI flag** if making component optional
5. **Update usage()** function
6. **Test across distributions** if possible

### Adding Shell Aliases

1. **Edit `lib/alias.zsh`**
2. **Group with similar aliases** (maintain organization)
3. **Use `_exists` check** for command availability
4. **Consider platform differences** with `_is_macos`, `_is_wsl`, `_is_linux`
5. **Test in fresh shell:** `exec zsh`

### Adding Zsh Plugins

1. **Edit `home/config/sheldon/plugins.toml`**
2. **Add plugin block:**
   ```toml
   [plugins.plugin-name]
   github = "author/repo"
   apply = ["defer"]  # If appropriate
   ```
3. **Run:** `sheldon lock --update`
4. **Restart shell**

## Environment Variables

**Key variables used throughout:**

- `$DOTFILES` - Path to dotfiles repository (default: `~/.dotfiles`)
- `$SCRIPTS` - Path to scripts directory (`$DOTFILES/scripts/`)
- `$EDITOR` - Preferred editor (defaults to nvim)
- `$SHELL` - Current shell
- `$HOME` - User home directory

**Debug/Verbose Modes:**

- `DEBUG=1` - Enable debug output in utility functions
- `VERBOSE=true` - Enable verbose script output
- `DRY_RUN=true` - Show what would happen without executing

## Distribution-Specific Notes

### Fedora/RHEL/CentOS

- **Package Manager:** DNF 5 (modern Fedora default)
- **Package Groups:** Use `dnf install @group-name` with lowercase-hyphenated group names
- **Group Format:** DNF 5 uses `@c-development` and `@development-tools` (not quoted legacy names)
- **RPM Fusion:** Third-party repository for non-free software
- **Special Notes:** Python package names often include version (python3,
  python3-pip)

### Ubuntu/Debian

- **Package Manager:** APT
- **Build Essentials:** `build-essential` package for development tools
- **Python:** Use `python-is-python3` for `python` command
- **Special Notes:** More conservative package versions, may need PPAs for
  latest software

### Arch Linux

- **Package Manager:** Pacman (system), Paru/Yay (AUR)
- **Rolling Release:** Always latest packages
- **AUR:** Many packages only in AUR (Arch User Repository)
- **Special Notes:** Minimal base system, explicitly install all needed
  dependencies

### WSL (Windows Subsystem for Linux)

- **Detection:** `[[ "$(uname -r)" == *WSL* ]]` or `$WSL_DISTRO_NAME`
- **Limitations:** No systemd on WSL1, GUI apps need WSLg or X server
- **Package List:** Use `wsl_packages` (lighter set)
- **Special Notes:** Different clipboard utilities (wl-copy), different open
  command

## Testing & Validation

**Before committing changes:**

1. Run `shellcheck` on modified bash scripts
2. Test with `--dry-run` flag
3. Verify symlinks: `ls -la ~/` after `./install`
4. Test on fresh VM/container if possible
5. Check for broken symlinks: `find ~ -xtype l`

**Recommended test sequence for bootstrap:**

```bash
# 1. Dry run
./scripts/bootstrap --dry-run --verbose

# 2. Selective install
./scripts/bootstrap --skip-fnm --skip-go --skip-astronvim

# 3. Full install (if confident)
./scripts/bootstrap --yes
```

## TODO List (from TODO.md)

All major planned improvements have been completed:

- ✅ Fixed continuing installation after rustup install - Added proper cargo env
  sourcing
- ✅ Completed nvim appimage installation - Now installs to /opt/nvim/ with
  symlink
- ✅ Auto-source zshrc after installation - Implemented in both install and
  bootstrap scripts

The repository is now feature-complete for personal use.

## Resources & References

**Original Inspiration:**

- [denysdovhan/dotfiles](https://github.com/denysdovhan/dotfiles)
- [sapegin/dotfiles](https://github.com/sapegin/dotfiles) (update script source)

**Key Tools Documentation:**

- [Dotbot](https://github.com/anishathalye/dotbot) - Installation framework
- [Sheldon](https://sheldon.cli.rs/) - Zsh plugin manager
- [AstroNvim](https://astronvim.com/) - Neovim distribution
- [fnm](https://github.com/Schniz/fnm) - Fast Node Manager (Rust-based)
- [uv](https://docs.astral.sh/uv/) - Fast Python package manager (Rust-based)
- [rustup](https://rustup.rs/) - Rust toolchain installer

**Online Generators:**

- [LS_COLORS Generator](https://geoff.greer.fm/lscolors/)
- [LS_COLORS Advanced](https://github.com/trapd00r/LS_COLORS)

## Security Considerations

1. **Password Utility:** Generates random passwords, ensure secure clipboard
   handling
2. **Sudo Keepalive:** Scripts maintain sudo access during long operations
3. **Script Execution:** Always review scripts before running with sudo
4. **Git Hooks:** Be careful with Dotbot's shell commands (they execute
   automatically)
5. **Package Sources:** Prefer official repositories over third-party sources
6. **Environment Variables:** Don't commit secrets to repository

## When Working with This Repository

**For GitHub Copilot:**

- Always consider cross-distribution compatibility
- Maintain existing code style and patterns
- Use utility functions from `scripts/utils` when available
- Add error handling and return codes to functions
- Keep interactive prompts with auto-yes flags for automation
- Test suggestions with dry-run mode first
- Preserve the modular structure (don't combine unrelated functionality)
- **Update this file** when making significant changes (see header for
  guidelines)
- Update the "Last Updated" date in the header when modifying this file
- Consider running `check-docs` script to verify documentation sync

**Documentation Sync Tool:** The repository includes `scripts/check-docs`
(alias: `check-docs`) to help identify when documentation may need updating.
This script:

- Checks if copilot-instructions.md exists
- Compares modification dates of key files vs last documentation update
- Provides warnings if important files have changed since last doc update
- Can be run manually: `./scripts/check-docs` or `check-docs` (with alias)

**Common Patterns to Follow:**

- Use `_exists` before checking command availability
- Use `run_command` wrapper for dry-run support
- Use `track_task` for progress tracking in main scripts
- Always quote variables and use arrays for lists
- Provide usage information with `-h`/`--help`
- Enable verbose output with `--verbose`
- Support `--dry-run` for safe testing
