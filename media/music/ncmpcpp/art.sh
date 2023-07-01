#!/bin/sh
set -e

# change this value to your desired width
width=550

while true; do
    title=$(playerctl metadata xesam:url 2>/dev/null | sed -nE "s@.*/(.*)\.(mp3|flac|opus|mkv|m4a)@\1@p")
    if [ -n "$title" ]; then
        song_path="$HOME/.cache/ncmpcpp/images/""$title.jpg"
        if [ "$oldpath" != "$song_path" ]; then
            zellij action move-focus right
            zellij action move-focus up
            zellij action page-scroll-down
            tput clear
            img2sixel -w "$width" "$song_path"
            zellij action page-scroll-up
            zellij action move-focus down
        fi
        oldpath=$song_path
        sleep 2
    fi
done
