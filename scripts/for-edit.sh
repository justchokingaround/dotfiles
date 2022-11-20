#!/bin/sh

token=$(cat ~/dox/credentials/discord_token.txt)
launcher="tofi --require-match false --fuzzy-match true --prompt-text > "
# launcher="fzf"
base="https://discord.com/api/v10"

nth() {
  stdin=$(cat)
  line=$(echo "$stdin"|awk -F '\t' "{ print NR, $1 }"|$launcher|cut -d\  -f1)
  [ -n "$line" ] && echo "$stdin"|sed "${line}q;d" || exit 1
}

server_id="871752090467315772"

channel=$(curl -s -H "Authorization: $token" "${base}/guilds/${server_id}/channels"|tr "{|}" "\n"|
  sed -nE "s@\"id\": \"([0-9]*)\".*\"type\": 0, \"name\": \"([^\"]*)\", \"position\": ([0-9]*).*@\3) \2\t\1@p"|sort -h|cut -f2 -d' ')
channel_choice=$(printf "%s" "$channel"|nth "\$1")
[ -z "$channel_choice" ] && exit 1
channel_name=$(printf "%s" "$channel_choice"|cut -f1)
channel_id=$(printf "%s" "$channel_choice"|cut -f2)
content=$(wl-paste)
[ -z "$content" ] && exit 1 && notify-send "No content to send"

curl -H "Authorization: $token" -F 'payload_json={"content":"'"${content}"'"}' "${base}/channels/$channel_id/messages"
notify-send "Discord message" "\"$content\" has been sent to \#$channel_name in $server_name"
