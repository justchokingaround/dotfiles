#!/bin/sh

query="$(printf "%s" "$*" | sed "s|^ ||;s| |%20|g")"
curl -s "https://www.pinterest.com/resource/BaseSearchResource/get/?source_url=%2Fsearch%2Fpins%2F%3Fq%3Dtyped&data=%7B%22options%22%3A%7B%22query%22%3A%22$query%22%2C%22scope%22%3A%22pins%22%2C%22filters%22%3A%22%22%7D%2C%22context%22%3A%7B%7D%7D&_=1675012790871" | tr "," "\n" | sed -nE "s@\"url\":\"(https:\/\/i\.pinimg\.com/originals.*\.jpg)\".*@\1@p"
