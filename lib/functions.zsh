# _exists() {
# 	command -v "$1" >/dev/null 2>&1
# }

# # Search pacman automatically for unknown commands
# function command_not_found_handler {
#     if ! _exists pacman; then
#       return
#     fi

#     local purple='\e[1;35m' bright='\e[0;1m' green='\e[1;32m' reset='\e[0m'
#     printf 'zsh: command not found: %s\n' "$1"
#     local entries=(
#         ${(f)"$(/usr/bin/pacman -F --machinereadable -- "/usr/bin/$1")"}
#     )
#     if (( ${#entries[@]} ))
#     then
#         printf "${bright}$1${reset} may be found in the following packages:\n"
#         local pkg
#         for entry in "${entries[@]}"
#         do
#             # (repo package version file)
#             local fields=(
#                 ${(0)entry}
#             )
#             if [[ "$pkg" != "${fields[2]}" ]]
#             then
#                 printf "${purple}%s/${bright}%s ${green}%s${reset}\n" "${fields[1]}" "${fields[2]}" "${fields[3]}"
#             fi
#             printf '    /%s\n' "${fields[4]}"
#             pkg="${fields[2]}"
#         done
#     fi
#     return 127
# }

# n() {

#   if ! _exists nnn; then
#     return
#   fi

# 	# Block nesting of nnn in subshells
# 	if [[ "${NNNLVL:-0}" -ge 1 ]]; then
# 		echo "nnn is already running"
# 		return
# 	fi

# 	# The behaviour is set to cd on quit (nnn checks if NNN_TMPFILE is set)
# 	# If NNN_TMPFILE is set to a custom path, it must be exported for nnn to
# 	# see. To cd on quit only on ^G, remove the "export" and make sure not to
# 	# use a custom path, i.e. set NNN_TMPFILE *exactly* as follows:
# 	#     NNN_TMPFILE="${XDG_CONFIG_HOME:-$HOME/.config}/nnn/.lastd"
# 	export NNN_TMPFILE="${XDG_CONFIG_HOME:-$HOME/.config}/nnn/.lastd"

# 	# Unmask ^Q (, ^V etc.) (if required, see `stty -a`) to Quit nnn
# 	# stty start undef
# 	# stty stop undef
# 	# stty lwrap undef
# 	# stty lnext undef

# 	# The backslash allows one to alias n to nnn if desired without making an
# 	# infinitely recursive alias
# 	\nnn "$@"

# 	if [ -f "$NNN_TMPFILE" ]; then
# 		. "$NNN_TMPFILE"
# 		rm -f "$NNN_TMPFILE" >/dev/null
# 	fi
# }
