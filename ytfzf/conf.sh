#!/bin/sh

external_menu () {
   rofi -dmenu -i -width 1500 -p "$1"
   # tofi --require-match false --fuzzy-match true --prompt-text "$1"
}

ytdl_pref="bestvideo[height<=?1080][fps<=?60]+bestaudio/best"
notify_playing=1
