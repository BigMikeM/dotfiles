#!/usr/bin/bash
if grep -q open /proc/acpi/button/lid/LID0/state; then
    swaymsg output 'e-DP1' enable
else
    swaymsg output 'e-DP1' disable
fi
