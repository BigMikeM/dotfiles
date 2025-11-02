#!/bin/zsh
# Enhanced shell aliases with better organization and additional functionality
# Enable aliases to be sudo'ed
#   http://askubuntu.com/questions/22037/aliases-not-available-when-using-sudo

# Core utility functions
_exists() {
	command -v "$1" >/dev/null 2>&1
}

_is_wsl() {
	[[ "$(uname -r)" == *WSL* ]] || [[ -n "${WSL_DISTRO_NAME:-}" ]]
}



_is_linux() {
	[[ "$OSTYPE" == linux* ]]
}

# Safe directory check with fallback
_safe_alias_dir() {
	local dir="$1"
	local alias_name="$2"
	local alias_cmd="$3"

	if [[ -d "$dir" ]]; then
		alias "$alias_name"="$alias_cmd"
	fi
}

# Enhanced sudo to preserve aliases
alias sudo='sudo '

# System Information Aliases
alias sysinfo='uname -a && lsb_release -a 2>/dev/null || cat /etc/os-release'
alias meminfo='free -h'
alias diskinfo='df -h'
alias cpuinfo='lscpu'

# Enhanced File Operations
if _exists trash; then
	alias rm='trash'
	alias rmf='trash'    # Force delete alias
	alias rmi='trash -i' # Interactive delete
else
	alias rmf='rm -rf'
	alias rmi='rm -i'
fi

# Copy with progress (if available)
if _exists rsync; then
	alias cp='rsync -ah --progress'
fi

# Create directories with parents
alias mkdir='mkdir -pv'

# Enhanced ls commands
if _exists lsd; then
	unalias ls 2>/dev/null || true
	alias ls='lsd'
	alias ll='lsd -l'
	alias la='lsd -la'
	alias lt='lsd --tree'
	alias lta='lsd --tree -a'
	alias l='lsd -F'
elif _exists exa; then
	alias ls='exa'
	alias ll='exa -l'
	alias la='exa -la'
	alias lt='exa --tree'
	alias lta='exa --tree -a'
	alias l='exa -F'
else
	alias ll='ls -alF'
	alias la='ls -A'
	alias l='ls -CF'
fi

# Directory Navigation Shortcuts
_safe_alias_dir ~/Downloads dl 'cd ~/Downloads'
_safe_alias_dir ~/Desktop dt 'cd ~/Desktop'
_safe_alias_dir ~/Documents doc 'cd ~/Documents'
_safe_alias_dir ~/Notes pn 'cd ~/Notes'
_safe_alias_dir ~/Projects pc 'cd ~/Projects'
_safe_alias_dir ~/Projects/Forks pcf 'cd ~/Projects/Forks'
_safe_alias_dir ~/Projects/Work pcw 'cd ~/Projects/Work'
_safe_alias_dir ~/Projects/Playground pcp 'cd ~/Projects/Playground'
_safe_alias_dir ~/Projects/Repos pcr 'cd ~/Projects/Repos'
_safe_alias_dir ~/Projects/Learning pcl 'cd ~/Projects/Learning'
_safe_alias_dir ~/.config conf 'cd ~/.config'
_safe_alias_dir /var/log logs 'cd /var/log'

# Quick directory navigation
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias ~='cd ~'
alias -- -='cd -'

# Commands Shortcuts
alias e='${EDITOR:-nvim}'
alias edit='${EDITOR:-nvim}'
alias -- +x='chmod +x'
alias x+='chmod +x'
alias 644='chmod 644'
alias 755='chmod 755'
alias 777='chmod 777'

# Process management
alias psg='ps aux | grep -v grep | grep -i -e VSZ -e'
alias psme='ps -f -u $USER'
alias pscpu='ps auxf | sort -nr -k 3'
alias psmem='ps auxf | sort -nr -k 4'

# Network aliases
alias myip='curl -s ifconfig.me && echo'
alias localip='hostname -I | cut -d" " -f1'
alias ports='netstat -tulanp'
alias listening='lsof -i -P -n | grep LISTEN'

# Git shortcuts
alias g='git'
alias gs='git status'
alias ga='git add'
alias gc='git commit'
alias gcm='git commit -m'
alias gp='git push'
alias gl='git pull'
alias gd='git diff'
alias gb='git branch'
alias gco='git checkout'
alias gcb='git checkout -b'
alias gm='git merge'
alias gr='git rebase'
alias git-root='cd $(git rev-parse --show-toplevel)'

# Enhanced git log aliases
alias glog='git log --oneline --decorate --graph'
alias glogall='git log --oneline --decorate --graph --all'
alias glast='git log -1 HEAD'

