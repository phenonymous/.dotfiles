# vim:ft=zsh ts=2 sw=2 sts=2 et fenc=utf-8
#--
export GPG_TTY=$(tty)

#--
typeset -gU cdpath fpath path

################################################
# * Directory shortnames
# *
################################################
hash -d dd=${HOME}/.dotfiles
hash -d zd=${ZDOTDIR}
hash -d zf=${ZDOTDIR}/functions
hash -d zc=${ZDOTDIR}/completions
hash -d zl=${ZDOTDIR}/lib
hash -d vd=${VIMDOTDIR}

################################################
# * Environment variables
# *
################################################
HISTFILE=${ZDOTDIR}/.zsh_history
ZSH_CACHE_DIR=${ZDOTDIR}/cache
ZSH_COMPDUMP=${ZSH_CACHE_DIR}/.zcompdump
ZSH_COMP_CACHE_DIR=${ZSH_CACHE_DIR}/.zcompcache

#################################################
# * Environment variables (global)
# *
################################################
# export http_proxy="0.0.0.0:7331"
# export https_proxy="0.0.0.0:7331"
# export HTTP_PROXY="0.0.0.0:7331"
# export HTTPS_PROXY="0.0.0.0:7331"

################################################
# * add other paths
# *
################################################
path=(~zd ~dd/pseudofs/usr/bin $HOME/.gem/ruby/2.5.0/bin $HOME/.local/bin /snap/bin $path)

################################################
# * add local fpath
# *
################################################
fpath=(~zd ~zf/helpers ~zf/misc ~zf/nerdfonts $fpath)

################################################
# * Terminal enviorment variables
# *
################################################
#-- Set correct terminal locale
export LANGUAGE=en_US.UTF-8
export PATH FPATH

#-- Check fzf location for OMZ
if [[ ! -d $HOME/.fzf ]] \
  export FZF_BASE=~zl/fzf
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
