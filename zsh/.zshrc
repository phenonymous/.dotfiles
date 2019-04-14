# vim:ft=zsh ts=2 sw=2 sts=2 et fenc=utf-8
#-- Compile this script if it's newer than
#-- the compiled version
{
  0="${${ZERO:-${0:#$ZSH_ARGZERO}}:-${(%):-%N}}"
  [[ ! -s $0.zwc || "$0.zwc" -ot $0 ]] &&\
    zcompile -R $0
} &!

################################################
# * Fix for VTE only loading for login shells
# *
################################################
if [[ -v TILIX_ID || -v VTE_VERSION ]] \
  source /etc/profile.d/vte.sh

################################################
# * aliases
# * 
################################################
source ${ZDOTDIR}/.zsh_aliases

################################################
# * Load completion system
# *
################################################
autoload -Uz compinit

#-- Only check cache once a day (modified)
#-- https://gist.github.com/ctechols/ca1035271ad134841284
setopt extendedglob

if [[ -n $ZSH_COMPDUMP(#qNwm+1) ]]; then
  compinit -i -d $ZSH_COMPDUMP
else
  compinit -C -d $ZSH_COMPDUMP
fi

[[ -w $ZSH_COMPDUMP && ( ! -s $ZSH_COMPDUMP.zwc || $ZSH_COMPDUMP.zwc -ot $ZSH_COMPDUMP ) ]] &&\
  {
    zcompile $ZSH_COMPDUMP
    zcompile $ZSH_COMP_CACHE_DIR ${ZSH_COMP_CACHE_DIR}/*
  } &!

zstyle ':completion:*' accept-exact '*(N)'

################################################
# * Check if we have outdated .zwc files in our
# * local fpath
# *
################################################
{
  autoload -Uz funcupdate
  funcupdate
  unfunction funcupdate
} &!

################################################
# * Load antibody
# *
################################################
export ANTIBODY_HOME=${ZSH_CACHE_DIR}/antibody
{
  autoload -Uz antiupdate
  antiupdate
  unfunction antiupdate
} &!

unsetopt extendedglob

[[ -r ${ZDOTDIR}/.zsh_plugins ]] && source ${ZDOTDIR}/.zsh_plugins

################################################
# * Load various lib filse
# *
################################################
autoload -Uz nerdinit \
             harden
nerdinit

#####################[git-prompt]###############
# * Load zsh-git-promt
# * https://github.com/starcraftman/zsh-git-prompt
# * https://upload.wikimedia.org/wikipedia/commons/1/15/Xterm_256color_chart.svg
# *
# * Non-git prompt originally by Mayccoll https://gitlab.com/Mayccoll/Linux-Utils
# *
###############################################
[[ -r ${ZDOTDIR}/lib/zsh-git-prompt/zshrc.sh  ]] && source ${ZDOTDIR}/lib/zsh-git-prompt/zshrc.sh


if [[ $EUID -ne 0 ]]; then
# no root
PROMPT='
%F{blue}%{%G%} %F{243}  %~ %f $(git_super_status &!)
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
