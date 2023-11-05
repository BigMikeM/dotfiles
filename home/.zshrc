#! /usr/bin/env zsh
# Export path to root of dotfiles repo
export DOTFILES="$HOME/.dotfiles"
export DOTFILES=${DOTFILES:="$HOME/.dotfiles"}

_exists() {
	command -v "$1" >/dev/null 2>&1
}

# Ensure XDG_CONFIG_HOME is set, as it seems not to be sometimes
if [[ -z $XDG_CONFIG_HOME ]]; then
	export XDG_CONFIG_HOME="/home/mike/.config/"
fi

# Avoid file overwrites when using >
set -o noclobber

# Spaceship custom config file
# export SPACESHIP_CONFIG="$DOTFILES/home/spaceshiprc.zsh"

export MANPATH="/usr/local/man:$MANPATH"

COMPLETION_WAITING_DOTS="true"

# Extend $PATH without duplicates
_extend_path() {
	[[ -d "$1" ]] || return

	if ! echo "$PATH" | tr ":" "\n" | grep -qx "$1"; then
		export PATH="$1:$PATH"
	fi
}

_extend_path "$HOME/.local/bin"
_extend_path "$DOTFILES/bin"
_extend_path "$HOME/perl5/bin"
_extend_path "$HOME/go/bin"
_extend_path "/opt/nvim-linux64/bin"
_extend_path "$HOME/.npm-global/bin"
_extend_path "$HOME/.rvm/bin"
_extend_path "$HOME/.yarn/bin"
_extend_path "$HOME/.config/yarn/global/node_modules/.bin"
_extend_path "$HOME/go/bin"
_extend_path "$HOME/bin"
_extend_path "$HOME/.cargo/bin"

# generate environment with system-d and export vars
# export "$(run-parts /usr/lib/systemd/user-environment-generators/ | xargs)"

# Extend $NODE_PATH
if [ -d ~/.npm-global ]; then
	export NODE_PATH="$NODE_PATH:$HOME/.npm-global/lib/node_modules"
fi

# Load nvm
# source /usr/share/nvm/init-nvm.sh

# Default editor for local and remote sessions
if [[ -n "$SSH_CONNECTION" ]]; then
	# on the server
	if [ command -v nvim ] >/dev/null 2>&1; then
		export EDITOR='nvim'
	else
		export EDITOR='vim'
	fi
else
	export EDITOR='lvim'
fi

# Better formatting for time command
export TIMEFMT=$'\n================\nCPU\t%P\nuser\t%*U\nsystem\t%*S\ntotal\t%*E'

# Default pager
export PAGER='less'

# less options
less_opts=(
	# Quit if entire file fits on first screen.
	-FX
	# Ignore case in searches that do not contain uppercase.
	--ignore-case
	# Allow ANSI colour escapes, but no other escapes.
	--RAW-CONTROL-CHARS
	# Quiet the terminal bell. (when trying to scroll past the end of the buffer)
	--quiet
	# Do not complain when we are on a dumb terminal.
	--dumb
)
export LESS="${less_opts[*]}"

# ------------------------------------------------------------------------------
# Oh My Zsh
# ------------------------------------------------------------------------------
ZSH_DISABLE_COMPFIX=true
ZSH_THEME='gozilla'

# OMZ is managed by Sheldon
export ZSH="$HOME/.local/share/sheldon/repos/github.com/ohmyzsh/ohmyzsh"

plugins=(
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

# Shell plugins
eval "$(sheldon source)"

# # Sourcing all zsh files from $DOTFILES/lib
# lib_files=($(find "$DOTFILES/lib" -type f -name "*.zsh"))

# if [[ "${#lib_files[@]}" -gt 0 ]]; then
# 	for file in "${lib_files[@]}"; do
# 		source "$file"
# 	done
# fi
#
if _exists pipx; then
	autoload -U bashcompinit
	bashcompinit
	eval "$(register-python-argcomplete pipx)"
fi

# Source local configuration
if [[ -f "$HOME/.zshlocal" ]]; then
	source "$HOME/.zshlocal"
fi
