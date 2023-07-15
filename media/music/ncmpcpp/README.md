#### Getting the zellij wrapper script to work, with image preview

Requirements:
- zellij
- playerctl
- ffmpegthumbnailer
- libsixel (or a different image protocol, you have to tweak that manually yourself)
- cava (used in my zellij layout, but this is optional)

Before starting the guide, I will quickly explain how it works. For getting the path to the currently playing song, I use `playerctl metadata`. For extracting the thumbnail, I use the `ffmpegthumbnailer` package. I'm able to do this, since all of the music I have downloaded locally has embedded thumbnails. On each song_change in ncmpcpp I run a script that extracts the thumbnail for the currently playing song to `/tmp/currently-playing.jpg`. The rest is zellij and scripting magic, which I won't be explaining in this guide. If you're interested, you can just read through each script, it should be pretty easy to understand and self-explanatory.

#### Actual guide

1. You must have this line added in your ncmpcpp config, found at `$HOME/.config/ncmpcpp/config`:
```sh
execute_on_song_change = "~/.config/ncmpcpp/song_change.sh"
```

This just tells ncmpcpp to run a specific script each time a song changes.

2. You will then have to create that script and make it executable with `chmod +x ~/.config/ncmpcpp/song_change.sh`. Here are the contents of the script (this script can also be found in this repo, that version should be the most up to date) :
```
#!/bin/sh

image_path="/tmp/currently-playing.jpg"
test -d "$HOME/.cache/ncmpcpp/images/" || mkdir -p "$HOME/.cache/ncmpcpp/images/"

song_path=$(playerctl metadata xesam:url | sed -nE "s@file://(/home/.*)@\1@p")
ffmpegthumbnailer -i "$song_path" -o "$image_path" -s0 2>/dev/null
convert "$image_path" "$image_path" 2>/dev/null || notify-send "ffmpegthumbnailer failed"
title=$(playerctl metadata xesam:url | sed -nE "s@.*/(.*)\.(mp3|flac|opus|mkv|m4a)@\1@p")
# check if a file with the same name already exists
test -f "$HOME/.cache/ncmpcpp/images/""$title.jpg" || cp "$image_path" "$HOME/.cache/ncmpcpp/images/""$title.jpg"
notify-send "Now Playing" "$title" -i "$image_path" -h string:x-dunst-stack-tag:vol
```

3. You will also need to create a wrapper script to display the actual image in your top left zellij pane. This is where you would want to customize the image protocol used, the sleep time, the image size etc.

* Note: the image protocol that you set to use should be compatible with zellij, otherwise this will not work. To test it out, just open zellij with `zellij` and then run a command that would normally display an image in your terminal.

Here is the wrapper script (this script can also be found in this repo with the name `art.sh`, that version should be the most up to date) :
```sh
#!/bin/sh
set -e

# change this value to your desired width
size_x=40
size_y=11

while true; do
    title=$(playerctl metadata xesam:url 2>/dev/null | sed -nE "s@.*/(.*)\.(mp3|flac|opus|mkv|m4a)@\1@p")
    if [ -n "$title" ]; then
        song_path="$HOME/.cache/ncmpcpp/images/""$title.jpg"
        if [ "$oldpath" != "$song_path" ]; then
            zellij action move-focus left
            zellij action move-focus up
            zellij action page-scroll-down
            zellij action clear

            chafa -f sixel -s ${size_x}x${size_y} "$song_path" 2>/dev/null || echo "chafa failed"
            # chafa -f symbols -s ${size}x${size} "$song_path"

            zellij action page-scroll-up
            zellij action move-focus right
        fi
        oldpath=$song_path
        sleep 1
    fi
done
```

4. Lastly, you need to create a zellij layout. In my case I like having an image displayed in the top left corner, a visualizer in the bottom left (I use cava, but you don't have to, feel free to change that part of the layout) and the rest of the screen is used for ncmpcpp. Here is the layout (this layout can also be found in this repo with the name `music.kdl`, that version should be the most up to date) :
```sh
layout {
    pane split_direction="vertical" {
        pane split_direction="horizontal" {
            // if you have not added the script to path, use the command that's commented out below, instead of the one i'm using
            // pane command="~/.config/ncmpcpp/art.sh" size="60%"
            pane command="art" size="40%"
            // feel free to change this to your desired visualizer
            pane command="cava"
        }
        pane command="ncmpcpp" size="70%" focus=true
    }
}
```

5. Finally, you can run this script using the following command:
```sh
zellij --layout=$HOME/.config/ncmpcpp/music.kdl
```

Feel free to contact me, or write an issue if you encounter any trouble with setting this up, I'm always glad to help.

Here is how it should look like in the end:
In `alacritty` (I'm using the patched version, with sixel support, `alacritty-sixel` in the aur):
![image](https://github.com/justchokingaround/dotfiles/assets/44473782/015a692e-a7c0-4e20-980d-71b2c64b7486)

In `wezterm`, using sixel:
![image](https://github.com/justchokingaround/dotfiles/assets/44473782/0a5d1b26-daf2-4036-9e84-40f5abfaeb19)

In `cool-retro-term`, using chafa:
![image](https://github.com/justchokingaround/dotfiles/assets/44473782/c6f6430c-b087-4d09-b7f6-9dfa9c5f9973)

In `foot`, using sixel:
![image](https://github.com/justchokingaround/dotfiles/assets/44473782/d5c75694-1782-4296-9f0d-aafe58f9e2da)
