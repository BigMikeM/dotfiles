#!/bin/zsh
# Enhanced Zsh configuration with better performance and organization
# Author: BigMikeM
# Based on: https://github.com/denysdovhan/dotfiles

# ==============================================================================
# PROFILING (Enable for performance debugging)
# ==============================================================================
# Uncomment to enable profiling
# zmodload zsh/zprof

# ==============================================================================
# EARLY INITIALIZATION
# ==============================================================================

# Export path to root of dotfiles repo
export DOTFILES="$HOME/.dotfiles"
export DOTFILES=${DOTFILES:="$HOME/.dotfiles"}

# Utility functions
_exists() {
    command -v "$1" >/dev/null 2>&1
}

_is_wsl() {
    [[ "$(uname -r)" == *WSL* ]] || [[ -n "${WSL_DISTRO_NAME:-}" ]]
}

_is_macos() {
    [[ "$OSTYPE" == darwin* ]]
}

_is_linux() {
    [[ "$OSTYPE" == linux* ]]
}

# Performance: Early return if not interactive
[[ $- != *i* ]] && return

# ==============================================================================
# XDG BASE DIRECTORIES
# ==============================================================================

# Ensure XDG directories are set
export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
export XDG_DATA_HOME="${XDG_DATA_HOME:-$HOME/.local/share}"
export XDG_STATE_HOME="${XDG_STATE_HOME:-$HOME/.local/state}"
export XDG_CACHE_HOME="${XDG_CACHE_HOME:-$HOME/.cache}"

# Create XDG directories if they don't exist
for dir in "$XDG_CONFIG_HOME" "$XDG_DATA_HOME" "$XDG_STATE_HOME" "$XDG_CACHE_HOME"; do
    [[ ! -d "$dir" ]] && mkdir -p "$dir"
done

# Create zsh-specific cache directory
[[ ! -d "${XDG_CACHE_HOME}/zsh" ]] && mkdir -p "${XDG_CACHE_HOME}/zsh"

# ==============================================================================
# ENVIRONMENT VARIABLES
# ==============================================================================

# Language and locale
export LANG=${LANG:-en_US.UTF-8}
export LC_ALL=${LC_ALL:-en_US.UTF-8}

# Manual pages
export MANPATH="/usr/local/man:${MANPATH:-}"
export MANPAGER="${MANPAGER:-less -X}"

# Compiler colors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# Terminal and display
export TERM="${TERM:-xterm-256color}"
export COLORTERM="${COLORTERM:-truecolor}"

# History configuration
export HISTFILE="${XDG_STATE_HOME}/zsh/history"
export HISTSIZE=50000
export SAVEHIST=10000

# Ensure history directory exists
[[ ! -d "$(dirname "$HISTFILE")" ]] && mkdir -p "$(dirname "$HISTFILE")"

# ==============================================================================
# PATH MANAGEMENT
# ==============================================================================

# Enhanced path extension function
_extend_path() {
    local dir="$1"
    local position="${2:-front}" # front or back

    # Return if directory doesn't exist
    [[ ! -d "$dir" ]] && return 1

    # Check if already in PATH
    case ":$PATH:" in
    *":$dir:"*) return 0 ;;
    esac

    # Add to PATH
    if [[ "$position" == "back" ]]; then
        export PATH="$PATH:$dir"
    else
        export PATH="$dir:$PATH"
    fi
}

# System paths (higher priority)
_extend_path "/usr/local/bin"
_extend_path "/usr/bin"
_extend_path "/bin"

# Development tools
_extend_path "/usr/local/go/bin"     # Go manual installation
_extend_path "/usr/local/bin/nvim"   # Neovim AppImage
_extend_path "/opt/neovide"          # Neovide AppImage
_extend_path "/opt/nvim-linux64/bin" # Neovim alternative location

# User-specific paths
_extend_path "$HOME/.local/bin"
_extend_path "$DOTFILES/bin"
_extend_path "$HOME/bin"

