#!/bin/sh

curl -s -A "uwu" "https://gateway.reddit.com/desktopapi/v1/subreddits/unixporn"|tr "\[|\]" "\n"|sed -nE "s@.*\"media\": \{.*\"content\": \"([^\"]*)\",.*@\1@p" 
