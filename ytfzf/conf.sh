#!/bin/sh

external_menu () {
   rofi -dmenu -width 1500 -p "$1"
}

ytdl_pref="bestvideo[height<=?1080][fps<=?60]+bestaudio/best"
notify_playing=1
