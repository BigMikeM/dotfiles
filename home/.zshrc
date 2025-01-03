#!/bin/zsh
# Export path to root of dotfiles repo
export DOTFILES="$HOME/.dotfiles"
export DOTFILES=${DOTFILES:="$HOME/.dotfiles"}

_exists() {
	command -v "$1" >/dev/null 2>&1
}

# Ensure XDG_CONFIG_HOME is set, as it seems not to be sometimes
if [[ -z $XDG_CONFIG_HOME ]]; then
	export XDG_CONFIG_HOME="$HOME/.config/"
fi

export MANPATH="/usr/local/man:$MANPATH"

export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

export COMPLETION_WAITING_DOTS="true"

# Extend $PATH without duplicates
_extend_path() {
	[[ -d "$1" ]] || return

	if ! echo "$PATH" | tr ":" "\n" | grep -qx "$1"; then
		export PATH="$1:$PATH"
	fi
}

_extend_path "/usr/local/go/bin"   # Golang manual installation
_extend_path "/usr/local/bin/nvim" # Nvim appimage installation
_extend_path "/opt/neovide"        # neovide appimage installation
_extend_path "$HOME/.local/bin"
_extend_path "$DOTFILES/bin"
_extend_path "$HOME/perl5/bin"
_extend_path "$HOME/go/bin"
_extend_path "$HOME/.npm-global/bin"
_extend_path "$HOME/.rvm/bin"
_extend_path "$HOME/.yarn/bin"
_extend_path "$HOME/.config/yarn/global/node_modules/.bin"
_extend_path "$HOME/go/bin"
_extend_path "$HOME/bin"
_extend_path "$HOME/.cargo/bin"

# Extend $NODE_PATH
if [ -d ~/.npm-global ]; then
	export NODE_PATH="$NODE_PATH:$HOME/.npm-global/lib/node_modules"
fi

# Default editor for local and remote sessions
if [[ -n "$SSH_CONNECTION" ]]; then
	# on the server
	if [ command -v nvim ] >/dev/null 2>&1; then
		export EDITOR='nvim'
	else
		export EDITOR='vim'
	fi
else
	export EDITOR='nvim'
fi

# # Better formatting for time command
# export TIMEFMT=$'\n================\nCPU\t%P\nuser\t%*U\nsystem\t%*S\ntotal\t%*E'

# # Default pager
# export PAGER='less'

# # less options
# less_opts=(
# 	# Quit if entire file fits on first screen.
# 	-FX
# 	# Ignore case in searches that do not contain uppercase.
# 	--ignore-case
# 	# Allow ANSI colour escapes, but no other escapes.
# 	--RAW-CONTROL-CHARS
# 	# Quiet the terminal bell. (when trying to scroll past the end of the buffer)
# 	--quiet
# 	# Do not complain when we are on a dumb terminal.
# 	--dumb
# )
# export LESS="${less_opts[*]}"

# ------------------------------------------------------------------------------
# Oh My Zsh
# ------------------------------------------------------------------------------
export ZSH_DISABLE_COMPFIX=true
export ZSH_THEME='gozilla'

# OMZ is managed by Sheldon
export ZSH="$HOME/.local/share/sheldon/repos/github.com/ohmyzsh/ohmyzsh"

export plugins=(
	history-substring-search
	git
	npm
	nvm
	sudo
	extract
	gh
	vscode
	common-aliases
	command-not-found
)

# Autoload node version when changing cwd
zstyle ':omz:plugins:nvm' autoload yes

# ------------------------------------------------------------------------------
# Other stuff
# ------------------------------------------------------------------------------
export BAT_THEME="Catppuccin-mocha"

export ELECTRON_OZONE_PLATFORM_HINT='wayland'

if _exists pipx; then
	autoload -U bashcompinit
	bashcompinit
	eval "$(register-python-argcomplete pipx)"
fi

# Source local configuration
if [[ -f "$HOME/.zshlocal" ]]; then
	source "$HOME/.zshlocal"
fi
fpath+=${ZDOTDIR:-~}/.zsh_functions

# Shell plugins
eval "$(sheldon source)"
