#!/bin/sh

hyprctl dispatch exec "wezterm start --class spotify_player spotify_player"
#hyprctl keyword windowrule "workspace 1 silent,Electron" && hyprctl dispatch exec "webcord"
hyprctl keyword windowrule "workspace 1 silent,Electron" && hyprctl dispatch exec "discord"
sleep 15
hyprctl keyword windowrule "unset,Electron"