### Life one ez mode

# quickly edit or run scripts from my scripts directory
se() {
  var=$(gum choose "edit" "run" --item.foreground="360" --cursor="→ ")
  script=$(find $HOME/scripts -type f|sort|fzf --height=12 --cycle -d"/" --with-nth=6.. --reverse)
  case $var in
    edit)
      printf "%s\n" "$script"|xargs nvim ;;
    run)
      sh $script ;;
  esac
}

# quickly edit zsh config stuff
nvs() {
  var=$(gum choose "zshrc" "functions" "aliases" "zshenv" --item.foreground="360" --cursor="→ ")
  case $var in
    zshrc)
      $EDITOR $HOME/dotfiles/shell/zshrc ;;
    functions)
      $EDITOR $HOME/dotfiles/shell/functions.zsh ;;
    aliases)
      $EDITOR $HOME/dotfiles/shell/aliases.zsh ;;
    zshenv)
      $EDITOR $HOME/dotfiles/shell/zshenv ;;
  esac
}

# quickly edit nvim config stuff
nvc() {
  file=$(fd . "$HOME/dotfiles/nvim/lua/config" -t f -d 1|fzf -d"/" --with-nth -1.. --height=95%)
  [ -z "$file" ] || $EDITOR $file
}


# quickly edit config files
vc() {
  file=$(fd . "$HOME/.config/" -t f|fzf -d"/" --with-nth -1.. --height=95%)
  [ -z "$file" ] || $EDITOR $file
}

# quickly copy a file or directory from ~/Downloads to current directory
cpd() {
  file=$(fd . "$HOME/dl" -t f|fzf -d"/" --with-nth -1.. --height=95%)
  [ ! -z "$file" ] && cp $file . && gum confirm "Delete the original file?" && rm $file || exit 1
}

# quickly access any alias or function i have
qa() { eval $( (alias && functions|sed -nE 's@^([^_].*)\(\).*@\1@p')|cut -d"=" -f1|fzf --reverse) }

# get cheat sheet for a command
chst() {
  [ -z "$*" ] && printf "Enter a command name: " && read -r cmd || cmd=$*
  curl -s cheat.sh/$cmd|bat --style=plain
}

# create a directory and enter it
mkcd() { mkdir -p "$1" && cd "$1"; } 

# use fzf with tree preview to go into a directory
change_folder() {
  CHOSEN=$(fd '.' -d 4 -H -t d $DIR|fzf --cycle --height=95% --preview="exa -T {}" --reverse)
  [ -z $CHOSEN ] && return 0 || cd "$CHOSEN" && [ $(ls|wc -l) -le 60 ] && ls
}

# search for file and go into its directory
ji() {
   file=$(fzf -q "$1") && dir=$(dirname "$file") && cd "$dir"
}

open_with_mpv() {
  VIDEO_PATH=$(rg --files -g '!anime/' -g '!for_editing/' -g '*.{mp4,mkv,webm,m4v}' | fzf --cycle)
    [[ -z $VIDEO_PATH ]] || (mpv "$VIDEO_PATH")
}

open_with_nvim() {
  FILE=$(rg --files -g '!*.{gif,png,jp(e)g,mp4,mkv,webm,m4v,mov,MOV}'|fzf --reverse --height 95%)
  [[ -z $FILE ]] || $1 "$FILE"
}

animes(){
  animdl stream "$1" -r "$2"
}

animeg() {
  animdl grab "$1" -r "$2" --index 1|sed -nE 's|.*stream_url": "(.*)".*|\1|p'|wl-copy
}

cchar() {
  char=$(curl -s "https://you-zitsu.fandom.com/wiki/Category:Characters"|
    grep -B6 'class="category-page__member-thumbnail "'|
    sed -nE 's_.*href="([^"]*)".*_\1_p; s_.*data-src="([^"]*)".*_\1_p; s_.*alt="([^"]*)".*_\1_p'|
    sed -e 'N;N;s/\n/\t/g' -e 's_/width/[[:digit:]]\{1,3\}_/width/800_g' \
    -e 's_/height/[[:digit:]]\{1,3\}_/height/600_g'|
    fzf --reverse --with-nth 3.. --cycle --preview="kitty +kitten icat --clear --transfer-mode file; \
    kitty +kitten icat --place "256x17@10x10" --scale-up --transfer-mode file {2}"|cut -f1)
  [ -z "$char" ] && exit 1 || images=$(curl -sL "https://you-zitsu.fandom.com"$char|
    sed -nE 's_.*src="([^"]*)".*class="pi-image-thumbnail".*alt="([^"]*)".*_\1\t\2_p')
  [ $(printf "%s" "$images"|wc -l) -lt 2 ] && kitty +kitten icat $(printf "%s" "$images"|cut -f1) ||
  printf "%s" "$images"|fzf --with-nth 2.. --cycle --preview="kitty +kitten icat --clear --transfer-mode file; \
    kitty +kitten icat --place "256x17@10x10" --scale-up --transfer-mode file {1}" > /dev/null
}

