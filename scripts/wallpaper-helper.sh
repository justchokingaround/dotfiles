#!/bin/sh

copy_to_clipboard() {
  curl -sL "https://wall.alphacoders.com/big.php?i=$(printf "%s" "$1"|
    sed -nE "s@.*(\/|-)([0-9]*)\.(jpg|png|jpeg|webp)\$@\2@p")"|sed -nE "s@.*class=\"main-content\".*src=\"([^\"]*)\".*@\1@p"|
    wl-copy && notify-send -t 3000 "Copied wallpaper to clipboard 😎"
}

download_wallpaper_to_custom_directory() {
  notify-send -t 3000 "Downloading wallpaper to custom directory..."
  name=$(echo ""|tofi --require-match false --fuzzy-match true --prompt-text "Enter a name for this wallpaper: "|tr ' ' '_')
  [ -z "$name" ] && notify-send -t 3000 "No name entered, aborting..." && exit 1
  while [ -f "$HOME/pix/wallpapers/$name.(jpg|png|webp)" ]; do
    name=$(echo ""|tofi --require-match false --fuzzy-match true --prompt-text "Name already exists, enter new name for wallpaper: "|tr ' ' '_')
    [ -z "$name" ] && notify-send -t 3000 "No name entered, aborting..." && exit 1
  done
  image_link="$(curl -sL "https://wall.alphacoders.com/big.php?i=$(printf "%s" "$1"|
    sed -nE "s@.*(\/|-)([0-9]*)\.(jpg|png|jpeg|webp)\$@\2@p")"|sed -nE "s@.*class=\"main-content\".*src=\"([^\"]*)\".*@\1@p")"
  extension=$(printf "%s" "$image_link"|sed -nE "s@.*\.(jpg|png|jpeg|webp)@\1@p")
  [ -z "$extension" ] && notify-send -t 3000 "Could not determine extension, aborting..." && exit 1
  wget "$image_link" -O ~/pix/wallpapers/"${name}"."${extension}" &&
    notify-send -t 5000 "Downloaded wallpaper to ~/pix/wallpapers/${name}.${extension}"
}

set_wallpaper() {
  download_wallpaper_to_custom_directory "$1"
  set-wallpaper.sh "$HOME/pix/wallpapers/$name.$extension"
  notify-send -t 3000 "Set wallpaper to $HOME/pix/wallpapers/$name.$extension"
}

"$@"
