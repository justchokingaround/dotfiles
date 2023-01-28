#!/bin/bash

pkill -2 wf-recorder
test -e /tmp/recordingpid &&
	recpid="$(cat /tmp/recordingpid)" &&
	kill -2 "$recpid" &&
	rm -f /tmp/recordingpid &&
	sleep 3 &&
	pgrep ffmpeg && kill -9 "$recpid"

resolution=$(xrandr | grep primary | awk '{print $4}' | cut -d '+' -f 1)

PIN=$(pactl list sources |
	grep -B 2 'analog.*.monitor' |
	sed 's/[^0-9]*//' |
	head -n 1)

killrecording() {
	notify-send "Recording Stopped"
	exit
}

softenc() {
	ffmpeg -thread_queue_size 256 \
		-f x11grab -s "$resolution" -draw_mouse 0 -i :0.0 \
		-f pulse -i "$PIN" \
		-crf 23 -preset ultrafast \
		-acodec aac \
		"$HOME/syncthing/Recordings/screencast-$(date '+%y%m%d-%H%M-%S').mp4" \
		2>ffxivrecord.log &
	echo $! >/tmp/recordingpid &&
		sleep 3 && (kill -0 "$(cat /tmp/recordingpid)" || notify-send -t 1000 "Recording Failed")
}

hardenc() {
	ffmpeg -thread_queue_size 256 -probesize 5000M \
		-f x11grab -s "$resolution" -r 30 -draw_mouse 0 -i :0.0 \
		-f pulse -i default \
		-c:v hevc_nvenc \
		-preset slow -tune ll -rc vbr -cq 24 \
		-acodec aac \
		-ss 00:00:03 \
		"$HOME/syncthing/Recordings/screencast-$(date '+%y%m%d-%H%M-%S').mp4" \
		2>ffxivrecord.log &
	echo $! >/tmp/recordingpid &&
		sleep 3 && (kill -0 "$(cat /tmp/recordingpid)" || notify-send -t 1000 "Recording Failed")
}

wayland() {
	wf-recorder -a \
		-f "$HOME/syncthing/Recordings/screencast-$(date '+%y%m%d-%H%M-%S').mp4" \
		-m mp4 \
		-x nv12 \
		-c hevc_nvenc \
		-F fps=60 \
		-p preset=slow \
		-p tune=ll \
		-p rc=vbr \
		-p cq=24 \
		&>ffxivrecord.log &
	pgrep wf-recorder >/tmp/recordingpid &&
		sleep 3 && (kill -0 "$(cat /tmp/recordingpid)" || notify-send -t 1000 "Recording Failed")
}

help() {
	echo \
		"Triggers Screen Recording via FFMPEG with x11grab and a Pulse Audio Monitor input.

Each new instance of this script will automatically kill the previous ffmpeg instance, allowing recording to quickly stop and restart and avoiding multiple recording instances.

Must be run with one of the following flags:

hw      Hardware-accelerated recording via VAAPI.
sw      Recording with software encoding (CPU intensive).
wayland Records using wf-recorder for Wayland.
kill    Kills the previous recording instance.

Any other flag will return this help message.
"
}

case "$1" in
kill) killrecording ;;
sw) softenc ;;
hw) hardenc ;;
wl) wayland ;;
*) help ;;
esac
