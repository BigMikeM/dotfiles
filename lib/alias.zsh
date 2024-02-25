#!/bin/bash
# Enable aliases to be sudo’ed
#   http://askubuntu.com/questions/22037/aliases-not-available-when-using-sudo
alias sudo='sudo '

_exists() {
	command -v "$1" >/dev/null 2>&1
}

# Trash files instead of deleting immediately
# https://github.com/sindresorhus/trash-cli
if _exists trash; then
	alias rm='trash'
fi

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
alias update='bash -c $DOTFILES/scripts/update'
alias bootstrap='bash -c $DOTFILES/scripts/bootstrap'

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

# ls with colors and icons
# Icons require a Nerd Font: https://www.nerdfonts.com/
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
# On some distros, "bat" may be installed as "batcat"
if _exists batcat; then
	alias cat='batcat'
fi

# Use colors with grep
alias grep='grep --color=auto'

# Slightly shortened 'clear'
alias cls='clear'

# Make ranger change directory on exit by default
if _exists ranger; then
	alias rd=". ranger"
fi

# Slightly shorter way to launch neovide
if _exists neovide; then
	alias nd='neovide'
# Use nevim instead of vim/vi by default
fi

# Because I have a Microbit to play with
# https://microbit.org/
if _exists arm-none-eabi-gdb; then
	alias agdb='arm-none-eabi-gdb'
fi

# Slightly shortened way to launch my favority git ui
# https://github.com/jesseduffield/lazygit
if _exists lazygit; then
	alias lg='lazygit'
fi

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'
