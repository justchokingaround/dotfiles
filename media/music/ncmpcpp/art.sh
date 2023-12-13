#!/bin/sh
set -e

# change this value to your desired width
size_x=50
size_y=9

while true; do
    title=$(playerctl metadata xesam:url 2>/dev/null | sed -nE "s@.*/(.*)\.(mp3|flac|opus|mkv|m4a)@\1@p")
    if [ -n "$title" ]; then
        song_path="$HOME/.cache/ncmpcpp/images/""$title.jpg"
        if [ "$oldpath" != "$song_path" ]; then
            zellij action move-focus left
            zellij action move-focus up
            zellij action page-scroll-down
            zellij action clear

            chafa -f sixel -s ${size_x}x${size_y} "$song_path" 2>/dev/null || echo "chafa failed"
            # chafa -f symbols -s ${size_x}x${size_y} "$song_path"

            zellij action page-scroll-up
            zellij action move-focus right
        fi
        oldpath=$song_path
        sleep 1
    fi
done
