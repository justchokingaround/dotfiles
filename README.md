These dotfiles are WIP atm, please do not blindly copy them. If you have any questions, you can ask me anything, I'll be happy to help you.

#### Necessary packages
```sh
paru -S hyprland-bin xdg-desktop-portal-hyprland-git wireplumber pipewire qt5-wayland qt6-wayland polkit-gnome pulseaudio playerctl pamixer ffmpeg waybar-hyprland slurp wl-clipboard libsixel
```

#### Quality of life packages
```sh
paru -S bat bottom doas exa ffmpegthumbnailer fzf hyprpicker-git lazygit mlocate mpDris2 nautilus networkmanager nsxiv pavucontrol swappy starship wev zoxide zsh
```

#### Personal utilities I use
```sh
paru -S cliphist-bin discord webcord-bin firefox  grimblast-git hyprpaper-git mako mpv socat neovim neovide rofi-lbonn-wayland-git spotify-player tectonic texinfo texlive-bibtexextra texlive-bin texlive-core texlive-fontsextra texlive-formatsextra texlive-latexextra texlive-pictures texlive-science foot wezterm wf-recorder zathura zathura-pdf-mupdf phocus-gtk-theme-git ttf-blex-nerd-font-git xplr
```

## Table of Contents
- [Anime and Manga](#Anime-and-Manga)
- [Clipboard](#Clipboard)
- [Coding/Text editing (Neovim)](#Coding)
- [Discord](#Discord)
- [Fonts](#Fonts)
- [GTK Theme](#GTK-Theme)
- [Movies and TV Shows](#Movies-and-TV-Shows)
- [Notifications](#Notifications)
- [PDF Viewer](#PDF-Viewer)
- [Rofi](#Rofi)
- [Screenshot](#Screenshot)
- [Screen Recording](#Screen-Recording)
- [Spotify](#Spotify)
- [Terminals](#Terminals)
- [Terminal File Manager](#Terminal-File-Manager)
- [Video Player](#Video-Player)
- [Wallpaper](#Wallpaper)

## Anime and Manga
<details>
<summary>Programs I use</summary>

- [jerry](https://github.com/justchokingaround/jerry) (Script that allows me to watch anime and read manga with mpv and zathura, while syncing the progress between them on anilist)
- [mpv](https://mpv.io/) (Video player)
- [zathura](https://git.pwmt.org/pwmt/zathura) (PDF viewer)
Optional:
- [rofi](https://github.com/davatorium/rofi) (Launcher/Menu - I use the wayland fork ([rofi-lbonn-wayland-git](https://aur.archlinux.org/packages/rofi-lbonn-wayland-git/))
- [mako](https://github.com/emersion/mako) (Notifications)

</details>

<details>
<summary>Showcase</summary>

![image](https://user-images.githubusercontent.com/44473782/221352299-bae6cfcd-c5b6-419f-84ae-e787587815ad.png)

![image](https://user-images.githubusercontent.com/44473782/221352287-11f9927f-d2e9-411a-bfd6-aac196daca5e.png)

</details>

<details>
<summary>Configuration</summary>

- [Jerry Configuration](https://github.com/justchokingaround/dotfiles/blob/main/jerry/jerry.conf)
My jerry configuration has 2 dependenices:
    - [Custom Zathura Configuration for Manga](https://github.com/justchokingaround/dotfiles/blob/main/jerry/zathurarc)
    - [Custom Rofi Configuration for Image Preview](https://github.com/justchokingaround/dotfiles/blob/main/rofi/styles/image-preview.rasi) (TODO: Remove dependencies in this configuration, ie colors.rasi and font)
- [Mpv Configuration](#Video-Player) (See Video Player section)
- [Zathura Configuration](#PDF-Viewer) (See PDF Viewer section)
- [Rofi Configuration](#Rofi) (See Rofi section)
- [Mako Configuration](#Notifications) (See Notifications section)

These are the lines that point to these files in my jerry configuration:
```sh
manga_opener="zathura --mode fullscreen -c ~/.config/jerry/"
image_config_path="$HOME/.config/rofi/styles/image-preview.rasi"
```

</details>

## Clipboard
<details>
<summary>Programs I use</summary>

- [wl-clipboard](https://github.com/bugaevc/wl-clipboard) (Wayland clipboard)
- [cliphist](https://github.com/sentriz/cliphist) (Clipboard manager)
- [copyq](https://github.com/hluk/CopyQ) (TODO: Clipboard manager with advanced features)

</details>

<details>
<summary>Showcase</summary>

TODO: add screenshots

</details>

<details>
<summary>Configuration</summary>

- [Launch on Startup](https://github.com/justchokingaround/dotfiles/blob/main/hypr/configs/exec.conf) (hypr/configs/exec.conf)
These are the lines that point to these files in my hyprland configuration:
```sh
exec-once   =   wl-clip-persist --clipboard regular
exec-once   =   wl-paste --watch cliphist store
```
- [Cliphist Configuration](https://github.com/justchokingaround/dotfiles/blob/main/hypr/configs/keybinds.conf) (hypr/configs/keybinds.conf)
This line points to my keybind for cliphist:
```sh
bind=CTRL$mainMod,V,exec,cliphist list | rofi -dmenu -p "" | cliphist decode | wl-copy
```
Note: for this to work, you must have rofi installed

</details>

## Coding
<details>
<summary>Programs I use</summary>

- [neovim](https://neovim.io/) (Text editor, and also my IDE for most languages)
- [neovide](https://neovide.dev/) (GUI for neovim, written in rust)

</details>

<details>
<summary>Showcase</summary>

![image](https://user-images.githubusercontent.com/44473782/221352540-04a8c00b-4d48-454e-8d8c-371e861224e7.png)

![image](https://user-images.githubusercontent.com/44473782/221352661-ccb208f6-dc48-4077-ba69-f423710a69b7.png)

![image](https://user-images.githubusercontent.com/44473782/221352705-cdcb9008-4912-4495-822c-1e0af363d8a3.png)

</details>

<details>
<summary> Configuration</summary>

- [Neovim Configuration](https://github.com/justchokingaround/nvim) (I keep my neovim configuration in a separate repository)

</details>

## Discord
<details>
<summary>Programs I use</summary>

- [discord](https://archlinux.org/packages/community/x86_64/discord/) (Discord client)
- [webcord](https://github.com/SpacingBat3/WebCord) (Webcord, for screen sharing on wayland)
- [Vencord](https://github.com/Vendicated/Vencord) (The cutest Discord client mod)

</details>

<details>
<summary>Showcase</summary>

TODO: Upload screenshots

</details>

<details>
<summary>Configuration</summary>
TODO: Upload configuration

</details>

## Fonts

<details>
<summary>Fonts I use</summary>

- [Liga SFMono Nerd Font](https://github.com/shaunsingh/SFMono-Nerd-Font-Ligaturized) (My favorite font, with ligatures)
- [BlexMono Nerd Font](https://aur.archlinux.org/packages/ttf-blex-nerd-font-git) (My second favorite font, with ligatures)
- [Iosevka Nerd Font Mono](https://archlinux.org/packages/community/any/ttf-iosevka-nerd/) (I don't use this font often, but it's a good font)
- [ComicCodeLigatures]() (TODO: add ComicCodeLigatures font)

</details>

<details>
<summary>Showcase</summary>

TODO: add screenshots of fonts

</details>

<details>
<summary>Installation</summary>

To install these fonts, you can use the AUR helper of your choice with a manual installation for Liga SFMono Nerd Font:
```sh
paru -S ttf-blex-nerd-font-git ttf-iosevka-nerd-font
```
```sh
git clone https://github.com/shaunsingh/SFMono-Nerd-Font-Ligaturized.git && cd SFMono-Nerd-Font-Ligaturized
cp *.otf ~/.local/share/fonts
cd .. && rm -rf SFMono-Nerd-Font-Ligaturized
```

</details>

## GTK Theme
<details>
<summary>GTK Theme that I use</summary>

- [phocus](https://aur.archlinux.org/packages/phocus-gtk-theme-git)

</details>

<details>
<summary>Showcase</summary>

TODO: add screenshots

</details>

<details>
<summary>Configuration</summary>

TODO: add setup and configuration

</details>

## Movies and TV Shows
<details>
<summary>Programs I use</summary>

- [lobster](https://github.com/justchokingaround/lobster) (A script to search for movies and tv shows)
- [mpv](https://mpv.io/) (Video player)
Optional:
- [rofi](https://github.com/davatorium/rofi) (Launcher/Menu - I use the wayland fork ([rofi-lbonn-wayland-git](https://aur.archlinux.org/packages/rofi-lbonn-wayland-git/))
- [mako](https://github.com/emersion/mako) (Notification daemon)

</details>

<details>
<summary>Showcase</summary>

TODO: add screenshots

</details>

<details>
<summary>Configuration for those programs</summary>

- [Lobster Configuration](https://github.com/justchokingaround/dotfiles) (TODO: add lobster configuration):
    - [Custom Rofi Configuration for Image Preview](https://github.com/justchokingaround/dotfiles/blob/main/rofi/styles/image-preview.rasi) (TODO: Remove dependencies in this configuration, ie colors.rasi and font)
- [Mpv Configuration](#Video-Player) (See Video Player section)
- [Rofi Configuration](#Rofi) (See Rofi section)
- [Mako Configuration](#Notifications) (See Notifications section)

</details>

## Notifications
<details>
<summary>Programs I use</summary>

- [mako](https://github.com/emersion/mako) (Notification daemon)

</details>

<details>
<summary>Showcase</summary>

![image](https://user-images.githubusercontent.com/44473782/221352342-a9e69a44-ddc7-4acd-9981-56809240b10a.png)

</details>

<details>
<summary>Configuration for those programs</summary>

- [Launch on Startup](https://github.com/justchokingaround/dotfiles/blob/main/hypr/configs/exec.conf) (hypr/configs/exec.conf)
This is the line that I use to launch mako on startup:
```sh
exec-once   =   mako
```
- [Mako Configuration](https://github.com/justchokingaround/dotfiles/blob/main/mako/config) (mako/config)

</details>

## PDF Viewer
<details>
<summary>Programs I use</summary>

- [zathura](https://archlinux.org/packages/community/x86_64/zathura/) (PDF viewer)
- [zathura-pdf-mupdf](https://archlinux.org/packages/community/x86_64/zathura-pdf-mupdf/) (PDF viewer plugin)

</details>

<details>
<summary>Showcase</summary>

TODO: add screenshots

</details>

<details>
<summary>Configuration for those programs</summary>

- [Zathura Configuration](https://github.com/justchokingaround/dotfiles/blob/main/zathura/zathurarc) (zathura/zathurarc)

</details>

## Rofi
<details>
<summary>Programs I use</summary>

- [rofi](https://github.com/davatorium/rofi) (Launcher/Menu - I use the wayland fork ([rofi-lbonn-wayland-git](https://aur.archlinux.org/packages/rofi-lbonn-wayland-git/))

</details>

<details>
<summary>Showcase</summary>

Example of using Rofi with ytfzf:
![image](https://user-images.githubusercontent.com/44473782/221353002-cc2cfe0b-be7b-4e4f-b88e-a1cfcf165502.png)

</details>

<details>
<summary>Configuration for those programs</summary>

- [Rofi Configuration](https://github.com/justchokingaround/dotfiles/tree/main/rofi) (rofi)
TODO: explain configuration

</details>

## Screenshot
<details>
<summary>Programs I use</summary>

- [grimblast](https://aur.archlinux.org/packages/grimblast-git) (Hyprland version of grimshot)
- [grim](https://sr.ht/~emersion/grim/) (Grab images from a Wayland compositor)
- [slurp](https://github.com/emersion/slurp) (Select a region in a Wayland compositor)
- [swappy](https://github.com/jtheoof/swappy) (A Wayland native screenshot tool, for quickly editing/annotating screenshots)
- [wl-clipboard](https://github.com/bugaevc/wl-clipboard) (Copy/paste from/to Wayland compositors)
Optional:
- [mako](https://github.com/emersion/mako) (Notification daemon)

</details>

<details>
<summary>Showcase</summary>

TODO: add screenshots

</details>

<details>
<summary>Configuration for those programs</summary>

- [Keybind Shortcuts](https://github.com/justchokingaround/dotfiles/blob/main/hypr/configs/keybinds.conf) (hypr/configs/keybinds.conf):

These lines in the keybinds.conf file are the keybinds that I use for taking screenshots:
```sh
$screenshotarea = hyprctl keyword animation "fadeOut,0,0,default"; grimblast --notify copy area; hyprctl keyword animation "fadeOut,1,4,default"
bind=,107,exec,grimblast --notify --cursor copy output
bind=SHIFT,107,exec,grimblast --notify --cursor copy area
bind=CTRLSHIFT,107,exec,grim -g "$(slurp)" - | swappy -f - -o - | wl-copy
```
Note: 107 is the keycode for the PrintScreen key, you can check the keycode for a key by running `wev` and pressing the key you want to check the keycode for.

</details>

## Screen Recording
<details>
<summary>Programs I use</summary>

- [wf-recorder](https://github.com/ammen99/wf-recorder) (Screen recording tool for Wayland compositors)
- [ffmpeg](https://ffmpeg.org/) (Video encoding/decoding library)
Optional:
- [mako](https://github.com/emersion/mako) (Notification daemon)

</details>

<details>
<summary>Showcase</summary>

TODO: add screenshots

</details>

<details>
<summary>My screen recording workflow</summary>

- [My Screen Recording Script](https://github.com/justchokingaround/dotfiles/blob/main/scripts/screenrecord.sh) (TODO: fix script encoding cases and add support for single monitor setups and input audio and slurp selection)

```sh
bind=,127,exec,~/scripts/screenrecord.sh start
bind=SHIFT,127,exec,~/scripts/screenrecord.sh stop
```

</details>

## Spotify
<details>
<summary>Programs I use</summary>

- [spotify-player](https://github.com/aome510/spotify-player) (Spotify terminal music player)
Note: this only works for spotify accounts that have a premium subscription at the time of writing this.
Optional:
- [libsixel](https://archlinux.org/packages/community/x86_64/libsixel/) (Library for sixel graphics - used for displaying album art images in the terminal)
- [mako](https://github.com/emersion/mako) (Notification daemon)

</details>

<details>
<summary>Showcase</summary>

![image](https://user-images.githubusercontent.com/44473782/221352880-d4a0fbac-2627-4725-959d-7db542c4ce90.png)

</details>

<details>
<summary>Configuration for those programs</summary>

Compilation arguments I use:
```sh
cargo install spotify_player --features notify,sixel,lyric-finder,pulseaudio-backend
```

Patch for replacing notifications when skipping songs:
```rs
.hint(notify_rust::Hint::Custom(("x-dunst-stack-tag").to_string(), ("spotify-player").to_string()))
```
TODO: change this to diff format

Configuration for spotify-player:
- [Spotify Player Configuration](https://github.com/justchokingaround/dotfiles/tree/main/spotify-player) (spotify-player)

</details>

## Terminals
<details>
<summary>Programs I use</summary>

- [wezterm](https://wezfurlong.org/wezterm/) (This is my main terminal emulator)
- [foot](https://codeberg.org/dnkl/foot) (This is my secondary terminal emulator)

</details>

<details>
<summary>Showcase</summary>

TODO: add screenshots

</details>

<details>
<summary>My terminal workflow</summary>

TODO: add keybinds documentation for multiplexing and multitabbing

Configuration for those programs:
- [Wezterm Configuration](https://github.com/justchokingaround/dotfiles/tree/main/wezterm) (wezterm)
- [Foot Configuration](https://github.com/justchokingaround/dotfiles/blob/main/foot/foot.ini) (foot/foot.ini)

</details>

## Terminal File Manager
<details>
<summary>Programs I use</summary>

- [xplr](https://github.com/sayanarijit/xplr) (A hackable, minimal, fast, and intuitive file explorer written in Rust)
- [wezterm](https://wezfurlong.org/wezterm/) (I use wezterm for xplr previewing because of its support for image previews using sixel and kitty graphics, as well as its built-in terminal multiplexer)
Optional:
- [libsixel](https://archlinux.org/packages/community/x86_64/libsixel/) (Library for sixel graphics - used for displaying images in the terminal)

</details>

<details>
<summary>Showcase</summary>

Example of xplr previewing images using wezterm:
![image](https://user-images.githubusercontent.com/44473782/221352958-e6de120a-ca39-48fe-a617-8874dff85e13.png)

</details>

<details>
<summary>Configuration for those programs</summary>

TODO: move nnn previewer to xplr

Configuration for xplr:
- [Xplr Configuration](https://github.com/justchokingaround/dotfiles/blob/main/xplr/init.lua) (xplr/init.lua - This configuration file will automatically download all the plugins that I use for xplr)

</details>

## Video Player
<details>
<summary>Programs I use</summary>

- [mpv](https://mpv.io/) (Media player)

</details>

<details>
<summary>Showcase</summary>

![image](https://user-images.githubusercontent.com/44473782/221352418-1ddfbbcd-495c-447e-b1fe-0a4d1efdb117.png)

</details>

<details>
<summary>Configuration for those programs</summary>

- [Mpv Configuration](https://github.com/justchokingaround/dotfiles/tree/main/mpv) (mpv)

TODO: explain keybinds and scripts

</details>

## Wallpaper
<details>
<summary>Programs I use</summary>

- [hyprpaper](https://github.com/hyprwm/hyprpaper) (Hyprpaper is a blazing fast wayland wallpaper utility with IPC controls. I use it for setting static wallpapers)
Optional:
- [mpvpaper](https://github.com/GhostNaN/mpvpaper) (A video wallpaper program for wlroots based Wayland compositors)
- [socat](https://archlinux.org/packages/extra/x86_64/socat/) (Utility to interract with the IPC socket of mpvpaper - ie for controlling the current video wallpaper)

</details>

<details>
<summary>Showcase</summary>

![image](https://user-images.githubusercontent.com/44473782/221352482-08b77efa-d6c8-474c-9d90-304876323bb0.png)

![image](https://user-images.githubusercontent.com/44473782/221352931-832e900c-a80f-408f-9963-e6067a45c55e.png)

![image](https://user-images.githubusercontent.com/44473782/221352263-0218f78e-23d2-4ddd-ac9c-87d107f93485.png)

TODO: add video demo
TODO: store wallpapers somewhere

</details>

<details>
<summary>Configuration for those programs</summary>

- [Launch on Startup](https://github.com/justchokingaround/dotfiles/blob/main/hypr/configs/exec.conf) (hypr/configs/exec.conf)
This is the command I use to launch hyprpaper or mpvpaper on startup (on my main setup, I use mpvpaper, therefore hyprpaper is commented out):
```sh
# exec-once   =   hyprpaper
exec-once   =   mpvpaper '*' "/home/chokerman/videos/animated_wallpapers/" -o "no-audio --shuffle --input-ipc-server=/tmp/mpvpaper-socket" -s -f
```
Using this command it will select a random video from my `animated_wallpapers` directory and play it as my wallpaper

- [Hyprpaper Configuration](https://github.com/justchokingaround/dotfiles/blob/main/hypr/hyprpaper.conf) (hypr/hyprpaper.conf)
- [Change Hyprpaper Wallpaper Script](https://github.com/justchokingaround/dotfiles/blob/main/scripts/set-wallpaper.sh) (TODO: Fix that bitch)

![image](https://user-images.githubusercontent.com/44473782/221352796-9d737b1a-df7d-4ffc-8442-7df102bb330e.png)

- [Mpvpaper Next Wallpaper Keybind](https://github.com/justchokingaround/dotfiles/blob/main/hypr/configs/keybinds.conf)

TODO: add video demo for this feature
```sh
bind=$mainMod,114,exec,echo 'playlist_next' | socat - /tmp/mpvpaper-socket && current_wallpaper_resolution.sh
bind=$mainMod,113,exec,echo 'playlist_prev' | socat - /tmp/mpvpaper-socket && current_wallpaper_resolution.sh
```
Note: 114 on my system is the keybind for right arrow and 113 for left arrow. You can check the keycode for a key by running `wev` and pressing the key you want to check the keycode for.

The `current_wallpaper_resolution.sh` script is optional, it can be found here: [current_wallpaper_resolution.sh](https://github.com/justchokingaround/dotfiles/blob/main/scripts/current_wallpaper_resolution.sh) (requires ffprobe)

TODO: add `current_wallpaper_resolution.sh` screenshot

</details>

## TODO: 
- [ ] add hyprland configuration
- [ ] add documentation for keybinds
- [ ] add documentation for scripts
- [ ] add documentation for shell setup
- [ ] add documentation for waybar
- [ ] add documentation for start-wayland
- [ ] add install script
- [ ] add documentation for ytfzf
- [ ] remove: alacritty, doom emacs, kmonad, various nvim configs, 
- [ ] merge laptop config with main config using dotter