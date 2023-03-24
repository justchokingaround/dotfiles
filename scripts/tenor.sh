#!/bin/sh

clipboard="wl-copy"
images_cache_dir="/tmp/tenor-images"
image_config_path="$HOME/.config/rofi/styles/image-preview.rasi"
test -d "${images_cache_dir}" || mkdir "${images_cache_dir}"
cleanup() {
	rm -rf ${images_cache_dir} && exit
}
trap cleanup EXIT INT TERM

query=$(printf "" | rofi -dmenu -l 0 -i -p "" -mesg "Search a gif: " | tr ' ' '-')
[ -z "$query" ] && exit
image_links=$(curl -s "https://tenor.com/search/${query}-gifs" | tr '>' '\n' | sed -nE "s@.*<img src=\"(https[^\"]*\.gif)\".*@\1@p")

notify-send "Downloading images" -h string:x-dunst-stack-tag:tes
IFS='	'
printf "%s\n" "$image_links" | sed -nE "s@(.*)/(.*)\.gif@\1\t\2@p" | while read -r link title; do
	curl -s -o "$images_cache_dir/$title.gif" "$link/$title.gif" &
done
wait && sleep 2

notify-send "Converting images" -h string:x-dunst-stack-tag:tes
for image in "${images_cache_dir}"/*.gif; do
	filename="${image%.*}"
	convert "$image"[0] "${filename}.jpg" &
done
wait && sleep 1

choice=$(printf "%s\n" "$image_links" | sed -nE "s@(.*)/(.*)\.gif@\1\t\2@p" | while read -r link title; do
	printf "%s\t%s \x00icon\x1f%s/%s.jpg\n" "$link/$title.jpg" "$title" "$images_cache_dir" "$title"
done | rofi -dmenu -i -p "" -theme "$image_config_path" -mesg "Select anime" -display-columns 2.. |
	cut -f1 | sed -E 's@(.*)\.jpg@\1\.gif@')

printf "%s" "$choice" | $clipboard
title=$(printf "%s" "$choice" | sed -nE "s@.*\/(.*)\.gif@\1@p")
notify-send "Gif copied to clipboard" -i "$images_cache_dir/$title.jpg"
