#!/bin/bash

# Function to convert a base16 color to putty color
convert_color() {
	local base16_color=$1
	local r=$(echo "$base16_color" | cut -c 1-2)
	local g=$(echo "$base16_color" | cut -c 3-4)
	local b=$(echo "$base16_color" | cut -c 5-6)

	local r_dec=$((16#$r))
	local g_dec=$((16#$g))
	local b_dec=$((16#$b))

	local r_putty=$((r_dec * 65535 / 255))
	local g_putty=$((g_dec * 65535 / 255))
	local b_putty=$((b_dec * 65535 / 255))

	echo "$r_putty,$g_putty,$b_putty"
}

# Read the input file and extract base16 colors
base16_colors=("$(awk '/base[0-9A-Fa-f]+:/ {print $2}' input_file)")

# Convert base16 colors to putty colors
putty_colors=()
for color in "${base16_colors[@]}"; do
	putty_colors+=("$(convert_color "$color")")
done

# Print putty color scheme
for ((i = 0; i < ${#putty_colors[@]}; i++)); do
	echo "Color$i=${putty_colors[$i]}"
done
