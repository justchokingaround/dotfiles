#!/bin/sh

hyprctl dispatch exec "cool-retro-term -e ncspot"
hyprctl dispatch focuswindow "ncspot"
sleep 1
hyprctl dispatch movetoworkspace special
hyprctl dispatch togglespecialworkspace ""
