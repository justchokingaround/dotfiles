#!/bin/sh

notify-send "The current wallpaper resolution is:" $(ffprobe -v error -select_streams v:0 -show_entries stream=width,height -of csv=s=x:p=0 $(echo '{ "command": ["get_property", "path"] }' |
	socat - /tmp/mpvpaper-socket | sed -nE "s@.*\"data\":\"(.*)\",\".*@\1@p")) -h string:x-dunst-stack-tag:mhm
