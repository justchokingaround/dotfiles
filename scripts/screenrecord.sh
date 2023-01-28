#!/bin/sh

start_recording() {
	pkill -2 wf-recorder
	wf-recorder -f "/tmp/recording.mp4" &
	notify-send "Recording started"

	pgrep wf-recorder >/tmp/recordingpid &&
		sleep 3 && (kill -0 "$(cat /tmp/recordingpid)" || notify-send -t 1000 "Recording Failed")
}

get_name() {
	name=$(wofi -dmenu -p "Name your recording:" | tr " " "_")
	[ -z "$name" ] && rm "/tmp/recording.mp4" && exit 1
}

kill_recording() {
	get_name
	if [ -f "$HOME/videos/screen-recordings/$name.mp4" ]; then
		notify-send "File already exists, please choose another name"
		get_name
	fi
	notify-send "Recording Stopped"
	mv "/tmp/recording.mp4" "$HOME/videos/screen-recordings/$name.mp4"
	notify-send "Recording saved as $name.mp4"
	exit
}

case "$1" in
"start")
	start_recording
	;;
"stop")
	kill_recording
	;;
*)
	echo "Usage: $0 start|stop"
	exit 1
	;;
esac
