# BigMikeM's Dotfiles

A comprehensive, cross-distribution Linux dotfiles repository for automating and maintaining consistent development environments. This repository provides a complete setup for modern CLI tools, shell configurations, editors, and development utilities.

> **Note:** This project was originally forked from [denysdovhan/dotfiles](https://github.com/denysdovhan/dotfiles) and has been heavily customized for personal use. The documentation and organization of this repository were created with the assistance of AI tools to ensure comprehensive coverage and maintainability.

## ✨ Features

- 🚀 **Automated Installation** - One-command setup for new systems
- 🔄 **Easy Updates** - Keep all tools and packages current with a single script
- 🎨 **Beautiful Terminal** - Enhanced Zsh with modern plugins and themes
- ⚡ **Modern CLI Tools** - Rust-based replacements (fd, ripgrep, bat, lsd, etc.)
- 🎯 **Cross-Distribution** - Works on Fedora, Ubuntu/Debian, Arch Linux, and WSL
- 🛡️ **Safe & Idempotent** - Scripts can be run multiple times safely
- 🧪 **Dry-Run Mode** - Test changes before applying them
- 📦 **Multi-Package Manager** - Handles system, Cargo, npm, pip, Snap, and Flatpak packages

## 🎯 Quick Start

### Installation

```bash
# Clone the repository
git clone https://github.com/BigMikeM/dotfiles.git ~/.dotfiles
cd ~/.dotfiles

# Run the installer (creates symlinks)
./install

# Bootstrap a new system (installs packages and tools)
./scripts/bootstrap
```

### Update Existing System

```bash
# Update everything (dotfiles, system packages, Rust, Node.js, etc.)
~/.dotfiles/scripts/update

# Or use the convenient alias after installation
update
```

## 📦 What's Included

### Development Tools

- **Editor:** Neovim with [AstroNvim v5+](https://astronvim.com/)
- **Shell:** Zsh with [Sheldon](https://sheldon.cli.rs/) plugin manager
- **Terminal Emulators:** Kitty (primary), Alacritty (alternative)
- **File Manager:** Ranger (CLI)
- **Version Control:** Git with custom utilities (gh CLI, gitui)
- **Languages:**
  - **Rust:** Via rustup (stable toolchain)
  - **Node.js:** Via fnm (Fast Node Manager, multiple LTS versions supported)
  - **Python:** System Python 3 with development packages
  - **Go:** Latest stable version (optional)

### Modern CLI Tools (Rust-based)

- `fd` - Fast find replacement
- `ripgrep` (rg) - Fast grep replacement
- `bat` - Cat with syntax highlighting
- `lsd` - Modern ls replacement
- `du-dust` - Intuitive du replacement
- `sheldon` - Fast Zsh plugin manager
- `tokei` - Code statistics
- `hyperfine` - Command benchmarking
- `bottom` - System monitor
- `starship` - Cross-shell prompt

### Zsh Plugins (via Sheldon)

- oh-my-zsh - Base framework
- zsh-syntax-highlighting - Fish-like syntax highlighting
- zsh-autosuggestions - Fish-like autosuggestions
- zsh-autopair - Auto-close brackets and quotes
- zsh-z - Frecency-based directory jumping
- alias-tips - Show available aliases
- auto-notify - Desktop notifications for long commands

### Custom Utilities

Located in `bin/`:

- `git-cleanup` - Remove old branches with gone remotes
- `git-fork` - Setup upstream for forked repositories
- `git-upstream` - Sync branch with upstream
- `password` - Generate secure random passwords
- `emptytrash` - Clear system trash
- `nyan` - Display nyan cat (because why not? 🐱‍👤)

## 🛠️ Repository Structure

```
.dotfiles/
├── install                 # Main Dotbot installation script
├── install.conf.yaml       # Dotbot configuration
├── bin/                    # Custom utility scripts
├── scripts/
│   ├── bootstrap          # Full system setup script
│   ├── update             # System update script
│   ├── utils              # Shared utility functions
│   ├── package_list       # Package definitions by distro
│   └── fg_colors          # Terminal color definitions
├── lib/
│   ├── alias.zsh          # Shell aliases (480+ lines)
│   ├── lscolors.zsh       # LS_COLORS configuration
│   └── smartdots.zsh      # Smart directory navigation
├── home/
│   └── config/
│       ├── alacritty/     # Alacritty terminal config
│       ├── kitty/         # Kitty terminal config
│       ├── nvim/          # Neovim/AstroNvim config
│       ├── ranger/        # Ranger file manager config
│       └── sheldon/       # Sheldon plugin definitions
└── dotbot/                # Dotbot submodule
```

## 📚 Usage

### Bootstrap Script

The `bootstrap` script performs a complete system setup:

```bash
# Interactive installation (recommended for first run)
./scripts/bootstrap

# Auto-install everything without prompts
./scripts/bootstrap --yes

# Dry-run to see what would be installed
./scripts/bootstrap --dry-run

# Skip specific components
./scripts/bootstrap --skip-go --skip-astronvim

# Get help
./scripts/bootstrap --help
```

**Installation Order:**

1. System packages (via distro package manager)
2. Rustup and Cargo packages (required)
3. fnm and Node.js (optional, LTS + latest)
4. NPM global packages (if fnm installed)
5. Python pip packages (optional)
6. Neovim AppImage (optional, v0.11.3+)
7. AstroNvim (optional)
8. GitUI (optional)
9. Go (optional, latest version)
10. Set Zsh as default shell

### Update Script

The `update` script keeps everything current:

```bash
# Update everything
./scripts/update

# Skip specific updates
./scripts/update --skip-system
./scripts/update --skip-node
./scripts/update --skip-rust

# Create backup before updating
./scripts/update --backup

# Dry-run mode
./scripts/update --dry-run
```

**Updates:**

- Dotfiles repository (git pull)
- System packages (dnf/apt/pacman)
- Flatpak packages
- Snap packages
- Rust toolchain (rustup)
- Cargo packages
- All Node.js versions (via fnm)
- NPM global packages
- Shell plugins (Sheldon)

## 🎨 Shell Customization

### Smart Aliases

The dotfiles include 480+ lines of carefully crafted aliases:

**File Operations:**

```bash
ll          # Detailed list (with lsd/exa/ls)
la          # List all files
lt          # Tree view
rm          # Safe delete with trash-cli
```

**Directory Navigation:**

```bash
..          # Up one directory
...         # Up two directories (via smartdots)
....        # Up three directories
pc          # Jump to ~/Projects
pcw         # Jump to ~/Projects/Work
conf        # Jump to ~/.config
```

**Git Shortcuts:**

```bash
g           # git
gs          # git status
ga          # git add
gc          # git commit
gp          # git push
gl          # git pull
glog        # Pretty git log graph
```

**Dotfiles Management:**

```bash
update      # Run update script
bootstrap   # Run bootstrap script
check-docs  # Check if documentation needs updating
dotfiles    # Edit dotfiles repo
reload      # Reload shell config
```

### Smart Dots

Type multiple dots to navigate up directories automatically:

- `..` → `cd ..`
- `...` → `cd ../..`
- `....` → `cd ../../..`

## 🔧 Configuration

### Supported Distributions

- **Fedora/RHEL/CentOS** - DNF/YUM package manager
- **Ubuntu/Debian** - APT package manager
- **Arch Linux** - Pacman/Paru package manager
- **WSL** - Windows Subsystem for Linux (Ubuntu/Debian-based)

### Package Management Strategy

The dotfiles use a priority-based package management approach:

1. **System packages** (highest priority) - Best integration with system
2. **Cargo packages** - Modern, fast, well-maintained alternatives
3. **Python/Node packages** - Development-specific tools
4. **Snap packages** - Only VS Code (for auto-updates)
5. **Flatpak packages** - Apps exclusive to Flatpak (Discord, Spotify)

### Environment Variables

Key variables set by the dotfiles:

- `$DOTFILES` - Path to dotfiles repository (`~/.dotfiles`)
- `$EDITOR` - Preferred editor (defaults to `nvim`)

## 🚨 Troubleshooting

### Common Issues

**Rust packages not installing:**

```bash
# Install Rustup first
./scripts/bootstrap --skip-fnm --skip-go --skip-astronvim
```

**fnm not available after installation:**

```bash
# Restart your shell or source zshrc
exec zsh
# or
source ~/.zshrc
```

**Permission issues:**

```bash
# Bootstrap and update scripts handle sudo automatically
# Just ensure your user has sudo privileges
```

**Broken symlinks:**

```bash
# Re-run the installer
./install

# Check for broken symlinks
find ~ -xtype l -maxdepth 3
```

### Dry-Run Mode

Both bootstrap and update scripts support dry-run mode:

```bash
# See what would be installed
./scripts/bootstrap --dry-run --verbose

# See what would be updated
./scripts/update --dry-run --verbose
```

## 📖 Documentation

For detailed information about the project structure, coding standards, and development practices, see the [Copilot Instructions](.github/copilot-instructions.md).

Key documentation sections:

- Script execution patterns and error handling
- Package management strategy by distribution
- Zsh configuration (aliases, colors, plugins)
- Custom utility functions
- Adding new packages or configurations
- Testing and validation procedures

## 🤝 Contributing

This is a personal dotfiles repository, but you're welcome to:

- Fork it and customize for your own use
- Submit issues if you find bugs
- Suggest improvements via pull requests
- Use parts of it in your own dotfiles

### Before Modifying

1. Test changes with `--dry-run` flag
2. Run `shellcheck` on bash scripts
3. Test on multiple distributions if possible
4. Update documentation for significant changes

### Documentation Maintenance

**⚠️ IMPORTANT:** When making significant changes, update the [Copilot Instructions](.github/copilot-instructions.md) file.

**Update the Copilot Instructions when:**
- ✏️ Adding/removing scripts or utilities
- 🔧 Changing core functionality in bootstrap/update scripts
- 📦 Modifying package lists or installation strategies
- ⚙️ Adding new configuration files or tools
- 📋 Changing coding standards or best practices
- 🐧 Updating supported distributions or requirements
- 📝 Adding new shell aliases or functions

**Also update:**
- `README.md` - User-facing documentation
- `TODO.md` - Track completed/planned features
- Function comments in scripts for significant logic changes

This ensures GitHub Copilot has accurate context for assisting with the repository.

## 📝 TODO

This project is feature-complete for personal use. All major planned improvements have been implemented!

See [TODO.md](TODO.md) for any future enhancement ideas.

## 📜 License

This is personal configuration, use at your own risk. Originally based on [denysdovhan/dotfiles](https://github.com/denysdovhan/dotfiles).

## 🙏 Acknowledgments

- **[Denys Dovhan](https://github.com/denysdovhan)** - Original dotfiles structure and inspiration
- **[Artem Sapegin](https://github.com/sapegin)** - Update script inspiration
- **[Dotbot](https://github.com/anishathalye/dotbot)** - Excellent installation framework
- The Rust, Zsh, and Neovim communities for amazing tools

## 📧 Contact

**Author:** BigMikeM
**Repository:** [github.com/BigMikeM/dotfiles](https://github.com/BigMikeM/dotfiles)

---

**Happy configuring! 🚀**
