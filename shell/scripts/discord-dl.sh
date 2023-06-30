#!/bin/sh

token=$(cat ~/dox/credentials/discord_token.txt)
# launcher="tofi --require-match false --fuzzy-match true --prompt-text > "
launcher="rofi -dmenu -i -p"
base="https://discord.com/api/v10"
limit="100"

nth() {
	stdin=$(cat)
	line=$(echo "$stdin" | awk -F '\t' "{ print NR, $1 }" | $launcher | cut -d\  -f1)
	[ -n "$line" ] && echo "$stdin" | sed "${line}q;d" || exit 1
}

server_choice=$(curl -s -A "uwu" -H "Authorization: $token" "${base}/users/@me/guilds" | tr "{|}" "\n" |
	sed -nE "s@\"id\": \"([0-9]*)\", \"name\": \"([^\"]*)\".*@\1\t\2@p" | nth "\$2")
[ -z "$server_choice" ] && exit 1
server_name=$(printf "%s" "$server_choice" | cut -f2)
server_id=$(printf "%s" "$server_choice" | cut -f1)

channel=$(curl -s -A "uwu" -H "Authorization: $token" "${base}/guilds/${server_id}/channels" | tr "{|}" "\n" |
	sed -nE "s@\"id\": \"([0-9]*)\".*\"type\": 0, \"name\": \"([^\"]*)\", \"position\": ([0-9]*).*@\3) \2\t\1@p" | sort -h | cut -f2 -d' ')
channel_choice=$(printf "%s" "$channel" | nth "\$1")
[ -z "$channel_choice" ] && exit 1
channel_name=$(printf "%s" "$channel_choice" | cut -f1)
channel_id=$(printf "%s" "$channel_choice" | cut -f2)

# channel_id="876503735096975404"

messages=$(curl -s "${base}/channels/${channel_id}/messages?limit=${limit}" -H "Authorization: $token")
last_id=$(printf "%s" "$messages" | sed -nE "s@.*\"id\": \"([0-9]*)\", \"type\".*@\1@p")
printf "%s" "$messages" | tr "\[|\]" "\n" |
	sed -nE "s@.*\"url\": \"((https://cdn.discordapp.com/attachments/[0-9]*/[0-9]*/[a-z0-9]*\.(mp4|webm))|(https://www.youtube.com/watch\?v=[a-zA-Z0-9_-]*))\".*@\1@p"

while [ -n "$last_id" ]; do
	messages=$(curl -s -A "uwu" "${base}/channels/${channel_id}/messages?limit=${limit}&before=${last_id}" -H "Authorization: $token")
	last_id=$(printf "%s" "$messages" | sed -nE "s@.*\"id\": \"([0-9]*)\", \"type\".*@\1@p")
	printf "%s" "$messages" | tr "\[|\]" "\n" |
		sed -nE "s@.*\"url\": \"((https://cdn.discordapp.com/attachments/[0-9]*/[0-9]*/[a-z0-9]*\.(mp4|webm))|(https://www.youtube.com/watch\?v=[a-zA-Z0-9_-]*))\".*@\1@p"
done
