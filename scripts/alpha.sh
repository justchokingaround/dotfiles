#!/bin/sh

website_base="wall.alphacoders.com"
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
Exec=echo %k
Icon=$2
Type=Application
Categories=wallpapers;
EOF
}

# thx @Based-Programmer for teaching me how to bypass cloudflare
wallpapers_list=$(curl -sL --tls13-ciphers TLS_AES_128_GCM_SHA256 --tlsv1.3 -A "uwu" "https://${website_base}/search.php?search=${query}" |
    sed ':a;N;$!ba;s/\n//g;s/thumb-container/\n/g' | sed -nE "s@.*a href=\"/big.php\?i=([0-9]*)\".*srcset=\"([^\"]*)\".*height=\"[0-9]*\"[[:space:]]*src=\"([^\"]*\.[jpneg]{3,4})\".*@\2\t\1\t\3@p")
[ -z "$wallpapers_list" ] && exit 1

printf "%s\n" "$wallpapers_list" | while read -r cover_url media_id real_url; do
    link=$(printf "%s" "$real_url" | sed "s@/@=@g;s@\.@_@g" | sed -nE "s@.*==(.*)_([jpneg]{3,4})@\1\t\2@p")
    curl -s -o "$images_cache_dir/$link.webp" "$cover_url" &
    entry="$HOME/.local/share/applications/wallpapers/$link.desktop"
    generate_desktop "$media_id" "$images_cache_dir/$link.jpg" >"$entry" &
done
wait && sleep 1

# convert all webp to jpg
for image in "${images_cache_dir}"/*.webp; do
    filename="${image%.*}"
    convert "$image"[0] "${filename}.jpg" &
done
wait && sleep 1

choice=$(rofi -show drun -drun-categories wallpapers -show-icons -theme "$image_config_path" | sed -nE "s@.*/(.*)\.desktop@\1@p")
extension=$(printf "%s" "$choice" | cut -f2)
image_path=$(printf "%s" "$choice" | cut -f1 | sed "s@=@/@g;s@_@\.@g")
image_link=$(printf "https://%s.%s" "$image_path" "$extension")

curl -s "$image_link" -o "$HOME/dotfiles/pictures/wallpapers/wallpaper.jpg"
(cd ~/pix/wallpapers && curl -O "$image_link")

swww img "$HOME/dotfiles/pictures/wallpapers/wallpaper.jpg" --transition-type random --transition-step 5 --transition-fps 165
