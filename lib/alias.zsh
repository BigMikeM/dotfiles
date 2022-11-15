# Enable aliases to be sudo’ed
#   http://askubuntu.com/questions/22037/aliases-not-available-when-using-sudo
alias sudo='sudo '

_exists() {
  command -v $1 > /dev/null 2>&1
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
[ -d ~/Downloads ]                 && alias dl='cd ~/Downloads'
[ -d ~/Desktop ]                   && alias dt='cd ~/Desktop'
[ -d ~/Projects ]                  && alias pj='cd ~/Projects'
[ -d ~/Projects/Notes ]            && alias pn='cd ~/Projects/Notes'
[ -d ~/Projects/Code ]             && alias pc='cd ~/Projects/Code'
[ -d ~/Projects/Code/Forks ]       && alias pcf='cd ~/Projects/Code/Forks'
[ -d ~/Projects/Code/Work ]        && alias pcw='cd ~/Projects/Code/Work'
[ -d ~/Projects/Code/Playground ]  && alias pcp='cd ~/Projects/Code/Playground'
[ -d ~/Projects/Code/Repos ]       && alias pcr='cd ~/Projects/Code/Repos'

# Commands Shortcuts
alias e="$EDITOR"
alias -- +x='chmod +x'
alias x+='chmod +x'

# Open aliases
alias open='open_command'
alias o='open'
alias oo='open .'

# Run scripts
alias update="source $DOTFILES/scripts/update.zsh"
alias bootstrap="source $DOTFILES/scripts/bootstrap.zsh"

# Quick jump to dotfiles
alias dotfiles="e $DOTFILES"

# Quick reload of zsh environment
alias reload="source $HOME/.zshrc"

# My IP
alias myip='ifconfig | sed -En "s/127.0.0.1//;s/.*inet (addr:)?(([0-9]*\.){3}[0-9]*).*/\2/p"'

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

# Make ranger change to current directory on exit
if _exists ranger; then
  alias ranger='. ranger'
fi

# Byobu-tmux wrapper
if _exists byobu && _exists tmux; then
  alias tmux='byobu-tmux'
fi

# Neovide and Lunarvim aliases
if _exists neovide;then

  if ! _exists lvim; then
    alias neovide='neovide --multigrid'
  else
    alias neovide='neovide --multigrid --neovim-bin="/usr/bin/lvim"'
  fi

  if _exists neovide-lunarvim; then
    alias neovide='neovide-lunarvim --multigrid'
  fi

fi
