# 0="${${ZERO:-${0:#$ZSH_ARGZERO}}:-${(%):-%N}}"
# [[ -a "$0.zwc" ]] || zcompile -R $0
# [[ "$0.zwc" -ot $0 ]] && zcompile -R $0
################################################
# * Fix for VTE only loading for login shells
# *
################################################
if [[ -v TILIX_ID ]] || [[ -v VTE_VERSION ]] \
  source /etc/profile.d/vte.sh


################################################
# * Load antibody
# *
################################################
#-- Only check cache once a day
#-- https://gist.github.com/ctechols/ca1035271ad134841284
autoload -Uz compinit 
if [[ -n ${ZDOTDIR}/.zcompdump(#qN.mh+24) ]]; then
  compinit
else
  compinit -C
fi

source ${ZDOTDIR}/.zsh_plugins.sh


#####################[git-prompt]###############
# * Load zsh-git-promt
# * https://github.com/starcraftman/zsh-git-prompt
# * https://upload.wikimedia.org/wikipedia/commons/1/15/Xterm_256color_chart.svg
# *
# * Non-git prompt originally by Mayccoll https://gitlab.com/Mayccoll/Linux-Utils
# *
###############################################
[[ -r $HOME/.zsh-git-prompt/zshrc.sh  ]] && source $HOME/.zsh-git-prompt/zshrc.sh


if [[ $EUID -ne 0 ]]; then
# no root
PROMPT='
%F{blue} ﰣ %F{243}  %/ %{$reset_color%} $(git_super_status)
%F{yellow} %F{green} %F{red} %f'
RPROMPT='%F{240} %n %F{yellow}  %F{240}%m  %F{243} %T  %{$reset_color%}'
else
# root
PROMPT='
%F{11}   %F{236}  %/ %{$reset_color%} $(git_super_status)
%{$fg[white]%} %{$fg[white]%} %{$fg[white]%} %F{255}'
RPROMPT='%{$fg[black]%} %n %F{yellow}  %{$fg[black]%}%m  %F{243} %T  %{$reset_color%}'
fi


#-- Wrapper functions set in ~/.zshenv
#-- This restores the builtins
unfunction source
unfunction .
