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
		return
	fi

	if _exists yay; then
		return
	fi

	info "Trying to install Yay: Yet Another Yogurt"

	mkdir -p "~/build/"
  cd "~/build"
	pacman -S --needed git base-devel
	git clone https://aur.archlinux.org/yay.git
	cd yay
	makepkg -si
  cd "../.."
	rm -rf "~/build/"

}

install_git() {
	info "Trying to detect installed Git..."

	if ! _exists git; then
		echo "Seems like you don't have Git installed!"
		read -p "Would you like to proceed with Git installation? [y/N] " -n 1 answer
		echo
		if [ "${answer}" != "y" ]; then
			exit 1
		fi

		info "Installing Git..."

		if _exists yay; then
			yay -S git
		elif _exists pacman; then
			sudo pacman -S git
		else
			error "Error: Failed to install Git!"
			exit 1
		fi
	else
		success "You already have Git installed. Skipping..."
	fi

	finish
}

install_zsh() {
	info "Trying to detect installed Zsh..."

	if ! _exists zsh; then
		echo "Seems like you don't have Zsh installed!"
		read -p "Do you agree to proceed with Zsh installation? [y/N] " -n 1 answer
		echo
		if [ "${answer}" != "y" ]; then
			exit 1
		fi

		info "Installing Zsh..."

		if _exists yay; then
			yay -S zsh
		elif _exists pacman; then
			sudo pacman -S zsh
		else
			error "Error: Failed to install Zsh!"
			exit 1
		fi
	else
		success "You already have Zsh installed. Skipping..."
	fi

	if _exists zsh && [[ -z "$ZSH_VERSION" ]]; then
		info "Setting up Zsh as default shell..."

		echo "The script will ask you the password for sudo:"
		echo
		echo "1) When changing your default shell via chsh -s"
		echo

		chsh -s "$(command -v zsh)" || error "Error: Could not set Zsh as default shell!"
	fi

	finish
}

install_software() {

	info "Installing software..."

	if _exists yay; then
		software=(
      neovim
			sheldon
			tree
			lsd
			bat
			tldr
			github-cli
			lazygit
			trash-cli
			ranger
      luarocks
      atool
      ueberzug
      ffmpegthumbnailer
      highlight
      imagemagick
      libcaca
      mediainfo
      odt2txt
      perl-image-exiftool
      poppler
      transmission-cli
      python-chardet
      nvm
      kitty
      wezterm
		)

		yay -Syu --needed "${software[@]}"
	else
		error "Error: Yay is not available. Skipping installation of extra software"
	fi

	finish
}

install_npm() {

	info "Installing global npm packages..."

	packages=(
		commitizen
		npkill
		fkill-cli
		cz-conventional-changelog
	)

	echo "Installing: ${packages[*]}"

	npm install -g "${packages[@]}"

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

main() {
	on_start "$*"
	install_yay "$*"
	install_git "$*"
	install_zsh "$*"
	install_software "$*"
	install_npm "$*"
	on_finish "$*"
}

main "$*"
