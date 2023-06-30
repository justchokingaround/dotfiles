#!/bin/sh

base="https://flixhq.to"
provider="Vidcloud"
# provider="UpCloud"

# [ -z "$*" ] && printf "Enter a movie name: " && read -r query || query=$*
[ -z "$*" ] && query=$(rofi -dmenu -p "Enter a Movie/TV Show name:" -theme ~/dotfiles/rofi/styles/prompt.rasi)
query=$(printf "%s" "$query" | tr " " "-")
[ -z "$query" ] && exit 1

launcher() {
	rofi -dmenu -i -width 1500 -p "$1"
}

nth() {
	stdin=$(cat)
	[ -z "$stdin" ] && return 1
	[ "$(echo "$stdin" | wc -l)" -eq 1 ] && echo "$stdin" && return 0
	line=$(echo "$stdin" | awk -F '\t' "{ print NR, $1 }" | launcher "" | cut -d\  -f1)
	[ -n "$line" ] && echo "$stdin" | sed "${line}q;d" || exit 1
}

# request to get search results
movies_results=$(curl -s "${base}/search/${query}" |
	sed -nE '/class="film-name"/ {n; s/.*href="(.*)".*/\1/p;n; s/.*title="(.*)".*/\1/p;d;}' |
	sed -e 'N;s/\n/\{/' -e "s/&#39;/'/g")
movies_choice=$(printf "%s" "$movies_results" | sed -nE 's_/(.*)/(.*)\{(.*)_\2\t\3 (\1)_p' |
	nth "\$2")

movie_id=$(printf "%s" "$movies_choice" | sed -nE 's_watch-.*-([0-9]*).*_\1_p')
movie_title="$(printf "%s" "${movies_choice}" | cut -f2- | sed -nE "s_(.*) \(.*\)_\1_p")"
# media_type=$(printf "%s" "$movies_choice" | cut -f2- | sed -nE "s_.* \((.*)\)_\1_p")

notify-send "Getting links for ${movie_title}..." -t 1000

# request to get the episode id
movie_page="$base"$(curl -s "${base}/ajax/movie/episodes/${movie_id}" |
	tr -d "\n" | sed -nE "s_.*href=\"([^\"]*)\".*$provider.*_\1_p")
episode_id=$(printf "%s" "$movie_page" | sed -nE "s_.*-([0-9]*)\.([0-9]*)\$_\2_p")

# request to get the embed
embed_link=$(curl -s "https://flixhq.to/ajax/sources/${episode_id}" | sed -nE "s_.*\"link\":\"([^\"]*)\".*_\1_p")

# get the juicy links
parse_embed=$(printf "%s" "$embed_link" | sed -nE "s_(.*)/embed-(4|6)/(.*)\?z=\$_\1\t\2\t\3_p")
provider_link=$(printf "%s" "$parse_embed" | cut -f1)
source_id=$(printf "%s" "$parse_embed" | cut -f3)
embed_type=$(printf "%s" "$parse_embed" | cut -f2)

key="$(curl -s "https://github.com/enimax-anime/key/blob/e${embed_type}/key.txt" | sed -nE "s_.*js-file-line\">(.*)<.*_\1_p")"
json_data=$(curl -s "${provider_link}/ajax/embed-${embed_type}/getSources?id=${source_id}" -H "X-Requested-With: XMLHttpRequest")

notify-send "Playing $movie_title..." -t 2000

# decrypt the video link
source_link=$(printf "%s" "$json_data" | sed -nE "s_.*\"sources\":\"([^\"]*)\".*_\1_p")
# if source_link ends with .m3u8, then there is no need to decrypt
# at around :35-36 every hour, the links aren't encrypted
if [ "${source_link##*.}" = "m3u8" ]; then
	video_link="$source_link"
else
	video_link=$(printf "%s" "$source_link" | base64 -d |
		openssl enc -aes-256-cbc -d -md md5 -k "$key" 2>/dev/null | sed -nE "s_.*\"file\":\"([^\"]*)\".*_\1_p")
fi
subs_link=$(printf "%s" "$json_data" | tr "{|}" "\n" | sed -nE "s_\"file\":\"(.*\.vtt)\",\"label\":\"English.*_\1_p" | head -1)
[ -z "$subs_link" ] && subs_link=$(printf "%s" "$json_data" | tr "{|}" "\n" | sed -nE "s_\"file\":\"(.*\.vtt)\".*_\1_p" | head -1)

# play the video
if [ -n "$subs_link" ]; then
	mpv --sub-file="$subs_link" "$video_link" --force-media-title="$movie_title"
else
	mpv "$video_link" --force-media-title="$movie_title"
fi
