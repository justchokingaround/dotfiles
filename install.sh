#!/bin/sh

su -
# pacman -S git --needed base-devel --noconfirm
# curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- --default-toolchain none -y
# . "$HOME/.cargo/env"
# rustup default stable
# pacman -S rustup
# git clone https://aur.archlinux.org/paru.git || exit
# cd paru || exit
# makepkg -si --noconfirm || exit

paru -S hyprland neovim xdg-desktop-portal-hyprland-git wireplumber pipewire qt5-wayland \
    qt6-wayland polkit-gnome playerctl slurp wl-clipboard libsixel pamixer networkmanager \
    eww-wayland bat bottom doas exa ffmpegthumbnailer fzf hyprpicker-git lazygit mlocate \
    mpd mpdris2 nautilus nsxiv pavucontrol swappy starship wev zoxide zsh ffmpeg \
    discord sidekick-browser-stable-bin grimblast-git mpvpaper git mako mpv socat neovim rofi \
    spotify-player alacritty-sixel-git wezterm wf-recorder zathura zathura-pdf-mupdf \
    phocus-gtk-theme-git xplr nwg-looks we10x-icon-theme-git copyq geticons swww --noconfirm --nouseask

# setting up doas
echo "permit nopass :wheel" | tee -a /etc/doas.conf
# changing /bin/sh to dash
ln -sfT dash /usr/bin/sh
echo "[Trigger]
Type = Package
Operation = Install
Operation = Upgrade
Target = bash

[Action]
Description = Re-pointing /bin/sh symlink to dash...
When = PostTransaction
Exec = /usr/bin/ln -sfT dash /usr/bin/sh
Depends = dash" | tee /usr/share/libalpm/hooks/dashbinsh.hook
# setting doas as sudo symlink
ln -sfT /bin/doas /bin/sudo

# changing the default shell of user to zsh
chsh $USER -s /bin/zsh
# cleanup
rm $HOME/.bash*
su - $USER
