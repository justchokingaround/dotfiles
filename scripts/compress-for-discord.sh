#!/bin/bash
# Takes a video file and encodes it to <8MB (the size limit for discord upload) via libx264 two-pass encoding

# Exit if filename argument is not supplied or file does not exist
if [[ -z "$1" ]]; then
	echo "No filename supplied."
	exit 1
fi
if [[ ! -f "$1" ]]; then
	echo "File not found."
	exit 1
fi

# Determine output filename
base_filename=$(basename -- "$1")
base_filename="${base_filename%.*}"
filename=$base_filename
incr=0
while [[ -f $filename.mp4 ]]; do
	filename="${base_filename}-${incr}"
	incr=$(($incr + 1))
done

# Determine bitrate
secs=$(ffprobe -i "$1" -show_entries format=duration -v quiet -of csv="p=0")
audio_kb=$(echo "160*$secs" | bc)
if [[ "$2" == "-an" ]]; then
	audio_kb=0
fi
bitrate=$(echo "(64000-$audio_kb)/$secs" | bc)
if [[ $bitrate -le 0 ]]; then
	echo "Video duration is too long to be re-encoded to 8MB."
	if [[ "$2" != "-an" ]]; then
		echo "Try encoding without audio by adding \"-an\" option after filename."
	fi
	exit 1
fi
bitrate=$(echo "$bitrate*0.95" | bc)
bitrate="${bitrate}k"

# Perform ffmpeg encoding
ffmpeg -i "$1" -c:v libx264 -b:v $bitrate -an -pass 1 -f mp4 -y /dev/null
if [[ "$2" == "-an" ]]; then
	ffmpeg -i "$1" -c:v libx264 -b:v $bitrate -an -pass 2 "${filename}.mp4"
else
	ffmpeg -i "$1" -c:v libx264 -b:v $bitrate -c:a aac -b:a 160k -pass 2 "${filename}.mp4"
fi

# Remove two-pass log files
pattern=".*ffmpeg2pass-[0-9]\.log.*"
files=$(ls)
for file in $files; do
	if [[ $file =~ $pattern ]]; then
		rm $file
	fi
done
