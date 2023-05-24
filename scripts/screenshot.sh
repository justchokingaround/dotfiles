#!/bin/sh

cleanup() {
  rm /tmp/screenshot.png
}

screenshot_name() {
  name="$(printf "" | rofi -dmenu -l 0 -i -p "Enter a name for your screenshot:" -config ~/.config/rofi/styles/prompt.rasi)"
  [ -z "$name" ] && notify-send "Screenshot" "No name given" -i /tmp/screenshot.png && exit
  # check if a file with the same name already exists
  if [ -f "$HOME/pix/screenshots/$name.png" ]; then
    notify-send "Name already taken" "Please choose another name" -i /tmp/screenshot.png
    screenshot_name
  fi
}

trap cleanup EXIT INT TERM
case "$1" in
  fullscreen) 
    grimblast copysave output /tmp/screenshot.png
    ;;
  selectarea) 
    grimblast copysave area /tmp/screenshot.png
    ;;
  quickedit) 
    grim -g "$(slurp)" - | swappy -f - -o - > /tmp/screenshot.png
    wl-copy < /tmp/screenshot.png
    ;;
  quickcote) 
    channel_name="cote-ss-spoilers"
    . "$HOME/dox/credentials/secret_envs"
    grimblast copysave area /tmp/screenshot.png
    curl -F "file=@/tmp/screenshot.png" "$COTE_SS_SPOILERS_WEBHOOK"
    wait
    notify-send "Discord message" "Sent screenshot to #$channel_name" -i /tmp/screenshot.png
    exit 0
  ;;
save)
  grimblast save area /tmp/screenshot.png
  [ ! -f /tmp/screenshot.png ] && exit 1
  screenshot_name
  mv /tmp/screenshot.png "$HOME/pix/screenshots/$name.png"
  notify-send "Screenshot" "Saved to $HOME/pix/screenshots/$name.png" -i "$HOME/pix/screenshots/$name.png"
  exit
  ;;
  *) notify-send "Screenshot" "There was an error" ;;
esac

notify-send "Screenshot" "Copied to clipboard" -i /tmp/screenshot.png