# Language-specific paths
_extend_path "$HOME/.cargo/bin"                            # Rust
_extend_path "$HOME/go/bin"                                # Go
_extend_path "$HOME/.npm-global/bin"                       # npm global
_extend_path "$HOME/.yarn/bin"                             # Yarn
_extend_path "$HOME/.config/yarn/global/node_modules/.bin" # Yarn global
_extend_path "$HOME/.rvm/bin"                              # Ruby Version Manager
_extend_path "$HOME/perl5/bin"                             # Perl

# Python paths
_extend_path "$HOME/.local/bin" back # pipx and pip user installs
if [[ -d "$HOME/.pyenv/bin" ]]; then
    _extend_path "$HOME/.pyenv/bin"
fi

# Node.js configuration
if [[ -d "$HOME/.npm-global" ]]; then
    export NODE_PATH="$NODE_PATH:$HOME/.npm-global/lib/node_modules"
    export NPM_CONFIG_PREFIX="$HOME/.npm-global"
fi

# ==============================================================================
# EDITOR CONFIGURATION
# ==============================================================================

# Enhanced editor selection
_setup_editor() {
    local editors=(nvim vim vi nano)

    # Prefer GUI editors for local sessions
    if [[ -z "$SSH_CONNECTION" ]] && [[ -n "$DISPLAY" || -n "$WAYLAND_DISPLAY" ]]; then
        editors=(neovide code nvim vim vi nano)
    fi

    for editor in "${editors[@]}"; do
        if _exists "$editor"; then
            export EDITOR="$editor"
            export VISUAL="$editor"
            break
        fi
    done

    # Fallback
    export EDITOR="${EDITOR:-vi}"
    export VISUAL="${VISUAL:-$EDITOR}"
}

_setup_editor

# ==============================================================================
# PAGER CONFIGURATION
# ==============================================================================

# Enhanced pager setup
_setup_pager() {
    if _exists bat; then
        export PAGER="bat"
        export MANPAGER="sh -c 'col -bx | bat -l man -p'"
    elif _exists less; then
        export PAGER="less"

        # Less options for better experience
        local less_opts=(
            --quit-if-one-screen # -F: Quit if entire file fits on first screen
            --ignore-case        # -i: Ignore case in searches
            --status-column      # -J: Display status column
            --LONG-PROMPT        # -M: More verbose prompt
            --RAW-CONTROL-CHARS  # -R: Allow ANSI color escapes
            --HILITE-UNREAD      # -W: Highlight first new line after scroll
            --tabs=4             # -x4: Set tab width to 4
            --no-init            # -X: Don't use termcap init/deinit strings
        )
        export LESS="${less_opts[*]}"

        # Less colors for man pages
        export LESS_TERMCAP_mb=$'\e[1;32m'   # Begin bold
        export LESS_TERMCAP_md=$'\e[1;32m'   # Begin blink
        export LESS_TERMCAP_me=$'\e[0m'      # Reset bold/blink
        export LESS_TERMCAP_so=$'\e[01;33m'  # Begin reverse video
        export LESS_TERMCAP_se=$'\e[0m'      # Reset reverse video
        export LESS_TERMCAP_us=$'\e[1;4;31m' # Begin underline
        export LESS_TERMCAP_ue=$'\e[0m'      # Reset underline
    else
        export PAGER="cat"
    fi
}

_setup_pager

# ==============================================================================
# ZSH OPTIONS
# ==============================================================================

# History options
setopt EXTENDED_HISTORY       # Write the history file in the ':start:elapsed;command' format
setopt SHARE_HISTORY          # Share history between all sessions
setopt HIST_EXPIRE_DUPS_FIRST # Expire a duplicate event first when trimming history
setopt HIST_IGNORE_DUPS       # Do not record an event that was just recorded again
setopt HIST_IGNORE_ALL_DUPS   # Delete an old recorded event if a new event is a duplicate
setopt HIST_FIND_NO_DUPS      # Do not display a previously found event
setopt HIST_IGNORE_SPACE      # Do not record an event starting with a space
setopt HIST_SAVE_NO_DUPS      # Do not write a duplicate event to the history file
setopt HIST_VERIFY            # Do not execute immediately upon history expansion
setopt APPEND_HISTORY         # Append to history file rather than replacing it