# Open aliases with platform detection
if _is_wsl; then
	alias open='explorer.exe'
elif _is_linux && _exists xdg-open; then
	alias open='xdg-open'
elif _exists gnome-open; then
	alias open='gnome-open'
fi

# Define open_command for backward compatibility
if _exists open; then
	alias open_command='open'
fi

alias o='open'
alias oo='open .'

# Script execution aliases with enhanced paths
alias update="${DOTFILES:-$HOME/.dotfiles}/scripts/update"
alias bootstrap="${DOTFILES:-$HOME/.dotfiles}/scripts/bootstrap"
alias check-docs="${DOTFILES:-$HOME/.dotfiles}/scripts/check-docs"

# Quick jump to dotfiles
alias dotfiles='e ${DOTFILES:-$HOME/.dotfiles}'
alias dots='dotfiles'

# Shell environment management
alias reload='source ${HOME}/.zshrc'
alias rezsh='exec zsh'
alias rebash='exec bash'

# Path and environment utilities
alias path='echo -e ${PATH//:/\\\\n}'
alias env-grep='env | grep -i'
alias hist='history | grep'

# Download utilities
alias getpage='wget --no-clobber --page-requisites --html-extension --convert-links --no-host-directories'
alias get='curl -O -L'
alias wget-site='wget --recursive --no-clobber --page-requisites --html-extension --convert-links --restrict-file-names=windows --domains'

# Help and documentation
if _exists tldr; then
	alias help='tldr'
	alias h='tldr'
fi

if _exists man; then
	alias m='man'
fi

# Text processing and viewing
if _exists bat; then
	alias cat='bat'
	alias less='bat'
elif _exists batcat; then
	alias cat='batcat'
	alias less='batcat'
fi

# Enhanced grep with colors
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# Find utilities
alias fd='find . -type d -name'
alias ff='find . -type f -name'

# Archive management
alias untar='tar -zxvf'
alias tar='tar -czvf'
alias zip='zip -r'

# System utilities
alias cls='clear'
alias c='clear'
alias q='exit'
alias x='exit'

# Date and time
alias now='date +"%T"'
alias nowtime='now'
alias nowdate='date +"%d-%m-%Y"'
alias week='date +%V'

# File and directory size
if _exists du; then
	alias du='du -h'
	alias dus='du -sh'
	alias dud='du -d 1 -h'
fi

if _exists ncdu; then
	alias space='ncdu'
elif _exists du; then
	alias space='du -sh'
fi

# Enhanced ranger integration
if _exists ranger; then
	alias ranger='. ranger'
	alias r='ranger'
fi

# Editor shortcuts
if _exists neovide; then
	alias nv='neovide'
	alias neovide='neovide --fork'
fi

if _exists nvim; then
	alias vi='nvim'
	alias vim='nvim'
	alias v='nvim'
elif _exists vim; then
	alias vi='vim'
	alias v='vim'
fi

# Development tools
if _exists code; then
	alias vscode='code'
	alias vs='code'
	alias vsc='code .'
fi

# Git UI tools
if _exists gitui; then
	alias lg='gitui'
	alias lazygit='gitui' # Backward compatibility
	alias gu='gitui'
fi

# Docker shortcuts (if available)
if _exists docker; then
	alias d='docker'
	alias dc='docker-compose'
	alias dps='docker ps'
	alias dpsa='docker ps -a'
	alias di='docker images'
	alias drm='docker rm'
	alias drmi='docker rmi'
	alias dex='docker exec -it'
	alias dlog='docker logs'
	alias dstop='docker stop'
	alias dstart='docker start'
fi

# Kubernetes shortcuts (if available)
if _exists kubectl; then
	alias k='kubectl'
	alias kgp='kubectl get pods'
	alias kgs='kubectl get services'
	alias kgd='kubectl get deployments'
	alias kdp='kubectl describe pod'
	alias kds='kubectl describe service'
	alias kdd='kubectl describe deployment'
fi

# Python development
if _exists python3; then
	alias py='python3'
	alias python='python3'
	# Use uv if available, otherwise pip3
	if _exists uv; then
		alias pip='uv pip'
		alias pip3='uv pip'
		alias venv='uv venv'
		alias pyproject='uv init'
	else
		alias pip='pip3'
	fi
fi

if _exists ipython; then
	alias ipy='ipython'
fi

# UV Python package manager aliases
if _exists uv; then
	alias uvtool='uv tool'
	alias uvinstall='uv tool install'
	alias uvlist='uv tool list'
	alias uvupgrade='uv tool upgrade --all'
	alias uvrun='uv run'
	alias uvsync='uv sync'
	alias uvadd='uv add'
	alias uvhelp='uv-helper'
