#!/bin/sh

hyprctl dispatch exec "footclient -T spotify_player spotify_player"
hyprctl keyword windowrule "workspace 1 silent,Electron" && hyprctl dispatch exec "webcord"
sleep 15
hyprctl keyword windowrule "unset,Electron"
