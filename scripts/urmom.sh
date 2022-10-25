#!/bin/sh

token=$(cat ~/dox/credentials/discord_token.txt)

curl -s -H "Authorization: $token" "https://discord.com/api/v9/users/@me/channels"|jq
# |tr "{|}" "\n"|sed -nE "s@\"id\": \"([0-9]*)\", \"name\": \"([^\"]*)\".*@\1\t\2@p"
# server_id=$(printf "%s" "$server"|wofi -d -i|cut -f1)
