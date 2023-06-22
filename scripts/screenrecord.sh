#!/bin/sh

recordings_dir="$HOME/videos/screen-recordings"
tmp_video_file="/tmp/recording.mp4"
audio_device="alsa_output.pci-0000_11_00.4.analog-stereo.monitor"
fps="60"
# rofi_prompt_config="$HOME/.config/rofi/styles/prompt.rasi"
token=$(cat ~/dox/credentials/discord_token.txt)

killall -s SIGINT wf-recorder 2>/dev/null

launcher() {
    if [ -z "$rofi_prompt_config" ]; then
        rofi -dmenu -i -mesg "$1"
    else
        rofi -dmenu -i -mesg "$1" -theme "$rofi_prompt_config"
    fi
    # wofi -d -p "$1"
    # tofi --require-match false --fuzzy-match true --prompt-text "$1"
}

nth() {
    stdin=$(cat)
    line=$(echo "$stdin" | awk -F '\t' "{ print NR, $1 }" | launcher | cut -d\  -f1)
    [ -n "$line" ] && echo "$stdin" | sed "${line}q;d" || exit 1
}

get_name() {
    name=$(printf "" | launcher "Name your recording: " | tr " " "_")
    if [ -z "$name" ]; then
        rm "$tmp_video_file"
        exit 1
    fi
}

start_recording() {
    test -f "$tmp_video_file" && rm $tmp_video_file
    # audio_choice=$(printf "1. Audio\n2. No Audio" | launcher "Choose audio: ")
    # [ "$audio_choice" = "2. No Audio" ] && audio_device=""

    notify-send "Recording started" -t 100 && sleep 0.3

    if [ "$1" = "region" ]; then
        wf-recorder -t \
            -g "$(slurp)" \
            --audio="$audio_device" \
            -m mp4 \
            -F fps="$fps" \
            -f "$tmp_video_file" &
    else
        printf "1\n" |
            wf-recorder -t \
                --audio="$audio_device" \
                -m mp4 \
                -F fps="$fps" \
                -f "$tmp_video_file" &
    fi
}

stop_recording() {
    notify-send "Recording Stopped" -t 1000
    format=$(printf "1. 1080p\n2. Discord share (choose channel and send the video under 25mb there)\n3. Discord (under 25mb)\n4. Upload to oshi.at and copy to clipboard\n5. gif\n6. Delete" |
        launcher "Choose a format: " | sed -nE 's/[0-9]. (.*)/\1/p')
    [ -z "$format" ] && format="Delete"
    convert_recording "$format"
}

compress_to_25mb() {
    notify-send "File is over 25mb, compressing..."
    notify-send "This may take a while..." -t 2000
    ffmpeg -i "$tmp_video_file" -vcodec libx264 -crf 24 -maxrate 500k -bufsize 1000k "$1"
    notify-send "Compression complete" -t 1000
}

convert_recording() {
    if [ "$1" = Delete ]; then
        rm "$tmp_video_file"
        notify-send "No format selected"
        exit 1
    fi
    if [ "$1" != "Discord share (choose channel and send the video under 25mb there)" ]; then
        get_name
        if [ -f "$recordings_dir/$name.mp4" ]; then
            notify-send "File already exists, please choose another name"
            get_name
        fi
    fi
    case "$1" in
        1080p)
            if [ -f "$recordings_dir/$name.mp4" ]; then
                notify-send "File already exists, please choose another name"
                get_name
            fi
            ffmpeg -i "$tmp_video_file" -vf scale=1920:1080 "$recordings_dir/$name.mp4"
            notify-send "Recording saved as $name.mp4 in ~/videos/screen-recordings in $1 format"
            ;;
        720p)
            ffmpeg -i "$tmp_video_file" -vf scale=1280:720 "$recordings_dir/$name.mp4"
            notify-send "Recording saved as $name.mp4 in ~/videos/screen-recordings in $1 format"
            ;;
        "Discord (under 25mb)")
            if [ "$(du -m "$tmp_video_file" | cut -f1)" -gt 25 ]; then
                compress_to_25mb "$recordings_dir/$name.mp4"
            else
                cp "$tmp_video_file" "$recordings_dir/$name.mp4"
            fi
            notify-send "Recording saved as $name.mp4 in ~/videos/screen-recordings in $1 format"
            ;;
        "Upload to oshi.at and copy to clipboard")
            notify-send "Converting to 1080p..." -t 1000
            ffmpeg -i "$tmp_video_file" -vf scale=1920:1080 "/tmp/$name.mp4"
            notify-send "Uploading to oshi.at..." -t 1000
            link=$(printf "%s" "$(curl -# "https://oshi.at" -F "f=@/tmp/$name.mp4" randomizefn=0 shorturl=1 |
                sed -nE "s_DL: (.*)_\1_p")")
            notify-send "Here's your link: $link" -t 1000
            printf "%s" "$link" | wl-copy
            notify-send "Link copied to clipboard" "$link"
            exit 0
            ;;
        gif)
            notify-send "Converting to a gif might take a while..." -t 5000
            ffmpeg -i "$tmp_video_file" -vf scale=1280:720 -r 10 -f image2pipe -vcodec ppm - | convert -delay 5 -loop 0 - "$recordings_dir/$name.gif"
            notify-send "Gif saved as $name.gif in ~/videos/screen-recordings in $1 format"
            ;;
        "Discord share (choose channel and send the video under 25mb there)")
            if [ "$(du -m "$tmp_video_file" | cut -f1)" -gt 25 ]; then
                compress_to_25mb "$tmp_video_file"
                wait
            fi
            base="https://discord.com/api/v10"
            server_choice=$(curl -s -H "Authorization: $token" "${base}/users/@me/guilds" | tr "{|}" "\n" |
                sed -nE "s@\"id\": \"([0-9]*)\", \"name\": \"([^\"]*)\".*@\1\t\2@p" | nth "\$2")

            [ -z "$server_choice" ] && exit 1
            server_name=$(printf "%s" "$server_choice" | cut -f2)
            server_id=$(printf "%s" "$server_choice" | cut -f1)

            channel=$(curl -s -H "Authorization: $token" "${base}/guilds/${server_id}/channels" | tr "{|}" "\n" |
                sed -nE "s@\"id\": \"([0-9]*)\".*\"type\": 0,.*\"name\": \"([^\"]*)\",.*\"position\": ([0-9]*).*@\3) \2\t\1@p" | sort -h | cut -f2 -d' ')
            channel_choice=$(printf "%s" "$channel" | tr '-' ' ' | nth "\$1")
            [ -z "$channel_choice" ] && exit 1
            channel_name=$(printf "%s" "$channel_choice" | cut -f1)
            channel_id=$(printf "%s" "$channel_choice" | cut -f2)

            curl -H "Authorization: $token" -H "Accept: application/json" -H "Content-Type: multipart/form-data" -X POST -F "file=@/tmp/recording.mp4" "${base}/channels/$channel_id/messages"
            notify-send "$server_name ⚫$channel_name" "Video sent" -t 1000
            ;;
        *) notify-send "No format selected" ;;
    esac
}

while [ $# -gt 0 ]; do
    case "$1" in
        -r | --region) region=1 ;;
        -h | --help) help_info ;;
        *) action="$1" ;;
    esac
    shift
done

case "$action" in
    "start")
        if [ "$region" = 1 ]; then
            start_recording "region"
        else
            start_recording
        fi
        ;;
    "stop") stop_recording ;;
    *) exit 1 ;;
esac
