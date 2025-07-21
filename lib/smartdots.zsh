#!/bin/zsh
# Enhanced smart directory navigation with additional features
# Quick change directories with smart dot expansion
# Original: Expands .... -> ../../../
# Enhanced: Multiple navigation patterns and safety features
#
# Author: Denys Dovhan, denysdovhan.com
# Enhanced by: BigMikeM
# License: MIT
# https://github.com/denysdovhan/dotfiles

# Configuration variables
SMARTDOTS_MAX_DEPTH=${SMARTDOTS_MAX_DEPTH:-10}
SMARTDOTS_SHOW_PATH=${SMARTDOTS_SHOW_PATH:-true}

# Core smartdots function with enhanced features
smartdots() {
	local current_buffer="$LBUFFER"
	local current_pos="$CURSOR"

	# Check if we're at the end of a dot sequence (but only for multiple dots)
	if [[ "$current_buffer" =~ \.\.+$ ]]; then
		local dots="${current_buffer##*[^.]}"
		local dot_count=${#dots}

		# Safety check: prevent excessive depth
		if [[ $dot_count -ge $SMARTDOTS_MAX_DEPTH ]]; then
			# Flash the terminal or beep to indicate limit
			echo -ne '\a'
			return
		fi

		# Add another "../" segment only for existing multi-dot sequences
		LBUFFER+="/."

		# Optional: Show current path preview
		if [[ "$SMARTDOTS_SHOW_PATH" == "true" ]] && [[ $dot_count -gt 2 ]]; then
			_show_path_preview "$dot_count"
		fi
	else
		# Regular dot insertion for single dots or first dot
		LBUFFER+="."
	fi
}

# Show path preview for navigation
_show_path_preview() {
	local depth="$1"
	local preview_path
	local current_dir="$PWD"

	# Calculate target directory
	local target_dir="$current_dir"
	for ((i = 1; i < depth; i++)); do
		target_dir="$(dirname "$target_dir")"
		if [[ "$target_dir" == "/" ]]; then
			break
		fi
	done

	# Show preview in right prompt or status line
	if [[ -n "$target_dir" && "$target_dir" != "$current_dir" ]]; then
		print -n "\r\033[K${LBUFFER} \033[90m→ ${target_dir}\033[0m"
	fi
}

# Enhanced dot expansion with smart patterns
smartdots_expand() {
	local line="$LBUFFER$RBUFFER"
	local pos="$CURSOR"

	# Pattern matching for different dot sequences
	case "$LBUFFER" in
	*...)
		# Convert ... to ../..
		LBUFFER="${LBUFFER%...}../.."
		;;
	*....)
		# Convert .... to ../../..
		LBUFFER="${LBUFFER%....}../../.."
		;;
	*.....)
		# Convert ..... to ../../../..
		LBUFFER="${LBUFFER%.....}../../../.."
		;;
	*)
		# Regular completion
		zle expand-or-complete
		;;
	esac
}

