export FZF_DEFAULT_COMMAND="rg ~ --files --hidden"

# Oxocarbon theme
export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS' --color=fg:#ffffff,bg:-1,hl:#08bdba --color=fg+:#f2f4f8,bg+:-1,hl+:#3ddbd9 --color=info:#78a9ff,prompt:#33b1ff,pointer:#42be65 --color=marker:#ee5396,spinner:#ff7eb6,header:#be95ff
  --reverse --border=rounded
'

export FZF_ALT_C_COMMAND="fd -t d -d 1"
export FZF_ALT_C_OPTS="--preview 'tree -C {}|head -200' --height=60%"
# export FZF_PREVIEW_ADVANCED=true

# disable sort when completing `git checkout`
zstyle ':completion:*:git-checkout:*' sort false
# set descriptions format to enable group support
zstyle ':completion:*:descriptions' format '[%d]'
# set list-colors to enable filename colorizing
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
# switch group using `,` and `.`
zstyle ':fzf-tab:*' switch-group ',' '.'
# to fix stupid one line preview
zstyle ':fzf-tab:*' popup-pad 20 0
zstyle ':fzf-tab:*' fzf-pad 4

# preview stuff
# zstyle ':fzf-tab:complete:cd:*' fzf-preview 'exa -1 --color=always $realpath' # remember to use single quote here!!!
# zstyle ':fzf-tab:complete:systemctl-*:*' fzf-preview 'SYSTEMD_COLORS=1 systemctl status $word'
# zstyle ':fzf-tab:complete:*:*' fzf-preview 'less ${(Q)realpath}'
export LESSOPEN='|~/dotfiles/shell/lessfilter.sh %s'
