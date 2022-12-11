# Export path to root of dotfiles repo
export DOTFILES=${DOTFILES:="$HOME/.dotfiles"}

# Spaceship custom config file
export SPACESHIP_CONFIG="$DOTFILES/home/spaceshiprc.zsh"

# Locale
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export LANGUAGE=en_US.UTF-8

export MANPATH="/usr/local/man:$MANPATH"

COMPLETION_WAITING_DOTS="true"

# nnn plugins
# export NNN_PLUG='f:finder;o:fzopen;d:diffs;t:nmount;v:imgview;Alt+c:x2sel;Alt+e:suedit'

# Extend $PATH without duplicates
_extend_path() {
	[[ -d "$1" ]] || return

	if ! $(echo "$PATH" | tr ":" "\n" | grep -qx "$1"); then
		export PATH="$1:$PATH"
	fi
}

# Add custom bin to $PATH
_extend_path "$HOME/.local/bin"
_extend_path "$DOTFILES/bin"
_extend_path "$HOME/.npm-global/bin"
_extend_path "$HOME/.rvm/bin"
_extend_path "$HOME/.yarn/bin"
_extend_path "$HOME/.config/yarn/global/node_modules/.bin"
_extend_path "$HOME/.bun/bin"
_extend_path "$HOME/.cargo/bin"
_extend_path "$HOME/bin"

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
	export EDITOR='lvim'
fi

# Better formatting for time command
export TIMEFMT=$'\n================\nCPU\t%P\nuser\t%*U\nsystem\t%*S\ntotal\t%*E'

# ------------------------------------------------------------------------------
# Oh My Zsh
# ------------------------------------------------------------------------------
ZSH_DISABLE_COMPFIX=true

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
	docker
	ssh-agent
)

# Autoload node version when changing cwd
zstyle ':omz:plugins:nvm' autoload yes

# ------------------------------------------------------------------------------
# Dependencies
# ------------------------------------------------------------------------------

# Shell plugins
eval "$(sheldon source)"

# Per-directory configs
if command -v direnv >/dev/null 2>&1; then
	eval "$(direnv hook zsh)"
fi

# Start homebrew
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

# ------------------------------------------------------------------------------
# Overrides
# ------------------------------------------------------------------------------

# Sourcing all zsh files from $DOTFILES/lib
lib_files=($(find $DOTFILES/lib -type f -name "*.zsh"))
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