# Directory options
setopt AUTO_CD           # Change to directory without cd
setopt AUTO_PUSHD        # Push the old directory onto the stack on cd
setopt PUSHD_IGNORE_DUPS # Do not store duplicates in the stack
setopt PUSHD_SILENT      # Do not print the directory stack after pushd or popd

# Completion options
setopt COMPLETE_IN_WORD # Complete from both ends of a word
setopt ALWAYS_TO_END    # Move cursor to the end of a completed word
setopt PATH_DIRS        # Perform path search even on command names with slashes
setopt AUTO_MENU        # Show completion menu on a successive tab press
setopt AUTO_LIST        # Automatically list choices on ambiguous completion
setopt AUTO_PARAM_SLASH # If completed parameter is a directory, add a trailing slash
setopt EXTENDED_GLOB    # Use extended globbing syntax

# Correction options
setopt CORRECT     # Try to correct the spelling of commands
setopt CORRECT_ALL # Try to correct the spelling of all arguments in a line

# Other useful options
setopt INTERACTIVE_COMMENTS # Allow comments in interactive shells
setopt MULTIOS              # Write to multiple descriptors
setopt NO_BEEP              # Don't beep on error
setopt PROMPT_SUBST         # Enable parameter expansion in prompts

# ==============================================================================
# COMPLETION SYSTEM
# ==============================================================================

# Initialize completion system
autoload -Uz compinit

# Performance: only check once per day
local zcompdump="${XDG_CACHE_HOME}/zsh/zcompdump"

# Check if we need to regenerate the completion dump
if [[ -f "$zcompdump" && "$zcompdump" -nt ~/.zshrc ]]; then
    # File exists and is newer than .zshrc, load it quickly
    compinit -C -d "$zcompdump"
else
    # File doesn't exist or is old, regenerate
    compinit -d "$zcompdump"
fi

# Completion configuration
export COMPLETION_WAITING_DOTS="true"

# Completion styles
zstyle ':completion:*' menu select
zstyle ':completion:*' group-name ''
zstyle ':completion:*' verbose yes
zstyle ':completion:*:descriptions' format '%B%d%b'
zstyle ':completion:*:messages' format '%d'
zstyle ':completion:*:warnings' format 'No matches for: %d'
zstyle ':completion:*:corrections' format '%B%d (errors: %e)%b'

# Case-insensitive completion
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'

# Process completion
zstyle ':completion:*:*:*:*:processes' command "ps -u $USER -o pid,user,comm -w -w"
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#) ([0-9a-z-]#)*=01;34=0=01'

# ==============================================================================
# OH MY ZSH CONFIGURATION
# ==============================================================================

# Oh My Zsh settings
export ZSH_DISABLE_COMPFIX=true
export ZSH_THEME='gozilla'

# OMZ is managed by Sheldon
export ZSH="$XDG_DATA_HOME/sheldon/repos/github.com/ohmyzsh/ohmyzsh"

# OMZ plugins (fix the array syntax)
plugins=(
    # Core functionality
    git
    history-substring-search
    sudo
    extract
    command-not-found

    # Development tools
    npm
    nvm
    gh
    vscode

    # Convenience
    common-aliases
    colored-man-pages
    cp
)

# Add platform-specific plugins
if _is_macos; then
    plugins+=(macos)
fi

# WSL-specific configuration (since wsl plugin doesn't exist)
if _is_wsl; then
    # WSL-specific environment variables
    export BROWSER="/mnt/c/Program Files/Google/Chrome/Application/chrome.exe"
    export DISPLAY="${DISPLAY:-:0}"

    # WSL-specific aliases
    alias cmd='cmd.exe'
    alias powershell='powershell.exe'
    alias explorer='explorer.exe'
    alias code='code.exe'

    # Fix for WSL path issues
    appendpath() {
        case ":$PATH:" in
            *:"$1":*)
                ;;
            *)
                PATH="${PATH:+$PATH:}$1"
        esac
    }
fi

# Export the plugins array
export plugins

