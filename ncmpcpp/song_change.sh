#!/bin/sh

image_path="/tmp/currently-playing.jpg"
test -d "$HOME/.cache/ncmpcpp/images/" || mkdir -p "$HOME/.cache/ncmpcpp/images/"

path=$(playerctl metadata xesam:url | sed -nE "s@file://(/home/[a-z]*)(.*)@\1/music\2@p")
ffmpegthumbnailer -i "$path" -o "$image_path" -s0 2>/dev/null
title=$(playerctl metadata xesam:url | sed -nE "s@.*/(.*)\.(mp3|flac|opus|mkv|m4a)@\1@p")
# check if a file with the same name already exists
test -f "$HOME/.cache/ncmpcpp/images/""$title.jpg" || cp "$image_path" "$HOME/.cache/ncmpcpp/images/""$title.jpg"
notify-send "Now Playing" "$title" -i "$image_path" -h string:x-dunst-stack-tag:vol
