#!/bin/sh

test -d "$HOME/.local/share/applications/wallpapers" || mkdir "$HOME/.local/share/applications/wallpapers"

cleanup() {
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

wallpapers=$(find ~/pix/wallpapers/ -type f -name '*.jpg' -o -name '*.png')

printf "%s\n" "$wallpapers" | while read -r line; do
    name=$(basename "$line" | cut -d. -f1)
    extension=$(basename "$line" | cut -d. -f2)
    entry="$HOME/.local/share/applications/wallpapers/$name.desktop"
    generate_desktop "$name ($extension)" "$HOME/pix/wallpapers/$name.$extension" >"$entry" &
done

choice=$(rofi -show drun -drun-categories wallpapers -show-icons -theme "$HOME/.config/rofi/styles/launcher.rasi" | sed -nE "s@(.*)[[:space:]]\((.*)\)@\1.\2@p")
cp "$HOME/pix/wallpapers/$choice" "$HOME/dotfiles/pictures/wallpapers/wallpaper.jpg"

swww img "$HOME/pix/wallpapers/$choice" --transition-type simple --transition-step 5
