export FZF_BASE="$HOME/.fzf"
export FZF_DEFAULT_COMMAND="fd -H -t file -E '/Library/' -E 'go-workspace/' -E 'node_modules' -E 'Pictures/Photos' -E 'powercord' -E 'go/pkg' -E 'miniconda3'"
export FZF_CTRL_T_COMMAND="fd $FD_OPTIONS"
export FZF_CTRL_T_OPTS="--preview '(highlight -O ansi -l {} 2> /dev/null || cat {} || tree -C {}) 2> /dev/null | head -200'"
export FZF_CTRL_R_OPTS="--preview 'echo {}' --preview-window down:3:hidden:wrap --bind '?:toggle-preview'"
export FZF_ALT_C_COMMAND="fd --type d $FD_OPTIONS"
export FZF_ALT_C_OPTS="--preview 'tree -C {} | head -200'"
export FZF_DEFAULT_OPTS="--no-mouse --border -1 --reverse --multi --inline-info --preview='[[ \$(file --mime {}) =~ binary ]] && echo {} is a binary file || (bat --style=numbers --color=always {} || cat {}) 2> /dev/null | head -300' --preview-window='right:hidden:wrap' --bind='f3:execute(bat --style=numbers {} || less -f {}),?:toggle-preview,ctrl-d:half-page-down,ctrl-u:half-page-up,ctrl-a:select-all+accept,ctrl-y:execute-silent(echo {+} | pbcopy)'"
# export FZF_DEFAULT_OPTS='--reverse --preview "bat --color=always --style=header,grid --line-range :100 {}"'
# seq 1 1000 > /tmp/list
# fzf --bind 'ctrl-d:reload:mv /tmp/list /tmp/list-dup; grep -v ^{1}$ /tmp/list-dup | tee /tmp/list' < /tmp/list

#GRUVBOX THEME FOR FZF
export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS' --color=fg:#ebdbb2,bg:#282828,hl:#cc241d --color=fg+:#fbf1c7,bg+:#282828,hl+:#fb4934 --color=info:#98971a,prompt:#d79921,pointer:#b16286 --color=marker:#b8bb26,spinner:#fabd2f,header:#d3869b'
