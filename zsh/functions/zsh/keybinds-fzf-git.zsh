# vim: set ft=zsh ts=2 sw=2 sts=2 et nu fenc=utf-8:

join-lines() {
  local item
  while read item; do
    echo -n "${(q)item} "
  done
}

bind-git-helper() {
  local c
  for c in $@; do
    eval "fzf-_g$c-widget() { local result=\$(_g$c | join-lines); zle reset-prompt; LBUFFER+=\$result }"
    eval "zle -N fzf-_g$c-widget"
    eval "bindkey '^g^$c' fzf-_g$c-widget"
  done
}
bind-git-helper f b t r h
unset -f bind-git-helper