# Auto-completion for dot navigation
smartdots_complete() {
	local current="$LBUFFER"

	# If we're in a dot sequence, show directory preview
	if [[ "$current" =~ \.+/?$ ]]; then
		local dots_part="${current##*[^./]}"
		local slash_count=$(echo "$dots_part" | grep -o "/" | wc -l)
		local dot_pairs=$(((${#dots_part} - slash_count) / 2))

		if [[ $dot_pairs -gt 0 ]]; then
			local target_dir="$PWD"
			for ((i = 0; i < dot_pairs; i++)); do
				target_dir="$(dirname "$target_dir")"
				if [[ "$target_dir" == "/" ]]; then
					break
				fi
			done

			# Set completion context
			compstate[insert]="unambiguous"
			compstate[list]="list"

			# Show available directories
			if [[ -d "$target_dir" ]]; then
				local -a dirs
				dirs=("$target_dir"/*(N:t))
				if [[ ${#dirs} -gt 0 ]]; then
					compadd -d dirs -- "${dirs[@]}"
				fi
			fi
		fi
	else
		# Regular completion
		zle expand-or-complete
	fi
}

# Quick directory stack navigation
smartdots_back() {
	if [[ ${#dirstack} -gt 0 ]]; then
		popd >/dev/null
		zle reset-prompt
	else
		echo "\nDirectory stack is empty"
		zle reset-prompt
	fi
}

smartdots_forward() {
	# This would need a custom forward stack implementation
	echo "\nForward navigation not implemented"
	zle reset-prompt
}

# Show current directory stack
smartdots_stack() {
	if [[ ${#dirstack} -gt 0 ]]; then
		echo "\nDirectory Stack:"
		local i=0
		for dir in "$PWD" "${dirstack[@]}"; do
			if [[ $i -eq 0 ]]; then
				echo "  $i: $dir (current)"
			else
				echo "  $i: $dir"
			fi
			((i++))
		done
	else
		echo "\nDirectory stack is empty"
	fi
	zle reset-prompt
}

# Quick navigation to common directories
smartdots_home() {
	LBUFFER+="~/"
}

smartdots_root() {
	LBUFFER+="/"
}

smartdots_config() {
	LBUFFER+="~/.config/"
}

smartdots_dotfiles() {
	LBUFFER+="${DOTFILES:-$HOME/.dotfiles}/"
}

# Register ZLE widgets
zle -N smartdots
zle -N smartdots_expand
zle -N smartdots_complete
zle -N smartdots_back
zle -N smartdots_forward
zle -N smartdots_stack
zle -N smartdots_home
zle -N smartdots_root
zle -N smartdots_config
zle -N smartdots_dotfiles

# Key bindings
# bindkey "." smartdots  # Disabled - use regular dot behavior
bindkey "^[." smartdots_expand   # Alt+.
bindkey "^[," smartdots_back     # Alt+,
bindkey "^[/" smartdots_forward  # Alt+/
bindkey "^[s" smartdots_stack    # Alt+s
bindkey "^[h" smartdots_home     # Alt+h
bindkey "^[r" smartdots_root     # Alt+r
bindkey "^[c" smartdots_config   # Alt+c
bindkey "^[d" smartdots_dotfiles # Alt+d

# Optional: Override tab completion in dot context
if [[ "${SMARTDOTS_OVERRIDE_TAB:-false}" == "true" ]]; then
	bindkey "^I" smartdots_complete # Tab
fi

# Configuration help function
smartdots_help() {
	cat <<'EOF'
SmartDots Navigation Help:

Basic Usage:
  .     → Regular dot
  ..    → Parent directory (cd ..)
  ...   → Grandparent directory (cd ../..)
  ....  → Great-grandparent directory (cd ../../..)

Key Bindings:
  Alt+.   → Expand dots immediately
  Alt+,   → Navigate back in directory stack
  Alt+/   → Navigate forward in directory stack
  Alt+s   → Show directory stack
  Alt+h   → Insert ~/
  Alt+r   → Insert /
  Alt+c   → Insert ~/.config/
  Alt+d   → Insert $DOTFILES/

Configuration:
  SMARTDOTS_MAX_DEPTH=10     → Maximum navigation depth
  SMARTDOTS_SHOW_PATH=true   → Show path preview
  SMARTDOTS_OVERRIDE_TAB=false → Use custom tab completion

Examples:
  cd ...    → cd ../..
  ls ....   → ls ../../..
  vim .../config → vim ../../config
EOF
}

# Export configuration function
alias smartdots-help='smartdots_help'

# Auto-load directory stack from previous session (optional)
if [[ "${SMARTDOTS_PERSIST_STACK:-false}" == "true" ]]; then
	_smartdots_stack_file="${XDG_CACHE_HOME:-$HOME/.cache}/smartdots_stack"

	# Load stack on startup
	if [[ -f "$_smartdots_stack_file" ]]; then
		while IFS= read -r dir; do
			[[ -d "$dir" ]] && pushd "$dir" >/dev/null
		done <"$_smartdots_stack_file"
	fi

	# Save stack on exit
	_smartdots_save_stack() {
		print -l "${dirstack[@]}" >"$_smartdots_stack_file"
	}

	# Hook into shell exit
	add-zsh-hook zshexit _smartdots_save_stack
fi
