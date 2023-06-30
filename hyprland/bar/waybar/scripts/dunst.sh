#!/bin/sh
# Report do-not-disturb status.
# Based on https://github.com/Alexays/Waybar/wiki/Module:-Custom.

count=$(dunstctl count waiting)
enabled=""
disabled=""
if [ "$count" != 0 ]; then
	disabled="$disabled $count"
fi
if dunstctl is-paused | grep -q "false"; then
	text="$enabled"
	alt='Do Not Disturb disabled'
	class='active'
else
	text="$disabled"
	alt='Do Not Disturb enabled'
	class='alert'
fi

printf '{"text": "%s", "alt": "%s", "tooltip": "%s", "class": "%s"}' \
	"$text" "$alt" "$alt" "$class"
