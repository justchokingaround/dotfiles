#!/bin/sh

launcher="tofi --require-match false --fuzzy-match true --prompt-text > "

nth() {
  stdin=$(cat)
  line=$(echo "$stdin"|awk -F '\t' "{ print NR, $1 }"|$launcher|cut -d\  -f1)
  [ -n "$line" ] && echo "$stdin"|sed "${line}q;d" || exit 1
}

get_wallpaper_previews() {
  [ -z "$query" ] && exit 1
  links=$(curl -sL "https://wall.alphacoders.com/search.php?search=${query}"|sed -nE "s@$regex@\1@p")
  [ -z "$links" ] && notify-send -t 3000 "No wallpapers found for query: ${query}" && exit 1
  printf "%s" "$links"|xargs feh -FZ --action1 ";wallpaper-helper.sh copy_to_clipboard %f" --action2 ";wallpaper-helper.sh download_wallpaper_to_custom_directory %f" \
    --action3 ";wallpaper-helper.sh set_wallpaper %f" --action4 ";wallpaper-helper.sh set_wallpaper %f --bg-fill" --action5 ";wallpaper-helper.sh set_wallpaper %f --bg-scale"
}

# regex=".*srcset=\"(https:\/\/images.*\/thumb-.*\.webp)\".*"
regex=".*src=\"(https:\/\/image.*\.(jpg|png))\".*"

while test $# -gt 0; do
  case "$1" in
    -h|--help) echo "This is the help menu" && exit 0 ;;
    -m|--medium) 
      regex=".*src=\"(https:\/\/image.*\.(jpg|png))\".*"
      if test $# -gt 1; then
        shift && query="$(printf "%s" "$*"|sed 's/ /+/g')"
      fi
      [ -z "$query" ] && query="$(echo ""|$launcher|sed 's/ /+/g')"
      get_wallpaper_previews
      break
      ;;
    *) query="$(printf "%s" "$*"|sed 's/ /+/g')" && break ;;
  esac
done

[ -z "$query" ] && query=$(echo ""|$launcher|tr ' ' '+') && get_wallpaper_previews
