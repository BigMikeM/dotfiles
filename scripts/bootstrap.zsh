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
HOMEBREW_INSTALLER_URL="https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh"

on_start() {
	info "           __        __   ____ _  __           "
	info "      ____/ /____   / /_ / __/(_)/ /___   _____"
	info "     / __  // __ \ / __// /_ / // // _ \ / ___/"
	info "  _ / /_/ // /_/ // /_ / __// // //  __/(__  ) "
	info " (_)\__,_/ \____/ \__//_/  /_//_/ \___//____/  "
	info "                                               "
	info "           created by @denysdovhan             "
	info "             edited by @bigmikem               "
	info "                                               "

	info "This script will guide you through installing git, zsh and dofiles itself."
	echo "It will not install anything without your direct agreement!"
	echo
	read -p "Do you want to proceed with installation? [y/N] " -n 1 answer
	echo
	if [ "${answer}" != "y" ]; then
		exit 1
	fi
}

install_homebrew() {

	if _exists pacman; then
		return
	fi

	info "Trying to detect installed Homebrew..."

	if ! _exists brew; then
		echo "Seems like you don't have Homebrew installed!"
		read -p "Do you agree to proceed with Homebrew installation? [y/N] " -n 1 answer
		echo
		if [ "${answer}" != "y" ]; then
			exit 1
		fi

		info "Installing Homebrew..."
		bash -c "$(curl -fsSL ${HOMEBREW_INSTALLER_URL})"
	else
		success "You already have Homebrew installed. Skipping..."
	fi

	finish
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
	pacman -S --needed git base-devel
	git clone https://aur.archlinux.org/yay.git
	cd yay
	makepkg -si
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

		if _exists apt; then
			sudo apt install git
		elif _exists yay; then
			yay -S git
		elif _exists pacman; then
			sudo pacman -S git
		elif _exists brew; then
			brew install git
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

		if _exists apt; then
			sudo apt install zsh
		elif _exists yay; then
			yay -S zsh
		elif _exists pacman; then
			sudo pacman -S zsh
		elif _exists brew; then
			brew install zsh zsh-completions
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

		chsh -s "$(command -v zsh)" || error "Error: Cannot set Zsh as default shell!"
	fi

	finish
}

install_citrix() {

	if _exists yay; then
		return
	fi

	# TODO: choose/make dir to work in
	build_dir="$DOTFILES/build"
	mkdir -p -m755 $build_dir

	url='https://www.citrix.com/downloads/workspace-app/linux/workspace-app-for-linux-latest.html'
	_dl_urls_="$(curl -sL "$url" | grep -F ".tar.gz?__gda__")"
	_dl_urls="$(echo "$_dl_urls_" | grep -F "$pkgver.tar.gz?__gda__")"
	_source64=https:"$(echo "$_dl_urls" | sed -En 's|^.*rel="(//.*/linuxx64-[^"]*)".*$|\1|p')"
	source=('citrix-configmgr.desktop'
		'citrix-conncenter.desktop'
		'citrix-wfica.desktop'
		'citrix-workspace.desktop'
		'wfica.sh'
		'wfica_assoc.sh')
	source_x86_64=("$pkgname-x64-$pkgver.tar.gz::$_source64")

	ICAROOT=/opt/Citrix/ICAClient

	wget "$url"

	sha256sum

	rm -rf $build_dir
}

install_software() {

	info "Installing software..."

	cd "$DOTFILES"

	# Homebrew Bundle
	if _exists brew; then
		brew bundle
	elif _exists yay; then
		software=(
			sheldon
			tree
			lsd
			bat
			tldr
			github-cli
			nnn
			lazygit
			trash-cli
			icaclient
			ranger
		)

		echo "Installing: ${packages[*]}"

		yay -S "${software[@]}"
	else
		error "Error: Brew or Yay is not available. Skipping installation of extra software"
	fi

	cd -

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
	echo
	echo -ne "$RED"'-_-_-_-_-_-_-_-_-_-_-_-_-_-_'
	echo -e "$RESET""$BOLD"',------,'"$RESET"
	echo -ne "$YELLOW"'-_-_-_-_-_-_-_-_-_-_-_-_-_-_'
	echo -e "$RESET""$BOLD"'|   /\_/\\'"$RESET"
	echo -ne "$GREEN"'-_-_-_-_-_-_-_-_-_-_-_-_-_-'
	echo -e "$RESET""$BOLD"'~|__( ^ .^)'"$RESET"
	echo -ne "$CYAN"'-_-_-_-_-_-_-_-_-_-_-_-_-_-_'
	echo -e "$RESET""$BOLD"'""  ""'"$RESET"
	echo
	info "Don't forget to restart your terminal!"
	echo
}

on_error() {
	echo
	error "Wow... Something serious happened!"
	error "Though, I don't really know what :("
	error "If you would like to help me fix this problem, raise an issue here -> ${CYAN}${GITHUB_REPO_URL_BASE}issues/new${RESET}"
	echo
	exit 1
}

main() {
	on_start "$*"
	install_homebrew "$*"
	install_yay "$*"
	install_git "$*"
	install_zsh "$*"
	install_software "$*"
	install_npm "$*"
	on_finish "$*"
}

main "$*"
