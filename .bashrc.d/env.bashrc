export EDITOR="/usr/local/bin/nvim -u ~/.vim/.vimrc.git --noplugin"

export BASH_SILENCE_DEPRECATION_WARNING=1

# Extend cf tab completion
export CDPATH=$CDPATH:.

# enables extended globbing, usefull for ls !(*.*)
shopt -s extglob

# Setting fd as the default source for fzf
export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'

# To apply the command to CTRL-T as well
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

# Configure BASH to append (rather than overwrite the history):
shopt -s histappend

# Configure BASH to append (rather than overwrite the history):
shopt -s histappend

# Print the timestamp of each command
# HISTTIMEFORMAT='%F %T '

# Set no limit for history file size
HISTFILESIZE=5000

# Do not store a duplicate of the last entered command
HISTCONTROL=ignoredups

set -o vi
[ -f ~/.fzf.bash ] && source ~/.fzf.bash
