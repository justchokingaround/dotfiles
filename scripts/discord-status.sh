#!/bin/sh

STATUS_ONLINE="Wg4KCAoGb25saW5lGgIIAQ=="
STATUS_IDLE="WgwKBgoEaWRsZRoCCAE="
STATUS_OFFLINE="WhEKCwoJaW52aXNpYmxlGgIIAQ=="
STATUS_DND="WgsKBQoDZG5kGgIIAQ=="

# change token value
token=""
SLEEP_TIME=1

while true; do
  curl "https://discord.com/api/v9/users/@me/settings-proto/1" -X PATCH -H "authorization: $token" \
    -H "content-type: application/json"  --data-raw '{"settings":"'"$STATUS_DND"'"}'
  echo "Status set to DND"
  sleep $SLEEP_TIME
  curl "https://discord.com/api/v9/users/@me/settings-proto/1" -X PATCH -H "authorization: $token" \
    -H "content-type: application/json"  --data-raw '{"settings":"'"$STATUS_ONLINE"'"}'
  echo "Status set to ONLINE"
  sleep $SLEEP_TIME
  curl "https://discord.com/api/v9/users/@me/settings-proto/1" -X PATCH -H "authorization: $token" \
    -H "content-type: application/json"  --data-raw '{"settings":"'"$STATUS_IDLE"'"}'
  echo "Status set to IDLE"
  sleep $SLEEP_TIME
done
