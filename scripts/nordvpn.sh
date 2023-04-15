#!/bin/sh

choice=$(printf "Connect\nDisconnect\nStatus" | rofi -dmenu -i)

case $choice in
"Connect") notify-send "$(nordvpn c)" ;;
"Disconnect") notify-send "$(nordvpn d)" ;;
"Status") notify-send "$(nordvpn status)" ;;
esac
