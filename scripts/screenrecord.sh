#!/bin/sh

# set default location and name of recording
OUTPUT="$HOME/videos/screenrecordings/$(date +%Y-%m-%d_%H-%M-%S).mp4"

wf-recorder -a -f "$OUTPUT"
