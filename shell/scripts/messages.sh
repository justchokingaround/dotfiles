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

server_choice=$(curl -s -H "Authorization: $token" "${base}/users/@me/guilds"|tr "{|}" "\n"|
  sed -nE "s@\"id\": \"([0-9]*)\", \"name\": \"([^\"]*)\".*@\1\t\2@p"|nth "\$2")
[ -z "$server_choice" ] && exit 1
server_name=$(printf "%s" "$server_choice"|cut -f2)
server_id=$(printf "%s" "$server_choice"|cut -f1)

channel=$(curl -s -H "Authorization: $token" "${base}/guilds/${server_id}/channels"|tr "{|}" "\n"|
  sed -nE "s@\"id\": \"([0-9]*)\".*\"type\": 0, \"name\": \"([^\"]*)\", \"position\": ([0-9]*).*@\3) \2\t\1@p"|sort -h|cut -f2 -d' ')
channel_choice=$(printf "%s" "$channel"|nth "\$1")
[ -z "$channel_choice" ] && exit 1
channel_name=$(printf "%s" "$channel_choice"|cut -f1)
channel_id=$(printf "%s" "$channel_choice"|cut -f2)

curl -s -H "Authorization: $token" "${base}/channels/${channel_id}/messages?limit=100"|jq -r '.[] | "[\(.timestamp)] \(.author.username): \(.content)"'|
  sed -E 's@([0-9]{4})-([0-9]{2})-([0-9]{2})T([0-9]{2}):([0-9]{2}):([0-9]{2}).([0-9]{6})\+00:00@\1-\2-\3 \4:\5:\6@'|tac
