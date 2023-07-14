#!/bin/sh

# cleanup() {
#     rm -f /tmp/youtube-thumbnail.png
#     rm -f /tmp/youtube-channel-thumbnail.png
# }
# trap cleanup INT TERM EXIT

input=$1

if [ -z "$input" ]; then
    clipboard_choice=$(printf "Yes\nNo" | rofi -dmenu -mesg "Use clipboard content?")
    case "$clipboard_choice" in
        "Yes") input=$(wl-paste) ;;
        *) exit 0 ;;
    esac
fi

youtube_regex='http(s?)://(www\.)?youtu(be\.com/watch\?v=|\.be/)([\w\-_]*)((&(amp;)?[\w\?=]*))?'

# TODO:: prompt for path
download_path="$HOME/videos/youtube/%(title)s-%(id)s.%(ext)s"

choice=$(printf "Copy to clipboard\nDownload video\nDownload audio\nPlay video\nPlay audio\nView channel (youtube only)\nOpen in a browser" | rofi -dmenu -mesg "Choose an action" -i)

parse_link() {
    if printf "%s" "$input" | grep -qE "$youtube_regex"; then
        youtube "$input" "$1"
    else
        notify-send "Other"
    fi
}

progress_notification() {
    while :; do
        progress=$(sed -nE "s@.*[[:space:]]([0-9]*\.[0-9]*\%).*@\1@p" /tmp/yt-dlp-progress.txt | tail -1)
        [ "$progress" = "100.0%" ] && break
        notify-send "Download progress" -i /tmp/youtube-thumbnail.png "$progress" -h string:x-canonical-private-synchronous:progress
    done
}

youtube() {
    # TODO: playlists
    response=$(curl -sL "$1")
    title_and_thumbnail=$(printf "%s" "$response" | sed -nE "s@.*meta name=\"title\" content=\"([^\"]*)\".*\"thumbnail\":\{\"thumbnails\":\[\{\"url\":\"([^\"]*)\".*@\2\t\1@p")
    title=$(printf "%s" "$title_and_thumbnail" | cut -f2-)
    thumbnail=$(printf "%s" "$title_and_thumbnail" | cut -f1)
    curl -s "$thumbnail" -o /tmp/youtube-thumbnail.png
    case "$2" in
        "copy")
            notify-send "Copied to clipboard" "$title" -i /tmp/youtube-thumbnail.png
            wl-copy "$1"
            ;;
        "download-video")
            notify-send "Downloading video" "$title" -i /tmp/youtube-thumbnail.png -h string:x-canonical-private-synchronous:progress
            nohup yt-dlp -f 'bv*+ba' --embed-thumbnail --embed-subs --merge-output-format mp4 "$1" -o "$download_path" | tee /tmp/yt-dlp-progress.txt &
            trap 'kill $! 2>/dev/null && exit 1' INT TERM EXIT
            sleep 1
            progress_notification
            wait
            notify-send "Download finished" "$title" -i /tmp/youtube-thumbnail.png -h string:x-canonical-private-synchronous:progress
            ;;
        "download-audio")
            notify-send "Downloading audio" "$title" -i /tmp/youtube-thumbnail.png -h string:x-canonical-private-synchronous:progress
            nohup yt-dlp --embed-metadata --extract-audio --audio-format mp3 --audio-quality 0 --embed-thumbnail "$1" -o "$download_path" | tee /tmp/yt-dlp-progress.txt &
            trap 'kill $! 2>/dev/null && exit 1' INT TERM EXIT
            sleep 1
            progress_notification
            wait
            notify-send "Download finished" "$title" -i /tmp/youtube-thumbnail.png -h string:x-canonical-private-synchronous:progress
            ;;
        "play-video")
            notify-send "Playing video" "$title" -i /tmp/youtube-thumbnail.png
            mpv "$1"
            ;;
        "play-audio")
            notify-send "Playing audio" "$title" -i /tmp/youtube-thumbnail.png
            alacritty -T "music" -e mpv "$1" --no-video --loop=inf
            ;;
        "view-channel")
            channel_id=$(printf "%s" "$response" | sed -nE "s@.*\"channelId\":\"([^\"]*)\".*@\1@p" | head -1)
            channel_name=$(printf "%s" "$response" | sed -nE "s@.*\"channelName\":\"([^\"]*)\".*@\1@p")
            channel_thumbnail=$(printf "%s" "$response" | sed -nE "s@.*channelThumbnail\":\{\"thumbnails\":\[\{\"url\":\"([^\"]*)\".*@\1@p")
            curl -sL -A "uwu" "$channel_thumbnail" -o /tmp/youtube-channel-thumbnail.png
            # TODO: do more actions with channel_id
            notify-send "Opening channel" "$channel_name" -i /tmp/youtube-channel-thumbnail.png
            $BROWSER "https://www.youtube.com/channel/$channel_id" 2>/dev/null
            ;;
    esac
}

case "$choice" in
    "Copy to clipboard") parse_link "copy" ;;
    "Download video") parse_link "download-video" ;;
    "Download audio") parse_link "download-audio" ;;
    "Play video") parse_link "play-video" ;;
    "Play audio") parse_link "play-audio" ;;
    "View channel (youtube only)") youtube "$input" "view-channel" ;;
    "Open in a browser") $BROWSER "$input" 2>/dev/null ;;
    *) notify-send "No action" ;;
esac
