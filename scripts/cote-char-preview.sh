#!/bin/sh

img_link="$(curl -s "https://you-zitsu.fandom.com$(curl -s "https://you-zitsu.fandom.com/wiki/Category:Characters" | sed -nE "s@.*href=\"(/wiki/[^\":]*)\".*title=\"([^\"]*)\".*@\2\t\1@p" | rofi -dmenu -i -mesg "Select a character" -display-columns 1 | cut -f2)" | sed -nE "s@.*img src=\"([^\"]*)\".*class=\"pi-image-thumbnail\".*@\1@p" | head -1)"

[ -z "$img_link" ] && exit 1
curl -s "$img_link" | imv -
