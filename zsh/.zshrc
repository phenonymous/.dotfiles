# vim:ft=zsh ts=2 sw=2 sts=2 et fenc=utf-8
#-- Compile this script if it's newer than
#-- the compiled version
{
  0="${${ZERO:-${0:#$ZSH_ARGZERO}}:-${(%):-%N}}"
  [[ -w $0 && ( ! -s $0.zwc || "$0.zwc" -ot $0 ) ]] &&\
    zcompile -R $0
} &!

################################################
# * Fix for VTE only loading for login shells
# *
################################################
if [[ -v TILIX_ID || -v VTE_VERSION ]] \
  source /etc/profile.d/vte.sh

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
#{
#  autoload -Uz funcupdate
#  funcupdate
#  unfunction funcupdate
#} &!

################################################
# * Load antibody and plugins
# *
################################################
{
  autoload -Uz antiupdate
  antiupdate
  unfunction antiupdate
} &!

unsetopt extendedglob

#-- ohmyzsh related settings
SHORT_HOST=${HOST/.*/}

#-- enable ssh-agent and gpg-agent
zstyle :omz:plugins:keychain agents gpg,ssh
zstyle :omz:plugins:keychain identities id_ecdsa id_unifi 06E4ED455EDC3E3F6AA59BF58B31FB567A614394
zstyle :omz:plugins:ssh-agent agent-forwarding on

[[ -r ${ZDOTDIR}/.zsh_plugins ]] && source ${ZDOTDIR}/.zsh_plugins
if [[ -d ${ZDOTDIR}/lib/fzf ]]; then
  source ${ZDOTDIR}/functions/zsh/fzf-git.zsh
  source ${ZDOTDIR}/functions/zsh/keybinds-fzf-git.zsh
fi

################################################
# * Load various lib files
# *
################################################
autoload -Uz nerdinit \
             harden
nerdinit

################################################
# * Load hooks
# *
################################################
eval "$(direnv hook zsh)"

################################################
# * aliases
# * 
################################################
source ${ZDOTDIR}/.zsh_aliases

#####################[git-prompt]###############
# * Load zsh-git-prompt
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

#-- This restores the builtins
(( $+functions[source] )) && unfunction source
(( $+functions[.] )) && unfunction .
