################################################
# * Skip calling compinit in /etc/zsh/zshrc
# *
################################################
export skip_global_compinit=1

#--
export GPG_TTY=$(tty)

#--
typeset -gU fpath PATH

################################################
# * Export other paths
# *
################################################
PATH="$PATH:$ZDOTDIR:$HOME/.local/bin"

################################################
# * add local fpath
# *
################################################
fpath+=($ZDOTDIR/functions/lxchelper $ZDOTDIR/functions/misc $ZDOTDIR/functions/nerdfonts $ZDOTDIR/completions)

################################################
# * Environment variables
# *
################################################
HISTFILE=${ZDOTDIR}/.zsh_history


################################################
# * aliases
# * 
################################################
source ${ZDOTDIR}/.zsh_aliases


################################################
# * Profile
# *
################################################
PARENT="$(ps -h -o comm -p $PPID)"
if [[ "$PARENT" = "plugin_host" ]]; then
  source ~/.gitprojects/pl-omg/vcsprompt
else  
  source ${ZDOTDIR}/.zshrc
fi
# Do not source any further
set -f