# Plugin-specific configuration
zstyle ':omz:plugins:nvm' autoload yes
zstyle ':omz:plugins:nvm' lazy yes

# ==============================================================================
# APPLICATION-SPECIFIC CONFIGURATION
# ==============================================================================

# Bat theme
export BAT_THEME="Catppuccin-mocha"

# Electron apps on Wayland
if [[ -n "$WAYLAND_DISPLAY" ]]; then
    export ELECTRON_OZONE_PLATFORM_HINT='wayland'
    export MOZ_ENABLE_WAYLAND=1
fi

# FZF configuration
if _exists fzf; then
    export FZF_DEFAULT_OPTS="
        --height 40%
        --layout=reverse
        --border
        --inline-info
        --color=dark
        --color=fg:-1,bg:-1,hl:#5fff87,fg+:-1,bg+:-1,hl+:#ffaf5f
        --color=info:#af87ff,prompt:#5fff87,pointer:#ff87d7,marker:#ff87d7,spinner:#ff87d7
    "

    # Use fd if available
    if _exists fd; then
        export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
        export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
        export FZF_ALT_C_COMMAND='fd --type d --hidden --follow --exclude .git'
    fi
fi

# Ripgrep configuration
if _exists rg; then
    export RIPGREP_CONFIG_PATH="$XDG_CONFIG_HOME/ripgrep/config"
fi

# Docker configuration
export DOCKER_CONFIG="$XDG_CONFIG_HOME/docker"
export MACHINE_STORAGE_PATH="$XDG_DATA_HOME/docker-machine"

# ==============================================================================
# LANGUAGE-SPECIFIC SETUP
# ==============================================================================

# Python configuration
if _exists python3; then
    export PYTHONDONTWRITEBYTECODE=1
    export PYTHONUNBUFFERED=1
    export PYTHONHISTFILE="$XDG_STATE_HOME/python/history"

    # Create Python history directory
    [[ ! -d "$(dirname "$PYTHONHISTFILE")" ]] && mkdir -p "$(dirname "$PYTHONHISTFILE")"
fi

# Node.js version manager setup
_setup_node() {
    # NVM
    if [[ -d "$HOME/.nvm" ]]; then
        export NVM_DIR="$HOME/.nvm"

        # Load nvm immediately if node is not available
        if ! command -v node >/dev/null 2>&1; then
            [[ -s "$NVM_DIR/nvm.sh" ]] && source "$NVM_DIR/nvm.sh"
            # Use default node version if available
            [[ -s "$NVM_DIR/bash_completion" ]] && source "$NVM_DIR/bash_completion"
        else
            # Lazy load NVM for better performance when node is already available
            nvm() {
                unfunction nvm
                [[ -s "$NVM_DIR/nvm.sh" ]] && source "$NVM_DIR/nvm.sh"
                [[ -s "$NVM_DIR/bash_completion" ]] && source "$NVM_DIR/bash_completion"
                nvm "$@"
            }
        fi
    fi

    # Volta
    if [[ -d "$HOME/.volta" ]]; then
        export VOLTA_HOME="$HOME/.volta"
        _extend_path "$VOLTA_HOME/bin"
    fi

    # fnm (fast node manager)
    if _exists fnm; then
        eval "$(fnm env --use-on-cd)"
    fi

    # Ensure node is available - auto-use default if none active
    if [[ -d "$HOME/.nvm" ]] && ! command -v node >/dev/null 2>&1; then
        # Try to use the default node version if nvm is available
        if command -v nvm >/dev/null 2>&1; then
            nvm use default 2>/dev/null || nvm use node 2>/dev/null || true
        fi
    fi
}

_setup_node

