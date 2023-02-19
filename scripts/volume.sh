#!/bin/sh

vol_int=$(pamixer --get-volume)
vol_icon="low"
[ "$vol_int" -gt 33 ] && vol_icon="medium"
[ "$vol_int" -gt 66 ] && vol_icon="high"
pamixer --get-mute | sh && vol_icon="muted"
notify-send -i "/usr/share/icons/Papirus/16x16/panel/audio-volume-$vol_icon.svg" "$vol_int %" -t 1000 -h string:x-dunst-stack-tag:vol
canberra-gtk-play -i audio-volume-change -d "changevolume"