configs () {
  local search_dir=~/dotfiles
  local preview_cmd="exa -lah --sort=type --icons --no-permissions --no-filesize --no-time --no-user $search_dir/{}"

  local target_dir=$(fd . $search_dir --exact-depth=1 --type d --exec printf '{/}\0' | fzf --preview $preview_cmd --exit-0 --read0)

  if [ -n $target_dir ]; then
    cd $search_dir/$target_dir
    exa -lah --group-directories-first --icons
  fi
}

### Fzf functions

# Modified version where you can press
#   - CTRL-O to open with `open` command,
#   - CTRL-E or Enter key to open with the $EDITOR
fo() {
  IFS=$'\n' out=("$(fzf-tmux --query="$1" --exit-0 --expect=ctrl-o,ctrl-e)")
  key=$(head -1 <<< "$out")
  file=$(head -2 <<< "$out" | tail -1)
  if [ -n "$file" ]; then
    [ "$key" = ctrl-o ] && open "$file" || ${EDITOR:-vim} "$file"
  fi
}

### Other

emoji() {
  emojis=$(curl -sSL 'https://git.io/JXXO7')
  selected_emoji=$(printf "%s" $emojis|fzf --preview-window=hidden --cycle)
  [ -z "$selected_emoji" ] || printf "%s" "$selected_emoji"|cut -d" " -f1|wl-copy
} 

# pick an image with fzf and copy it to the clipboard
# ic = image copy
ic() {
  image=$(fd -t f -d 1 --extension png --extension jpg --extension jpeg --extension webm|
    fzf -0 --cycle --preview="kitty +kitten icat --clear --transfer-mode file; \
  kitty +kitten icat --place "256x17@10x10" --scale-up --transfer-mode file {}")
  [ -z "$image" ] || wl-copy "$image"
}

# pick and image with fzf and quickly share it
# is = image share
is() {
  image=$(fd -t f -d 1|fzf --cycle --preview="kitty +kitten icat --clear --transfer-mode file; \
  kitty +kitten icat --place "256x17@10x10" --scale-up --transfer-mode file {}")
  [ -z "$image" ] || printf $(curl -# "https://0x0.st" -F "file=@${image}")|pbcopy
}

#nnn -c to activate disables -e

nn () {
    # Block nesting of nnn in subshells
    if [ -n $NNNLVL ] && [ "${NNNLVL:-0}" -ge 1 ]; then
        echo "nnn is already running"
        return
    fi

    # The behaviour is set to cd on quit (nnn checks if NNN_TMPFILE is set)
    # To cd on quit only on ^G, either remove the "export" as in:
    #    NNN_TMPFILE="${XDG_CONFIG_HOME:-/home/daru/.config}/nnn/.lastd"
    #    (or, to a custom path: NNN_TMPFILE=/tmp/.lastd)
    # or, export NNN_TMPFILE after nnn invocation
    export NNN_TMPFILE="${XDG_CONFIG_HOME:-/home/chokerman/.config}/nnn/.lastd"

    # Unmask ^Q (, ^V etc.) (if required, see stty -a) to Quit nnn
    # stty start undef
    # stty stop undef
    # stty lwrap undef
    # stty lnext undef

    nnn -cda "$@"
    #nnn -cdHa "$@" -P v

    if [ -f "$NNN_TMPFILE" ]; then
            . "$NNN_TMPFILE"
            rm -f "$NNN_TMPFILE" > /dev/null
    fi
}

addpkg(){
    paru -Ss "$*" | sed -nE 's|^[a-z]*/([^ ]*).*|\1|p' | fzf --preview 'paru -Si {} | bat --language=yaml --color=always -pp' --preview-window right:65%:wrap -m | paru -S -
}

rmpkg(){
    paru -Qq | fzf --preview 'paru -Si {} | bat --language=yaml --color=always -pp' --preview-window right:65%:wrap -m | paru -Rcns -
}

# Update all Wallpapers
# TODO port to linux

# wallpaper() {
#   sqlite3 ~/Library/Application\ Support/Dock/desktoppicture.db "update data set value = '$(readlink -f $1)'" && killall Dock 
# }
#
# choose_wallpaper() {
#   sqlite3 ~/Library/Application\ Support/Dock/desktoppicture.db \
#     "update data set value = '$(find $HOME/Pictures/wallpapers -type f|
#     fzf --cycle -d"/" --with-nth=6.. --preview="kitty +kitten icat --clear \
#       --transfer-mode file; kitty +kitten icat --place "256x17@10x10" --transfer-mode file {}"
# )'" && killall Dock 
# }
#
