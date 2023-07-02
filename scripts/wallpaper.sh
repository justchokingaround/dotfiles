#!/bin/sh

website_base="www.wallpaperflare.com"
image_config_path="$HOME/.config/rofi/styles/launcher.rasi"

images_cache_dir="/tmp/wallpapers"
test -d "$images_cache_dir" || mkdir "$images_cache_dir"
test -d "$HOME/.local/share/applications/wallpapers" || mkdir "$HOME/.local/share/applications/wallpapers"

[ -z "$*" ] && query=$(printf "" | rofi -dmenu -l 0 -i -p "" -mesg "Search for a wallpaper:" -theme "$HOME/.config/rofi/styles/prompt.rasi" | tr ' ' '+') ||
    query=$(printf "%s" "$*" | tr ' ' '+')
[ -z "$query" ] && exit 1

cleanup() {
    rm -rf "$images_cache_dir"
    rm -rf "$HOME/.local/share/applications/wallpapers/"
}
trap cleanup EXIT INT TERM

generate_desktop() {
    cat <<EOF
[Desktop Entry]
Name=$1
Exec=echo %c
Icon=$2
Type=Application
Categories=wallpapers;
EOF
}

wallpapers_list=$(curl -s "https://www.wallpaperflare.com/search?wallpaper=${query}" |
    sed ':a;N;$!ba;s/\n//g;s/<a/\n/g' | sed -nE "s@.*href=\".*/([^\"]*)\".*data-src=\"([^\"]*)\".*@\2\t\1@p")

printf "%s\n" "$wallpapers_list" | while read -r cover_url media_id; do
    curl -s -o "$images_cache_dir/$media_id.jpg" "$cover_url" &
    wait
    entry="$HOME/.local/share/applications/wallpapers/$media_id.desktop"
    generate_desktop "$media_id" "$images_cache_dir/$media_id.jpg" >"$entry" &
done

choice_id=$(rofi -show drun -drun-categories wallpapers -show-icons -theme "$image_config_path")

image_link=$(curl -s "https://${website_base}/${choice_id}/download/" | sed -nE "s@.*show_img\" src=\"(.*)\".*@\1@p")
curl -s "$image_link" -o "$HOME/dotfiles/pictures/wallpapers/wallpaper.jpg"
(cd ~/pix/wallpapers && curl -O "$image_link")

swww img "$HOME/dotfiles/pictures/wallpapers/wallpaper.jpg" --transition-type random --transition-step 5 --transition-fps 165
