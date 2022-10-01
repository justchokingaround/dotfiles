#!/usr/bin/env bash

DIR="$HOME/.config/polybar"

pkill polybar
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# launch the bars
#polybar -q bar-launcher -c "$DIR"/config.ini &
#polybar -q bar-left -c "$DIR"/config.ini &
#polybar -q bar-middle -c "$DIR"/config.ini &
#polybar -q bar-right -c "$DIR"/config.ini &
#polybar -q bar-powermenu -c "$DIR"/config.ini &
polybar -q bar-main -c "$DIR"/config.ini &

