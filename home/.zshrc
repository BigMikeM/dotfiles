#!/bin/zsh
# ==============================================================================
# EARLY INITIALIZATION
# ==============================================================================

# Export path to root of dotfiles repo
export DOTFILES="${DOTFILES:-$HOME/.dotfiles}"

# Utility functions
_exists() {
	command -v "$1" >/dev/null 2>&1
}

_is_wsl() {
	[[ "$(uname -r)" == *WSL* ]] || [[ -n "${WSL_DISTRO_NAME:-}" ]]
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

# Create XDG directories
local -a xdg_dirs=(
	"$XDG_CONFIG_HOME"
	"$XDG_DATA_HOME"
	"$XDG_STATE_HOME"
	"$XDG_CACHE_HOME"
	"${XDG_CACHE_HOME}/zsh"
	"${XDG_STATE_HOME}/zsh"
)

for dir in "${xdg_dirs[@]}"; do
	[[ ! -d "$dir" ]] && mkdir -p "$dir"
done

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
_extend_path "/opt/neovide"          # Neovide AppImage
_extend_path "/opt/nvim-linux64/bin" # Neovim alternative location

# User-specific paths
_extend_path "$HOME/.local/bin"
_extend_path "$DOTFILES/bin"
_extend_path "$HOME/bin"

# Language-specific paths
_extend_path "$HOME/.cargo/bin"      # Rust
_extend_path "$HOME/go/bin"          # Go
_extend_path "$HOME/.npm-global/bin" # npm global
_extend_path "$HOME/.rvm/bin"        # Ruby Version Manager
_extend_path "$HOME/perl5/bin"       # Perl

# Node.js configuration
if [[ -d "$HOME/.npm-global" ]]; then
	export NODE_PATH="$NODE_PATH:$HOME/.npm-global/lib/node_modules"
	export NPM_CONFIG_PREFIX="$HOME/.npm-global"
fi

export EDITOR="${EDITOR:-$(command -v nvim || command -v vim || command -v vi)}"
export VISUAL="$EDITOR"
export PAGER="${PAGER:-$(command -v bat || command -v less || echo cat)}"

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
setopt INC_APPEND_HISTORY     # Append to history file immediately.

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

# Other useful options
setopt CORRECT              # Try to correct the spelling of commands
setopt INTERACTIVE_COMMENTS # Allow comments in interactive shells
setopt MULTIOS              # Write to multiple descriptors
setopt NO_BEEP              # Don't beep on error
setopt PROMPT_SUBST         # Enable parameter expansion in prompts

# ==============================================================================
# COMPLETION SYSTEM
# ==============================================================================

# Initialize completion system
autoload -Uz compinit

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

# Enable completion caching
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path "${XDG_CACHE_HOME}/zsh/zcompcache"

# Better color support
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"

# Group results by category
zstyle ':completion:*' group-name ''

# More informative completion
zstyle ':completion:*' verbose yes
zstyle ':completion:*:descriptions' format '%F{yellow}-- %d --%f'
zstyle ':completion:*:messages' format '%F{purple}-- %d --%f'
zstyle ':completion:*:warnings' format '%F{red}-- no matches found --%f'

# Case-insensitive completion
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'

# Performance: only check once per day
local zcompdump="${XDG_CACHE_HOME}/zsh/zcompdump"

# Check if we need to regenerate the completion dump
if [[ -f "$zcompdump" ]] && [[ -n "$zcompdump"(#qN.mh+24) ]]; then
    # File exists and is older than 24 hours, regenerate
    compinit -d "$zcompdump"
else
    # File is recent, load it quickly
    compinit -C -d "$zcompdump"
fi

# ==============================================================================
# PROMPT
# ==============================================================================

# Initialize Starship prompt (modern, fast alternative to OMZ themes)
if _exists starship; then
    eval "$(starship init zsh)"
fi

# ==============================================================================
# CORE SHELL ENHANCEMENTS (replaces OMZ plugins)
# ==============================================================================

# Sudo: Allow aliases to work with sudo
alias sudo='sudo '

# Extract: Smart archive extraction
extract() {
    if [[ -f "$1" ]]; then
        case "$1" in
            *.tar.bz2)   tar xjf "$1"     ;;
            *.tar.gz)    tar xzf "$1"     ;;
            *.bz2)       bunzip2 "$1"     ;;
            *.rar)       unrar x "$1"     ;;
            *.gz)        gunzip "$1"      ;;
            *.tar)       tar xf "$1"      ;;
            *.tbz2)      tar xjf "$1"     ;;
            *.tgz)       tar xzf "$1"     ;;
            *.zip)       unzip "$1"       ;;
            *.Z)         uncompress "$1"  ;;
            *.7z)        7z x "$1"        ;;
            *.tar.xz)    tar xf "$1"      ;;
            *.tar.zst)   tar xf "$1"      ;;
            *)           echo "'$1' cannot be extracted via extract()" ;;
        esac
    else
        echo "'$1' is not a valid file"
    fi
}

# History substring search (loaded by Sheldon, keybindings here)
autoload -U history-substring-search-up history-substring-search-down
zle -N history-substring-search-up
zle -N history-substring-search-down

# Bind keys for history substring search
bindkey '^[[A' history-substring-search-up      # Up arrow
bindkey '^[[B' history-substring-search-down    # Down arrow
bindkey '^P' history-substring-search-up        # Ctrl+P
bindkey '^N' history-substring-search-down      # Ctrl+N

# Vi mode with useful emacs keybindings
bindkey -e  # Emacs mode (default, familiar shortcuts)
bindkey '^R' history-incremental-search-backward

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
# DEVELOPMENT TOOLS - COMPLETIONS
# ==============================================================================

# Lazy-load completions with zsh-defer for better performance
# These will be loaded after shell initialization completes

if _exists gh; then
	# GitHub CLI completion (lazy-loaded)
	_gh_completion() {
		unfunction _gh_completion
		eval "$(gh completion --shell zsh)"
	}
	compdef _gh_completion gh
fi

if _exists kubectl; then
	# Kubernetes completion (lazy-loaded)
	_kubectl_completion() {
		unfunction _kubectl_completion
		source <(kubectl completion zsh)
	}
	compdef _kubectl_completion kubectl
fi

# Additional completions can be added here following the same pattern

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
	fpath=("${ZDOTDIR:-$HOME}/.zsh_functions" "$fpath")
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

# fnm setup
if _exists fnm; then
    # Disable --use-on-cd in WSL for performance
    if _is_wsl; then
    		export XDG_RUNTIME_DIR="${TMPDIR:-/tmp}/fnm_multishells}"
        eval "$(fnm env --use-on-cd --shell zsh)"
    else
        eval "$(fnm env --use-on-cd --shell zsh)"
    fi
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

# VSCode terminal integration
[[ "$TERM_PROGRAM" == "vscode" ]] && . "$(code --locate-shell-integration-path zsh)"

# Display system info on new terminal (optional)
if [[ "${SHOW_SYSINFO_ON_START:-false}" == "true" ]] && _exists neofetch; then
	neofetch
fi

# Cleanup functions
unfunction _extend_path _setup_editor _setup_pager _safe_source 2>/dev/null

# Compile zshrc for faster startup (regenerate when modified)
if [[ ! -f "${ZDOTDIR:-$HOME}/.zshrc.zwc" ]] ||
   [[ "${ZDOTDIR:-$HOME}/.zshrc" -nt "${ZDOTDIR:-$HOME}/.zshrc.zwc" ]]; then
    zcompile "${ZDOTDIR:-$HOME}/.zshrc"
fi
