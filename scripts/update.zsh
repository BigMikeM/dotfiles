#!/usr/bin/env bash

# Get System Updates, update NPM packages and dotfiles
# Source: https://github.com/sapegin/dotfiles/blob/master/setup/update.sh

trap on_error SIGTERM

e='\033'
RESET="${e}[0m"
BOLD="${e}[1m"
CYAN="${e}[0;96m"
RED="${e}[0;91m"
YELLOW="${e}[0;93m"
GREEN="${e}[0;92m"

_exists() {
  command -v "$1" > /dev/null 2>&1
}

# Success reporter
info() {
  echo -e "${CYAN}${*}${RESET}"
}

# Error reporter
error() {
  echo -e "${RED}${*}${RESET}"
}

# Success reporter
success() {
  echo -e "${GREEN}${*}${RESET}"
}

# End section
finish() {
  success "Done!"
  echo
  sleep 1
}

# Set directory
export DOTFILES="~/.dotfiles/"

on_start() {
  info '           __        __   ____ _  __            '
  info '      ____/ /____   / /_ / __/(_)/ /___   _____ '
  info '     / __  // __ \ / __// /_ / // // _ \ / ___/ '
  info '  _ / /_/ // /_/ // /_ / __// // //  __/(__  )  '
  info ' (_)\__,_/ \____/ \__//_/  /_//_/ \___//____/   '
  info '                                                '
  info '          created by @denysdovhan               '
  info '           modified by @bigmikem                '
  info '                                                '
}

update_dotfiles() {
  info "Updating dotfiles..."

  cd "$DOTFILES" || exit
  git pull origin main
  # ./install --except shell
  cd - > /dev/null 2>&1 || exit

  info "Updating Zsh plugins..."
  sheldon lock --update

  finish
}

update_system() {
  update_brew "$*"
  update_apt_get "$*"
  update_archlinux "$*"
}

update_archlinux() {
  if ! _exists yay; then
    update_pacman "$*"
  else
    update_yay "$*"
  fi
}

update_pacman() {
  if ! _exists pacman; then
    return
  fi

  pacman -Syu
}

update_yay() {
  if ! _exists yay; then
    return
  fi

  yay -Syu
  yay -Yc
}

update_brew() {
  if ! _exists brew; then
    return
  fi

  info "Updating Homebrew..."

  brew update
  brew upgrade
  brew cleanup

  finish
}

update_apt_get() {
  if ! _exists apt-get; then
    return
  fi

  info "Updating Ubuntu and installed packages..."

  sudo apt-get update
  sudo apt-get upgrade -y
  sudo apt-get autoremove -y
  sudo apt-get autoclean -y

  finish
}

update_npm() {
  if ! _exists npm; then
    return
  fi

  info "Updating NPM..."

  if _exists nvm; then
    nvm install-latest-npm
  else
    npm install npm -g
    npm update -g
  fi

  finish
}

nvm_node_version() {
  printf %s "$(nvm ls $1 | cut -s -d'.' -f'1,2' | cut -d'v' -f2)"
}

system_node_version() {
  printf %s "$(node --version | cut -s -d'.' -f'1,2' | cut -d'v' -f2)"
}

get_node_version() {
  if _exists nvm; then
    printf %s `nvm_node_version "$1"`
  else
    printf %s `system_node_version`
  fi
}

nvm_lts_versions() {
  printf %s "$(nvm ls | grep lts | grep -v 'N/A' | cut -d' ' -f1)"
}

update_node() {
  if ! _exists nvm; then
    info "Node Version Manager (nvm) not found. Unable to automatically update NodeJS."
    return
  fi

  info "Updating all Node.js versions..."
  current_version=`get_node_version "current"`
  default_node_version=`get_node_version "default"`

  info "Updating current version of Node.js..."
  nvm install $current_version --latest-npm --reinstall-from=current

  if [[ $default_node_version != $current_version ]]; then
    info "Updating default version of Node.js..."
    nvm install $default_node_version
  fi

  info "Installing latest stable version of Node.js..."
  nvm install node

  info "Updating installed Node LTS versions..."
  nvm_lts_versions | while read lts_version; do
    info "Installing [$lts_version]..."
    nvm install $lts_version
  done

  # Ensure we are using the version of node we started with
  nvm use $current_version

  finish
}

on_finish() {
  success "Done!"
  success "Happy Coding!"
  echo
  echo -ne "$RED"'-_-_-_-_-_-_-_-_-_-_-_-_-_-_'
  echo -e  "$RESET""$BOLD"',------,'"$RESET"
  echo -ne "$YELLOW"'-_-_-_-_-_-_-_-_-_-_-_-_-_-_'
  echo -e  "$RESET""$BOLD"'|   /\_/\\'"$RESET"
  echo -ne "$GREEN"'-_-_-_-_-_-_-_-_-_-_-_-_-_-'
  echo -e  "$RESET""$BOLD"'~|__( ^ .^)'"$RESET"
  echo -ne "$CYAN"'-_-_-_-_-_-_-_-_-_-_-_-_-_-_'
  echo -e  "$RESET""$BOLD"'""  ""'"$RESET"
  echo
}

on_error() {
  error "Wow... Something serious happened!"
  error "Though, I don't know what really what it was :("
  exit 1
}

main() {
  echo "Before we proceed, please type your sudo password:"
  sudo -v

  on_start "$*"
  update_dotfiles "$*"
  update_system "$*"
  update_npm "$*"
  update_node "$*"
  on_finish "$*"
}

main "$*"
