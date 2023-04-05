#!/bin/bash

# Get System Updates, Update NodeJS/NPM, Update rust/Rustup, etc...
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
	command -v "$1" >/dev/null 2>&1
}

# Informational messages
info() {
	echo -e "${CYAN}${*}${RESET}"
}

# Success reporter
success() {
	echo -e "${GREEN}${*}${RESET}"
}

# Error reporter
error() {
	echo -e "${RED}${BOLD}${*}${RESET}"
}

# Warning or otherwise important message
warn() {
  echo -e "${YELLOW}${*}${RESET}"
}

# End section
finish() {
	success "Done!"
	echo
	sleep 2
}

# Set directory
export DOTFILES=${1:-"$HOME/.dotfiles"}

update_dotfiles() {
	info "Updating dotfiles..."

	cd "$DOTFILES" || exit
	git pull origin main
	./install --except shell
	cd - >/dev/null 2>&1 || exit

	info "Updating Zsh plugins..."
	sheldon lock --update

	finish
}

update_system() {
  if ! _exists pacman; then
    return
  elif _exists yay; then
    _update_yay
  elif _exists pacman; then
    _update_pacman
  fi
}

_update_pacman() {
	if ! _exists pacman; then
		return
	fi

  info "Pacman detected."
  info "Updating system packages."
  echo

	sudo pacman -Syu

  finish
}

_update_yay() {
	if ! _exists yay; then
		return
	fi

  echo
  info "Updating all packages (including development)"
  echo

	yay -Syu --devel

  echo
  info "Cleaning up unnecessary packages."
  echo

	yay -Yc

  echo
  finish
}

update_npm() {
	if ! _exists npm; then
		return
	fi

	info "Updating NPM..."
  echo

	if _exists nvm; then
		nvm install-latest-npm
	else
		npm install npm -g
		npm update -g
	fi

	finish
}

nvm_node_version() {
	printf %s "$(nvm ls "$1" | cut -s -d'.' -f'1,2' | cut -d'v' -f2)"
}

system_node_version() {
	printf %s "$(node --version | cut -s -d'.' -f'1,2' | cut -d'v' -f2)"
}

get_node_version() {
	if _exists nvm; then
		printf %s "$(nvm_node_version "$1")"
	else
		printf %s "$(system_node_version)"
	fi
}

nvm_lts_versions() {
	printf "%s\n" "$(nvm ls | grep "lts" | grep -Fv 'N/A' | grep -Fv '*' | cut -d'v' -f2 | cut -d'.' -f'1')"
}

update_all_node() {
	if ! _exists nvm; then
		info "Node Version Manager (nvm) not found. Unable to automatically update NodeJS."
    echo

		return
	fi

	info "Attempting to update all installed versions of NodeJS."
  echo

	current_version=$(get_node_version "current")
	default_node_version=$(get_node_version "default")

	info "Updating current active version of NodeJS."
  echo

	nvm install "$current_version" --latest-npm

	if [[ "$default_node_version" != "$current_version" ]]; then
		info "Updating default version of NodeJS."
    echo

		nvm install "$default_node_version"
	fi

	nvm_lts_versions | while read -r lts_version; do
    info "Updating all installed LTS versions of NodeJS."
    echo

		nvm install "$lts_version"
	done

	# Ensure we are using the version of node we started with
  info "Switching back to the version of NodeJS we started with."
  echo

	nvm use "$current_version"

	finish
}

update_rust() {
	if ! _exists rustup; then
		return
	fi

	info "Updating Rust..."
  echo

	rustup update

	finish
}

on_start() {
	info "     |-|                                             |-|     "
	info "     |-|           Custom update utility.            |-|     "
	info "     |-|                                             |-|     "
	info "     |-|      This script will attempt to update     |-|     "
	info "     |-|    the dotfiles repo and system packages.   |-|     "
	info "     |-|                                             |-|     "
	warn "     |-|        ONLY ARCHLINUX-BASED SYSTEMS         |-|     "
	warn "     |-|         ARE CURRENTLY SUPPORTED!!           |-|     "
	info "     |-|                                             |-|     "
	info "     |-|          created by @denysdovhan            |-|     "
	info "     |-|            edited by @BigMikeM              |-|     "
	info "     |-|                                             |-|     "

  info "This script will attempt to install and set up desired software."
  info "You may be prompted for input multiple times throughout the process."
	echo

	read -rp "Would you like to proceed with installation? [y/N] " -n 1 answer
	echo

	if [[ "${answer,,}" != "y" ]]; then
		exit 1
	fi
}

on_finish() {
	success "Done with system update!"
	success "Happy Coding!"
}

on_error() {
	error "ERROR!"
  error "Something Borked."
	exit 1
}

main() {

  on_start "$*"

  echo "Please enter your password to get started:"
  sudo -v

	update_dotfiles "$*"
	update_system "$*"
	update_rust "$*"
	update_all_node "$*"
	update_npm "$*"
	on_finish "$*"
}

main "$*"
