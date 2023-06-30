#!/bin/sh

link=$(wl-paste)

cleanup() {
    rm /tmp/yt-dlp-thumbnail.*
}
trap cleanup EXIT

title="$(yt-dlp --get-title "$link")"
[ -z "$title" ] && exit 1
notify-send "Getting thumbnail..." -h string:x-dunst-stack-tag:vol
yt-dlp --write-thumbnail --convert-thumbnails jpg --output "/tmp/yt-dlp-thumbnail" "$link"
notify-send "Downloading" "$title" -i "/tmp/yt-dlp-thumbnail.jpg" -h string:x-dunst-stack-tag:vol
yt-dlp --extract-audio --audio-format mp3 --embed-thumbnail --output "$HOME/music/current/%(title)s.%(ext)s" "$(wl-paste)"
notify-send "Finished downloading" "$title" -i "/tmp/yt-dlp-thumbnail.jpg" -h string:x-dunst-stack-tag:vol
