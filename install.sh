#!/bin/sh

generate_local_toml() {
    cat <<EOF
packages = [
"default-applications",
"wayland",
"alacritty",
"wezterm",
"zellij",
"shell",
"scripts",
"starship",
"nvim",
"vscode",
"bat",
"lazygit",
"gh",
"mpd",
"mpdris2",
"ncmpcpp",
"spotify-player",
"mpv",
"zathura",
"xplr",
"rofi",
"mako",
"fonts",
"neofetch",
"iamb",
"copyq",
"graphics",
"multimonitor",
]
EOF
}

lobster_config_stuff() {
    cat <<EOF
image_config_path="$HOME/.config/rofi/styles/launcher.rasi"
rofi_prompt_config="$HOME/.config/rofi/styles/prompt.rasi"
EOF
}

case "$1" in
    --pre)
        # As chroot, go into /home/$USER

        pacman -S git --needed base-devel --noconfirm
        curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- --default-toolchain none -y
        pacman -S rustup --noconfirm
        ;;

    --post)
        # This part as user

        rustup default stable
        git clone https://aur.archlinux.org/paru.git || exit
        cd paru || exit
        makepkg -si --noconfirm || exit

        printf "1\n" | paru -S mpdris2 --noconfirm
        printf "1\n" | paru -S mpvpaper --noconfirm
        printf "1\n" | paru -S spotify-player --noconfirm
        printf "1\n" | paru -S geticons --noconfirm
        printf "1\n" | paru -S swww --noconfirm
        paru -S hyprland neovim xdg-desktop-portal xdg-desktop-portal-hyprland wireplumber pipewire qt5-wayland \
            qt6-wayland polkit-gnome playerctl slurp wl-clipboard libsixel pamixer networkmanager \
            eww-wayland bat bottom doas exa ffmpegthumbnailer fzf hyprpicker-git lazygit mlocate \
            mpd nautilus nsxiv pavucontrol swappy starship zoxide zsh ffmpeg \
            discord sidekick-browser-stable-bin grimblast-git git mako mpv socat neovim rofi \
            alacritty-sixel-git wezterm wf-recorder zathura zathura-pdf-mupdf \
            phocus-gtk-theme-git xplr lobster-git nwg-look-bin we10x-icon-theme-git copyq swww \
            ueberzugpp html-xml-utils luarocks ncmpcpp --noconfirm
        ;;

    --dots)
        git clone https://github.com/justchokingaround/dotfiles
        cd dotfiles || exit
        # changing the default shell of user to zsh
        chsh $USER -s /bin/zsh
        # cleanup
        rm $HOME/.bash*
        generate_local_toml >.dotter/local.toml
        ./dotter deploy
        sed "s@source=~/.config/hypr/configs/monitors.conf@@" -i hyprland/hypr/hyprland.conf
        sed "s@exec-once  = ~/.config/hypr/scripts/autostart.sh@@" -i hyprland/hypr/configs/window_rules.conf
        test -d "$HOME/dotfiles/shell/plugins/fzf-tab" && rm -rf "$HOME/dotfiles/shell/plugins/fzf-tab"
        git clone "https://github.com/Aloxaf/fzf-tab" "$HOME/dotfiles/shell/plugins/fzf-tab"
        test -d "$HOME/dotfiles/shell/plugins/forgit" && rm -rf "$HOME/dotfiles/shell/plugins/forgit"
        git clone "https://github.com/wfxr/forgit" "$HOME/dotfiles/shell/plugins/forgit"
        mkdir -p "$HOME/.cargo/env"
        fc-cache
        echo "monitor=,addreserved,30,0,0,0" >>"$HOME/.config/hypr/hyprland.conf"
        sed 's@version = "0.20.1"@version = "0.21.2"@' -i "$HOME/.config/xplr/init.lua"
        mkdir -p "$HOME/.config/lobster/"
        curl -s "https://raw.githubusercontent.com/justchokingaround/lobster/main/examples/lobster_config.txt" >"$HOME/.config/lobster/lobster_config.txt"
        lobster_config_stuff >>"$HOME/.config/lobster/lobster_config.txt"
        ;;
esac
