# vim:ft=zsh ts=2 sw=2 sts=2 et fenc=utf-8
#-- Compile this script if it's newer than
#-- the compiled version
{
  0="${${ZERO:-${0:#$ZSH_ARGZERO}}:-${(%):-%N}}"
  [[ -w $0 && ( ! -s $0.zwc || "$0.zwc" -ot $0 ) ]] &&\
    zcompile -R $0
} &!

#-- Set path of zsh dotfiles
ZDOTDIR="$HOME/.dotfiles/zsh"

#-- Set correct terminal locale
export LANGUAGE=en

################################################
# * Faster sourcing
# * 
################################################
#-- This will be slower the first time it is run
source () {
  [[ -w $1 && ( ! -s "$1.zwc" || "$1.zwc" -ot $1 ) ]] &&\
    zcompile -R $1 &!
  builtin . $@
}

. () {
  [[ -w $1 && ( ! -s "$1.zwc" || "$1.zwc" -ot $1 ) ]] &&\
    zcompile -R $1 &!
  builtin . $@
}

if [[ ( $SHLVL == 1 && ! -o LOGIN ) || -o INTERACTIVE ]]; then
 . $ZDOTDIR/.zprofile
fi
