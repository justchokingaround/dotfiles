#!/bin/sh

channel_name="cote-ss-spoilers"
. "$HOME/dox/credentials/secret_envs"

grimblast save area - | curl -F "file=@-;filename=screenshot.png;type=image/png" "$COTE_SS_SPOILERS_WEBHOOK"
notify-send "Discord message" "Sent screenshot to #$channel_name"
