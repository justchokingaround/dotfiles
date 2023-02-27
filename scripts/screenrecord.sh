#!/bin/sh

VIDEO_RECORDINGS_DIR="$HOME/videos/screen-recordings"
TMP_VIDEO_FILE="/tmp/recording.mp4"
FPS="60"

launcher() {
	rofi -dmenu -i -p "$1"
	# wofi -d -p "$1"
	# tofi --require-match false --fuzzy-match true --prompt-text "$1"
}

pkill -2 wf-recorder
test -e /tmp/recordingpid &&
	recpid="$(cat /tmp/recordingpid)" &&
	kill -2 "$recpid" &&
	rm -f /tmp/recordingpid &&
	sleep 3 &&
	pgrep ffmpeg && kill -9 "$recpid"

get_name() {
	name=$(echo "" | launcher "Name your recording: " | tr " " "_")
	[ -z "$name" ] && rm "$TMP_VIDEO_FILE" && exit 1
}

start_recording() {
	rm $TMP_VIDEO_FILE
	monitor_number=$(printf "1. (DP-2)\n2. (HDMI-a-1)" | launcher "Choose a monitor: ")
	[ -z "$monitor_number" ] && exit 1
	notify-send "Recording started" -t 1000 && sleep 2
	wf-recorder -t -f "$TMP_VIDEO_FILE" &

	pgrep wf-recorder >/tmp/recordingpid &&
		# sleep 3 && (kill -0 "$(cat /tmp/recordingpid)" || notify-send -t 1000 "Recording failed")
		printf "%s\n" "$monitor_number" |
		wf-recorder -t \
			--audio="alsa_output.pci-0000_11_00.4.analog-stereo.monitor" \
			-m mp4 \
			-F fps="$FPS" \
			-f "$TMP_VIDEO_FILE" &
}

kill_recording() {
	get_name
	if [ -f "$VIDEO_RECORDINGS_DIR/$name.mp4" ]; then
		notify-send "File already exists, please choose another name"
		get_name
	fi
	notify-send "Recording Stopped" -t 1000
	format=$(printf "1. 1440p\n2. 1080p\n3. 720p\n4. Discord (under 8mb)\n5. Discord share (upload to oshi.at and copy to clipboard)\n6. gif\n7. Delete" |
		launcher "Choose a format: " | sed -nE 's/[0-9]. (.*)/\1/p')
	convert_recording "$format"
}

convert_recording() {
	[ "$1" = Delete ] && rm "$TMP_VIDEO_FILE" && notify-send "No format selected" && exit 1
	notify-send "Converting to $1..." -t 2000
	case "$1" in
	1440p) mv "$TMP_VIDEO_FILE" "$VIDEO_RECORDINGS_DIR/$name.mp4" ;;
	1080p) ffmpeg -i "$TMP_VIDEO_FILE" -vf scale=1920:1080 "$VIDEO_RECORDINGS_DIR/$name.mp4" ;;
	720p) ffmpeg -i "$TMP_VIDEO_FILE" -vf scale=1280:720 "$VIDEO_RECORDINGS_DIR/$name.mp4" ;;
	"Discord (under 8mb)")
		notify-send "Compressing video..." -t 2000
		notify-send "This may take a while..." -t 2000
		ffmpeg -i "$TMP_VIDEO_FILE" -vf scale=1920:1080 -c:v libx264 -crf 18 -preset veryslow -c:a "$VIDEO_RECORDINGS_DIR/$name.mp4"
		notify-send "Compression complete" -t 1000
		;;
	"Discord share (upload to oshi.at and copy to clipboard)")
		notify-send "Converting to 1080..." -t 1000
		ffmpeg -i "$TMP_VIDEO_FILE" -vf scale=1920:1080 "/tmp/$name.mp4"
		notify-send "Uploading to oshi.at..." -t 1000
		link=$(printf "%s" "$(curl -# "https://oshi.at" -F "f=@/tmp/$name.mp4" randomizefn=0 shorturl=1 |
			sed -nE "s_DL: (.*)_\1_p")")
		notify-send "Here's your link: $link" -t 1000
		printf "%s" "$link" | wl-copy
		notify-send "oshi.at link copied to clipboard"
		exit
		;;
	gif)
		notify-send "Converting to a gif might take a while..." -t 5000
		ffmpeg -i "$TMP_VIDEO_FILE" -vf scale=1280:720 -r 10 -f image2pipe -vcodec ppm - | convert -delay 5 -loop 0 - "$VIDEO_RECORDINGS_DIR/$name.gif"
		;;
	*) notify-send "No format selected" ;;
	esac
	notify-send "Recording saved as $name.mp4 in ~/videos/screen-recordings in $1 format"
}

case "$1" in
"start") start_recording ;;
"stop") kill_recording ;;
*) exit 1 ;;
esac
