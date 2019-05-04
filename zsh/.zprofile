# vim:ft=zsh ts=2 sw=2 sts=2 et fenc=utf-8
################################################
# * Skip calling compinit in /etc/zsh/zshrc
# *
################################################
setopt noglobalrcs
skip_global_compinit=1

#--
export GPG_TTY=$(tty)

#--
typeset -gU cdpath fpath path

################################################
# * add other paths
# *
################################################
path=($ZDOTDIR $HOME/.local/bin /snap/bin $path)

################################################
# * add local fpath
# *
################################################
fpath=($ZDOTDIR/functions/lxchelper $ZDOTDIR/functions/misc $ZDOTDIR/functions/nerdfonts $ZDOTDIR/completions $fpath)

################################################
# * Environment variables
# *
################################################
HISTFILE=${ZDOTDIR}/.zsh_history
ZSH_CACHE_DIR=${ZDOTDIR}/cache
ZSH_COMPDUMP=${ZSH_CACHE_DIR}/.zcompdump
ZSH_COMP_CACHE_DIR=${ZSH_CACHE_DIR}/.zcompcache

################################################
# * Terminal enviorment variables
# *
################################################
#-- Set correct terminal locale
export LANGUAGE=en
#-- Check fzf location for OMZ
if [[ ! -d $HOME/.fzf ]] \
  export FZF_BASE=${ZDOTDIR}/lib/fzf
#--
export ANTIBODY_HOME=${ZSH_CACHE_DIR}/antibody

################################################
# * Profile
# *
################################################
if [[ "$TERMINAL" = "SUBLIME" ]]; then
 source ~/.gitprojects/pl-omg/vcsprompt
 set -f
fi