fi

# Node.js development
if _exists node; then
	alias n='node'
	alias nodeinfo='node --version && npm --version && which node && which npm'
fi

# NVM specific aliases
if [[ -d "$HOME/.nvm" ]]; then
	alias nvmuse='nvm use'
	alias nvmlist='nvm list'
	alias nvmdefault='nvm use default'
	alias nvmnode='nvm use node'
	alias nvminstall='nvm install'
	alias nvmcurrent='nvm current'
	alias nvmwhich='nvm which'
fi

if _exists npm; then
	alias ni='npm install'
	alias nid='npm install --save-dev'
	alias nr='npm run'
	alias ns='npm start'
	alias nt='npm test'
	alias nb='npm run build'
fi

if _exists yarn; then
	alias y='yarn'
	alias ya='yarn add'
	alias yad='yarn add --dev'
	alias yr='yarn run'
	alias ys='yarn start'
	alias yt='yarn test'
	alias yb='yarn build'
fi

# Rust development
if _exists cargo; then
	alias cr='cargo run'
	alias cb='cargo build'
	alias ct='cargo test'
	alias cc='cargo check'
	alias cf='cargo fmt'
	alias cl='cargo clippy'
fi

# System monitoring
if _exists htop; then
	alias top='htop'
	alias ht='htop'
elif _exists btop; then
	alias top='btop'
	alias bt='btop'
fi

if _exists iostat; then
	alias io='iostat -x 1'
fi

# Specialized tools
if _exists arm-none-eabi-gdb; then
	alias agdb='arm-none-eabi-gdb'
fi

if _exists register-python-argcomplete3; then
	alias register-python-argcomplete='register-python-argcomplete3'
fi

if _exists gh; then
	if gh extension list | grep -q copilot; then
		alias copilot='gh copilot'
		alias ghc='gh copilot'
	fi
fi

# Systemd shortcuts (Linux)
if _is_linux && _exists systemctl; then
	alias sc='systemctl'
	alias scu='systemctl --user'
	alias jc='journalctl'
	alias jcu='journalctl --user'
fi

# Package manager shortcuts
if _exists apt; then
	alias apt-update='sudo apt update && sudo apt upgrade'
	alias apt-install='sudo apt install'
	alias apt-search='apt search'
	alias apt-remove='sudo apt remove'
elif _exists dnf; then
	alias dnf-update='sudo dnf upgrade'
	alias dnf-install='sudo dnf install'
	alias dnf-search='dnf search'
	alias dnf-remove='sudo dnf remove'
elif _exists pacman; then
	alias pac='sudo pacman'
	alias pacs='pacman -Ss'
	alias paci='sudo pacman -S'
	alias pacr='sudo pacman -R'
	alias pacu='sudo pacman -Syu'
fi

# Flatpak shortcuts
if _exists flatpak; then
	alias fp='flatpak'
	alias fpi='flatpak install'
	alias fpr='flatpak remove'
	alias fpu='flatpak update'
	alias fps='flatpak search'
fi

# Snap shortcuts
if _exists snap; then
	alias sn='snap'
	alias sni='sudo snap install'
	alias snr='sudo snap remove'
	alias snu='sudo snap refresh'
	alias sns='snap search'
fi

# Add an "alert" alias for long running commands
# Use like: sleep 10; alert
if _exists notify-send; then
	alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history | tail -n1 | sed -e "s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//")"'
fi

# Weather alias (if curl is available)
if _exists curl; then
	alias weather='curl -s wttr.in'
	alias wttr='curl -s wttr.in'
fi

# Quick notes (if available)
if _exists jrnl; then
	alias j='jrnl'
	alias jt='jrnl today'
	alias jy='jrnl yesterday'
fi

# Cleanup functions
alias cleanup-logs='sudo find /var/log -type f -name "*.log" -mtime +30 -delete'
alias cleanup-cache='sudo find /var/cache -type f -mtime +30 -delete'
alias cleanup-tmp='sudo find /tmp -type f -mtime +7 -delete'

# Function to show all aliases
show_aliases() {
	echo "=== Custom Aliases ==="
	alias | grep -E "^(pc|dl|dt|pn|update|bootstrap|dotfiles)" | sort
	echo
	echo "=== Git Aliases ==="
	alias | grep -E "^g[a-z]" | sort
	echo
	echo "=== Development Aliases ==="
	alias | grep -E "^(py|n|cr|k|d)" | sort
	echo
	echo "=== System Aliases ==="
	alias | grep -E "^(ls|ll|la|cat|grep)" | sort
}

# Note: Functions are already available in the shell session
# No need to export in zsh as they're automatically available
