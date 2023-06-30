#!/bin/sh

token=$(cat ~/dox/credentials/discord_token.txt)
launcher="rofi -dmenu -i -p"
base="https://discord.com/api/v10"

nth() {
	stdin=$(cat)
	line=$(echo "$stdin" | awk -F '\t' "{ print NR, $1 }" | $launcher | cut -d\  -f1)
	[ -n "$line" ] && echo "$stdin" | sed "${line}q;d" || exit 1
}

server_choice=$(curl -s -H "Authorization: $token" "${base}/users/@me/guilds" | tr "{|}" "\n" |
	sed -nE "s@\"id\": \"([0-9]*)\", \"name\": \"([^\"]*)\".*@\1\t\2@p" | nth "\$2")
[ -z "$server_choice" ] && exit 1
server_name=$(printf "%s" "$server_choice" | cut -f2)
server_id=$(printf "%s" "$server_choice" | cut -f1)

channel=$(curl -s -H "Authorization: $token" "${base}/guilds/${server_id}/channels" | tr "{|}" "\n" |
	sed -nE "s@\"id\": \"([0-9]*)\".*\"type\": 0, \"name\": \"([^\"]*)\", \"position\": ([0-9]*).*@\3) \2\t\1@p" | sort -h | cut -f2 -d' ')
channel_choice=$(printf "%s" "$channel" | nth "\$1")
[ -z "$channel_choice" ] && exit 1
channel_name=$(printf "%s" "$channel_choice" | cut -f1)
channel_id=$(printf "%s" "$channel_choice" | cut -f2)

grimblast save area - | curl -H "Authorization: $token" -F "file=@-;filename=screenshot.png;type=image/png" "$base/channels/$channel_id/messages"

notify-send "Discord message" "Screenshot has been sent to \#$channel_name in $server_name"
