#!/bin/sh

hyprctl dispatch focusmonitor 0
hyprctl dispatch exec "wezterm start --class music zellij --layout ~/.config/ncmpcpp/music &"
#hyprctl keyword windowrule "workspace 1 silent,Electron" && hyprctl dispatch exec "webcord"
hyprctl keyword windowrule "workspace 2,$BROWSER" && hyprctl dispatch exec "$BROWSER"
hyprctl dispatch exec "discord"
wait
hyprctl dispatch focusmonitor 0
# hyprctl dispatch exec "cool-retro-term -T iamb -e iamb"
# hyprctl dispatch exec "cool-retro-term -T discordo -e discordo --token ~/dox/credentials/discord_token.txt"
