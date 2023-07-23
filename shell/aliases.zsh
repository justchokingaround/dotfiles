### File managing aliases
alias ..='cd ..'
alias ../..='cd ../..'
alias ../../..='cd ../../..'
alias ../../../..='cd ../../../..'
alias ../../../../..='cd ../../../../..'
alias mv="mv -i"
alias ls='exa'
alias ll='exa -Fal'
alias l='exa --long --grid'
alias lh="exa -a"
alias tree='exa -T'
alias grep="grep --color=auto --exclude-dir={.bzr,CVS,.git,.hg,.svn}"
alias v='NVIM_APPNAME=nvimdots nvim'
alias nv='nvim'
alias x="xplr"
alias j=z
alias jj="cd -"
alias zj="zellij -s"
alias ze="zellij"

### Git aliases
alias gp="git pull"
alias grhh="git reset --hard HEAD"
alias gci="git commit"
alias gap="git add --patch"
alias lg="lazygit"

### Media aliases
alias lf='lfub'
alias mpvq="mpv --no-video"
alias music="zellij --layout=$HOME/.config/ncmpcpp/music.kdl"
alias n='ncmpcpp'
alias y='youtube-tui'

### yt-dlp aliases
alias ytdl="yt-dlp -f 'bv*+ba' --embed-thumbnail --embed-subs --merge-output-format mp4"
alias ytdl-mp3="yt-dlp --embed-metadata --extract-audio --audio-format mp3 --audio-quality 0 --embed-thumbnail"
alias ytdlist="yt-dlp -f 'bv*[height=1080]+ba'"

### Other aliases
alias weather="curl -s wttr.in/Stuttgart"
alias nf='neofetch'
alias na="navi --cheatsh"
alias py='python3'
alias pip='pip3'
alias myip="curl ipinfo.io/ip"
alias p="paru"
