#!/bin/sh

wl-copy "$1"

case "$1" in
  *youtu*) 
    title_and_thumbnail=$(curl -sL "$1" | sed -nE "s@.*meta name=\"title\" content=\"([^\"]*)\".*\"thumbnail\":\{\"thumbnails\":\[\{\"url\":\"([^\"]*)\".*@\2\t\1@p")
    title=$(printf "%s" "$title_and_thumbnail" | cut -f2-)
    thumbnail=$(printf "%s" "$title_and_thumbnail" | cut -f1)
    curl -s "$thumbnail" -o /tmp/youtube-thumbnail.png
    notify-send "Copied to clipboard" "$title" -i /tmp/youtube-thumbnail.png
    ;;
  *) 
    title="$1"
    notify-send "Copied to clipboard" "$title"
    ;;
esac

