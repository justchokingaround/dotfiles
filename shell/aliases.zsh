### File managing aliases

alias dl='cd ~/dl'
alias dox='cd ~/dox'
alias ..='cd ..'
alias ../..='cd ../..'
alias ../../..='cd ../../..'
alias ../../../..='cd ../../../..'
alias ../../../../..='cd ../../../../..'
alias cd..="cd .."
alias mv="mv -i"
alias rm="gio trash"
alias rst="trash-restore"
alias trash="gio trash --list"
alias trash-empty="gio trash --empty"
alias ls='exa'
alias ll='exa -Fal'
alias l='exa --long --grid'
alias lh="exa -a"
alias tree='exa -T'
alias grep="grep --color=auto --exclude-dir={.bzr,CVS,.git,.hg,.svn}"
alias rd='rm -rI "$(exa -D| fzf --height=20% --preview="exa -l {}")"'
alias cx='chmod +x "$(rg --files -g "*.sh"|fzf -1 --height=20% --preview-window=hidden)"'
# alias v='neovide'
# alias nv='neovide'
alias v='nvim'
alias nv='nvim'
alias neovide="env WINIT_UNIX_BACKEND=x11 neovide"
alias ni="env WINIT_UNIX_BACKEND=x11 neovide"
alias vg='nvim $(gum filter)'
alias f="fzf"
alias ra="ranger"
alias x="xplr"
alias gpt="sgpt"
alias j=z
alias jj="cd -"
alias zj="zellij -s"
# alias time="hyperfine"

### Suffix aliases
alias -s md=nvim
alias -s mp4=mpv
alias -s mp3=mpv
alias -s mkv=mpv
alias -s jpg=open
alias -s pdf=mupdf-gl

### Media aliases

alias trackma='trackma -a 1'
alias mpvq="mpv --no-video"
alias watchgoodedits='cd "$(fd . "$HOME/videos/good_edits" --max-depth 1 --type d|fzf --cycle)" && mpv *'

### yt-dlp aliases
# don't forget to download ffmpeg :/

alias ytdl="yt-dlp -f 'bv*+ba' --embed-thumbnail --embed-subs --merge-output-format mp4"
alias ytdl-mp3="yt-dlp --embed-metadata --extract-audio --audio-format mp3 --audio-quality 0 --embed-thumbnail"
alias ytdlist="yt-dlp -f 'bv*[height=1080]+ba'"

### Other aliases

# quickly share a file
alias share='printf $(curl -# "https://oshi.at" -F "f=@$(fd -t f -d 1|fzf)"|sed -nE "s_DL: (.*)_\1_p")|wl-copy'
alias fzf-preview='printf "fzf --with-nth 2.. --cycle --preview=\"kitty +kitten icat --clear --transfer-mode file;\
  kitty +kitten icat --place "190x12@10x10" --scale-up --transfer-mode file {1}\""|wl-copy'
alias weather="curl -s wttr.in/Heilbronn"
alias pf='pfetch'
alias nft='neofetch --kitty ~/.config/neofetch/neofetch.jpeg --size 30%'
alias nf='macchina'
alias py='python3'
alias pip='pip3'
# alias u="zsh &&    echo -ne '\e[5 q'"
alias u="zsh"
alias myip="curl ipinfo.io/ip"
alias ytfzf="ytfzf -T swayimg-hyprland -t"
alias ytm="ytfzf -m"
alias nvf="open_with_nvim nvim"
alias nvff="open_with_nvim_filetype nvim"
alias nif="open_with_nvim env WINIT_UNIX_BACKEND=x11 neovide"
alias niff="open_with_nvim_filetype env WINIT_UNIX_BACKEND=x11 neovide"
alias sudo="doas"
alias sudoedit="doas rnano"
alias hx="helix"
alias epy="py ~/dev/epy/epy.py"

alias mpf="open_with_mpv"
alias nb="newsboat"
alias -g L='| less'
alias -g C='| pbcopy'
alias -g S="| sed"
alias -g F="| fzf"
alias -g B="| bat"
alias -g J="| jq"
