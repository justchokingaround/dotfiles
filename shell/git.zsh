alias gp="git pull"
alias grhh="git reset --hard HEAD"
alias lg="lazygit"

gc() {
  git clone "$1" && cd "$(basename "$1" .git)"
}
