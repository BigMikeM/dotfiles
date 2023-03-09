#!/usr/bin/env bash

# Dotfiles and bootstrap installer
# Installs git, clones repository and symlinks dotfiles to your home directory

set -e
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
	echo -e "${GREEN}${BOLD}${*}${RESET}"
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
	sleep 1
}

# Set directory
export DOTFILES=${1:-"$HOME/.dotfiles"}
GITHUB_REPO_URL_BASE="https://github.com/bigmikem/dotfiles"

on_start() {
	info "     |-|                                             |-|     "
	info "     |-|         Custom dotfiles bootstrap.          |-|     "
	info "     |-|                                             |-|     "
	info "     |-|     This script will attempt to install     |-|     "
	info "     |-|      and set up a curated selection of      |-|     "
	info "     |-|        GUI and CLI apps, as well as         |-|     "
	info "     |-|         custom configuration files.         |-|     "
	info "     |-|                                             |-|     "
	warn "     |-|         ONLY ARCHLINUX-BASED SYSTEMS        |-|     "
	warn "     |-|          ARE CURRENTLY SUPPORTED!!          |-|     "
	info "     |-|                                             |-|     "
	info "     |-|          created by @denysdovhan            |-|     "
	info "     |-|            edited by @BigMikeM              |-|     "
	info "     |-|                                             |-|     "

  info "This script will attempt to install and set up desired software."
	echo

	read -p "Do you want to proceed with installation? [y/N] " -n 1 answer
	echo

	if [[ "${answer:0:1}" != "y" ]]; then
		exit 1
	fi
}

install_yay() {
	if ! _exists pacman; then
    error "Pacman not found! Cannot install yay."
    echo

		return
	fi

	if _exists yay; then
		return
	fi

	info 'Trying to install "Yay: Yet Another Yogurt"'

  YAY_BUILD_DIR="~/.build_yay/"

  info "Using build directory: $YAY_BUILD_DIR"
  echo

	sudo pacman -S --needed git base-devel
	git clone "https://aur.archlinux.org/yay.git" "$YAY_BUILD_DIR"
	cd "$YAY_BUILD_DIR"
	makepkg -si
  cd -
	rm -rf "$YAY_BUILD_DIR"

  finish
}

install_software() {

	info "Installing software..."

  software=(
    # Base software needed for others
    git
    openssh
    sheldon
    # Handy CLI utilities
    tree
    lsd
    bat
    tldr
    github-cli
    trash-cli
    # CLI apps
    neovim
    lazygit
    ranger
    nvm
    # GUI apps
    kitty
    wezterm
    # Preferred (yet optional) dependencies
    luarocks
    atool
    ueberzug
    highlight
    shellcheck
    shellharden
  )


	if _exists yay; then
		yay -Syu --needed "${software[@]}"
	else
		error "Error: Yay is not available. Skipping installation of extra software"
	fi

	finish
}

on_finish() {
	echo
	success "Setup was successfully done!"
	success "Happy Coding!"
}

on_error() {
	echo
	error "ERROR"
	error "Something borked."
	echo
	exit 1
}

check_software_for_setup() {
  
  info "Checking for apps which will need to be set up after bootstrap..."

  software_to_check=(
    sheldon
    gh
    nvm
  )
  
  software_to_setup=()

  for i in "$software_to_check"; do
    if ! _exists "$i"; then
      software_to_setup+="$i"

      info "${i} was not found. Adding to setup list."
    fi
  done

  finish
}

_set_up_nvm() {

  info "Setting up Node Version Manager"
  info "This will install the latest version of NodeJS."
  read -p "Would you also like to install the latest LTS release? [y/N]" -n 1 answer
	echo

  nvm install node

	if [[ "${answer,,}" != "y" || "${answer,,}" != "yes" ]]; then
		info "You chose to install the latest NodeJS lts."
    nvm install --lts
	fi

  finish
}

_set_up_sheldon() {

  info "Setting up Sheldon."
  echo

  sheldon lock --update

  finish
}

_set_up_gh() {

  info "Setting up GitHub CLI."
  info "This will also set up SSH to connect your git repos with GitHub."
  echo

  gh auth login

  finish
}

_set_up_lvim() {

  if ! _exists nvim; then
    exit
  fi

  info "LunarVim setup is not yet complete."
  info "Skipping."
  echo

  return

}

_init_app() {

  local app="$1"

  if ! _exists "$app"; then
    return
  fi
  
  eval "_set_up_$1" || 
    warn "No setup function found for $i"
    info "Skipping setup of $i"
    echo

    return
}

set_up_software() {

  info "Attempting to initialize new apps."

  for i in "${software_to_setup[*]}"; do
    _init_app "$i"
  done

  finish
}

main() {
	on_start "$*"
  check_software_for_setup "$*"
	install_yay "$*"
	install_software "$*"
	on_finish "$*"
}

main "$*"
