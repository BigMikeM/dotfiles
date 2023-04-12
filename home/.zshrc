#!/usr/bin/env zsh

# Export path to root of dotfiles repo
export DOTFILES="$HOME/.dotfiles"
export DOTFILES=${DOTFILES:="$HOME/.dotfiles"}

# Ensure XDG_CONFIG_HOME is set, as it seems not to be sometimes
if [[ -z $XDG_CONFIG_HOME ]]; then
  export XDG_CONFIG_HOME="/home/mike/.config/"
fi

# Spaceship custom config file
# export SPACESHIP_CONFIG="$DOTFILES/home/spaceshiprc.zsh"

export MANPATH="/usr/local/man:$MANPATH"

COMPLETION_WAITING_DOTS="true"

# Extend $PATH without duplicates
_extend_path() {
	[[ -d "$1" ]] || return

  
	if ! $(echo "$PATH" | tr ":" "\n" | grep -qx "$1"); then
		export PATH="$1:$PATH"
	fi
}

_extend_path "$HOME/.local/bin"
_extend_path "$DOTFILES/bin"
_extend_path "$HOME/perl5/bin"
_extend_path "$HOME/.npm-global/bin"
_extend_path "$HOME/.rvm/bin"
_extend_path "$HOME/.yarn/bin"
_extend_path "$HOME/.config/yarn/global/node_modules/.bin"
_extend_path "$HOME/.bun/bin"
_extend_path "$HOME/bin"
_extend_path "$HOME/.cargo/bin"

# generate environment with system-d and export vars
# export $(run-parts /usr/lib/systemd/user-environment-generators/ | xargs)

# Conditionally switch firefox to wayland mode when in wayland
if [[ "$XDG_SESSION_TYPE" == "wayland" ]]; then
  export MOZ_ENABLE_WAYLAND=1
fi

# Extend $NODE_PATH
if [ -d ~/.npm-global ]; then
	export NODE_PATH="$NODE_PATH:$HOME/.npm-global/lib/node_modules"
fi

# Load nvm
source /usr/share/nvm/init-nvm.sh

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
# Dependencies
# ------------------------------------------------------------------------------

# Shell plugins
eval "$(sheldon source)"

# ------------------------------------------------------------------------------
# Overrides
# ------------------------------------------------------------------------------

# Sourcing all zsh files from $DOTFILES/lib
lib_files=( $(find "$DOTFILES/lib" -type f -name "*.zsh") )

if [[ "${#lib_files[@]}" -gt 0 ]]; then
	for file in "${lib_files[@]}"; do
		source "$file"
	done
fi

# Source local configuration
if [[ -f "$HOME/.zshlocal" ]]; then
	source "$HOME/.zshlocal"
fi
# ------------------------------------------------------------------------------
