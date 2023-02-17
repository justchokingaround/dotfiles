#!/bin/sh

[ -n "$1" ] && wallpaper_path="$1"

[ -z "$wallpaper_path" ] && wallpaper_path="$HOME/pix/wallpapers/$(ls ~/pix/wallpapers |
	while read A; do echo -en "$A\x00icon\x1f~/pix/wallpapers/$A\n"; done | rofi -dmenu -p "" -theme ~/dotfiles/rofi/styles/image-preview.rasi)"
[ -z "$wallpaper_path" ] && exit 1

monitor=$(hyprctl monitors | sed -nE "s@.*Monitor (.*) \(ID.*@\1@p" | rofi -dmenu -p "")
[ -z "$monitor" ] && exit 1
current=$(grep -E "^wallpaper = $monitor," ~/dotfiles/hypr/hyprpaper.conf | cut -d, -f2)
other=$(sed -nE "/^wallpaper = $monitor,/!s@^wallpaper = ([^,]*),(.*)@\2@p" ~/dotfiles/hypr/hyprpaper.conf)

[ "$current" = "$wallpaper_path" ] && exit 1

sed -i "s@^wallpaper = $monitor,$current\$@wallpaper = $monitor,$wallpaper_path@" ~/dotfiles/hypr/hyprpaper.conf

sed -i "/^preload =/d" ~/dotfiles/hypr/hyprpaper.conf
sed -i "1i preload = $wallpaper_path" ~/dotfiles/hypr/hyprpaper.conf
[ "$other" != "$wallpaper_path" ] && sed -i "1i preload = $other" ~/dotfiles/hypr/hyprpaper.conf

# reload the wallpaper
hyprctl dispatch exec hyprpaper
