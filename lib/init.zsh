setopt extendedglob
bindkey -v
autoload -Uz compinit
compinit

export PATH="/home/mike/.cargo/bin:/home/mike/.local/bin:$HOME/bin:$PATH"
export MANPATH="/usr/local/man:$MANPATH"
export TERM=xterm-256color-italic
export EDITOR='lvim'

COMPLETION_WAITING_DOTS="true"
HISTFILE=~/.histfile
HISTSIZE=5000
SAVEHIST=10000

ZSH_CACHE_DIR=$HOME/.cache/oh-my-zsh
if [[ ! -d $ZSH_CACHE_DIR ]]; then
  mkdir $ZSH_CACHE_DIR
fi