# Node.js diagnostic function
node_diagnose() {
    echo "=== Node.js Environment Diagnostic ==="
    echo
    echo "PATH check:"
    echo "$PATH" | tr ':' '\n' | grep -E "(node|nvm)" || echo "No node/nvm paths found in PATH"
    echo
    echo "Command availability:"
    command -v nvm >/dev/null 2>&1 && echo "✓ nvm: $(type nvm)" || echo "✗ nvm: not found"
    command -v node >/dev/null 2>&1 && echo "✓ node: $(which node)" || echo "✗ node: not found"
    command -v npm >/dev/null 2>&1 && echo "✓ npm: $(which npm)" || echo "✗ npm: not found"
    echo
    echo "NVM status:"
    if [[ -n "${NVM_DIR:-}" ]]; then
        echo "NVM_DIR: $NVM_DIR"
        if [[ -s "$NVM_DIR/nvm.sh" ]]; then
            echo "✓ nvm.sh exists"
        else
            echo "✗ nvm.sh not found"
        fi
        if command -v nvm >/dev/null 2>&1; then
            echo "Current node: $(nvm current 2>/dev/null || echo 'none')"
            echo "Default: $(nvm version default 2>/dev/null || echo 'not set')"
        fi
    else
        echo "✗ NVM_DIR not set"
    fi
    echo
    echo "Versions:"
    node --version 2>/dev/null && npm --version 2>/dev/null || echo "Node/npm not available"
}

# Rust configuration
if [[ -d "$HOME/.cargo" ]]; then
    export CARGO_HOME="$HOME/.cargo"
    export RUSTUP_HOME="$HOME/.rustup"
fi

# Go configuration
if _exists go; then
    export GOPATH="${GOPATH:-$HOME/go}"
    export GOPROXY="https://proxy.golang.org,direct"
    export GOSUMDB="sum.golang.org"
fi

# ==============================================================================
# DEVELOPMENT TOOLS
# ==============================================================================

# pipx completion
if _exists pipx; then
    autoload -U bashcompinit
    bashcompinit
    eval "$(register-python-argcomplete pipx)"
fi

# GitHub CLI completion
if _exists gh; then
    # Lazy load for performance
    _gh_completion() {
        unfunction _gh_completion
        eval "$(gh completion --shell zsh)"
    }
    compdef _gh_completion gh
fi

# Kubectl completion
if _exists kubectl; then
    # Lazy load for performance
    _kubectl_completion() {
        unfunction _kubectl_completion
        source <(kubectl completion zsh)
    }
    compdef _kubectl_completion kubectl
fi

# ==============================================================================
# PERFORMANCE MONITORING
# ==============================================================================

# Function to show zsh startup time
zsh_bench() {
    for i in $(seq 1 10); do
        time zsh -i -c exit
    done
}

# Function to profile zsh startup
zsh_profile() {
    zsh -i -c 'zmodload zsh/zprof && zprof'
}

# ==============================================================================
# PLUGIN MANAGEMENT
# ==============================================================================

# Function to source files safely
_safe_source() {
    local file="$1"
    [[ -r "$file" ]] && source "$file"
}

# Load custom functions (with error handling)
if [[ -d "${ZDOTDIR:-$HOME}/.zsh_functions" ]]; then
    fpath=("${ZDOTDIR:-$HOME}/.zsh_functions" $fpath)
    autoload -Uz "${ZDOTDIR:-$HOME}/.zsh_functions"/*(:t) 2>/dev/null
fi

# Load dotfiles library
if [[ -d "$DOTFILES/lib" ]]; then
    for lib_file in "$DOTFILES"/lib/*.zsh; do
        if [[ -r "$lib_file" ]]; then
            source "$lib_file" 2>/dev/null || {
                echo "Warning: Failed to load $lib_file" >&2
            }
        fi
    done
fi

# Load local configuration (keep this near the end)
_safe_source "$HOME/.zshlocal"

# ==============================================================================
# SHELL PLUGINS (Keep at the end for proper initialization)
# ==============================================================================

# Initialize Sheldon (plugin manager)
if _exists sheldon; then
    eval "$(sheldon source)"
fi

# ==============================================================================
# FINAL SETUP
# ==============================================================================

# Display system info on new terminal (optional)
if [[ "${SHOW_SYSINFO_ON_START:-false}" == "true" ]] && _exists neofetch; then
    neofetch
fi

# Cleanup functions
unfunction _extend_path _setup_editor _setup_pager _setup_node _safe_source 2>/dev/null

# Enable profiling output (uncomment if profiling was enabled at the top)
# zprof
