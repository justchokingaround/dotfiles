### gh cli stuff
checkoutpr() {
  gh pr list | fzf --ansi --preview 'gh pr view {1}' --preview-window down --header-lines 3 | cut -d\  -f1 | xargs gh pr checkout
}

myprs(){
  gh search prs --author @me --state open | fzf --ansi --preview 'gh pr view --repo {1} {2}' --preview-window=80%:down --header-lines 4 | sed -nE "s@[^#]*#([0-9]*).*@\1@p"
}

# quickly access any alias or function i have
qa() {
  eval $( (alias && functions | sed -nE 's@^([^_].*)\(\).*@\1@p') | cut -d"=" -f1 | fzf --reverse)
}

# get cheat sheet for a command
chst() {
  [ -z "$*" ] && printf "Enter a command name: " && read -r cmd || cmd=$*
  curl -s cheat.sh/$cmd|bat --style=plain
}

# create a directory and enter it (i use this daily)
mkcd() {
  mkdir -p "$1" && cd "$1";
}

# clone a git repo and enter it (i also use this daily)
gc() {
  git clone "$1" && cd "$(basename "$1" .git)"
}

### aur stuff
addpkg(){
    paru -Ss "$*" | sed -nE 's|^[a-z]*/([^ ]*).*|\1|p' | fzf --preview 'paru -Si {} | bat --language=yaml --color=always -pp' --preview-window right:65%:wrap -m | paru -S -
}

rmpkg(){
    paru -Qq | fzf --preview 'paru -Si {} | bat --language=yaml --color=always -pp' --preview-window right:65%:wrap -m | paru -Rcns -
}


### quickly navigate to a dir in my dotfiles
dots() {
  search_dir=~/dotfiles/
  preview_cmd="exa -lah --sort=type --icons --no-permissions --no-filesize --no-time --no-user $search_dir/{}"

  target_dir=$(fd . $search_dir --exact-depth=1 --type d --exec printf '{/}\0' | fzf --cycle --preview $preview_cmd --exit-0 --read0)

  if [ -n $target_dir ]; then
    cd $search_dir/$target_dir
    exa -lah --group-directories-first --icons
  fi
}

transfer() {
  if tty -s; then
    file="$1"
    file_name=$(basename "$file")
    
    if [ ! -e "$file" ]; then
      echo "$file: No such file or directory" >&2
      return 1
    fi
    
    if [ -d "$file" ]; then
      file_name="$file_name.zip"
      (
        cd "$file" && zip -r -q - .
      ) | curl --progress-bar --upload-file "-" "https://transfer.sh/$file_name" | tee /dev/null | grep https | wl-copy
    else
      cat "$file" | curl --progress-bar --upload-file "-" "https://transfer.sh/$file_name" | tee /dev/null | grep https | wl-copy
    fi
  else
    file_name=$1
    curl --progress-bar --upload-file "-" "https://transfer.sh/$file_name" | tee /dev/null | grep https | wl-copy
  fi
}

