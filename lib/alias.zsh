# Enable aliases to be sudo’ed
#   http://askubuntu.com/questions/22037/aliases-not-available-when-using-sudo
alias sudo='sudo '

_exists() {
	command -v "$1" >/dev/null 2>&1
}

# Avoid stupidity with trash-cli:
# https://github.com/sindresorhus/trash-cli
# or use default rm -i
if _exists trash; then
	alias rm='trash'
fi

# Just bcoz cls shorter than clear
alias cls='clear'

# Folders Shortcuts
[ -d ~/Downloads ] && alias dl='cd ~/Downloads'
[ -d ~/Desktop ] && alias dt='cd ~/Desktop'
[ -d ~/Notes ] && alias pn='cd ~/Notes'
[ -d ~/Projects ] && alias pc='cd ~/Projects'
[ -d ~/Projects/Forks ] && alias pcf='cd ~/Projects/Forks'
[ -d ~/Projects/Work ] && alias pcw='cd ~/Projects/Work'
[ -d ~/Projects/Playground ] && alias pcp='cd ~/Projects/Playground'
[ -d ~/Projects/Repos ] && alias pcr='cd ~/Projects/Repos'
[ -d ~/Projects/Learning/ ] && alias pcl='cd ~/Projects/Learning'

# Commands Shortcuts
alias e='$EDITOR'
alias -- +x='chmod +x'
alias x+='chmod +x'

# Open aliases
alias open='open_command'
alias o='open'
alias oo='open .'

# Run scripts
alias update='source $DOTFILES/scripts/update'
alias bootstrap='source $DOTFILES/scripts/bootstrap'

# Quick jump to dotfiles
alias dotfiles='e $DOTFILES'

# Quick reload of zsh environment
alias reload='source $HOME/.zshrc'

# Show $PATH in readable view
alias path='echo -e ${PATH//:/\\n}'

# Download web page with all assets
alias getpage='wget --no-clobber --page-requisites --html-extension --convert-links --no-host-directories'

# Download file with original filename
alias get="curl -O -L"

# Use tldr as help util
if _exists tldr; then
	alias help="tldr"
fi

alias git-root='cd $(git rev-parse --show-toplevel)'

if _exists lsd; then
	unalias ls
	alias ls='lsd'
	alias lt='lsd --tree'
fi

# cat with syntax highlighting
# https://github.com/sharkdp/bat
if _exists bat; then
	alias cat='bat'
fi

if _exists ranger; then
	alias rd=". ranger"
fi

# Neovide aliases
if _exists neovide; then
	alias nd='neovide'
fi

if _exists arm-none-eabi-gdb; then
	alias agdb='arm-none-eabi-gdb'
fi

if _exists lazygit; then
	alias lg='lazygit'
fi

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'
