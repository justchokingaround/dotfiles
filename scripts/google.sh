#!/bin/sh

search_engine="yandex"
[ -n "$*" ] && query=$(printf "%s" "$*" | tr ' ' '+') ||
    query=$(printf "" | rofi -dmenu -l 0 -i -mesg "Enter your query" -theme "$HOME/.config/rofi/styles/prompt.rasi" | tr ' ' '+')
[ -z "$query" ] && exit 1

data=$(curl -s "http:/127.0.0.1:7000/${search_engine}/search?lang=EN&limit=20&text=${query}" | jq -r '.[] | [.title, .url] | @tsv')
wait
[ -z "$data" ] && exit 1

url=$(printf "%s" "$data" | rofi -dmenu -display-column 1 | cut -f2)
wait
[ -z "$url" ] && exit 1

$BROWSER "$url"
