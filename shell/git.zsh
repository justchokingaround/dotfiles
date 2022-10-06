git config --global user.name "justchokingaround"
git config --global user.email "ivanonarch@tutanota.com"

alias gp="git pull"
alias grhh="git reset --hard HEAD"

gc() {
  git clone "$1" && cd "$(basename "$1" .git)"
}
