#!/bin/sh

[ -z "$*" ] && printf ">> " && read -r query || query=$*
query=$(printf "%s" "$query" | tr " " "+")

curl -sL "https://www.youtube.com/results?search_query=$query"
