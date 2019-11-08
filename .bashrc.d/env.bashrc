export EDITOR="/usr/local/bin/nvim -u ~/.vim/.vimrc.git --noplugin"

export BASH_SILENCE_DEPRECATION_WARNING=1

# Extend cf tab completion
export CDPATH=$CDPATH:.

# enables extended globbing, usefull for ls !(*.*)
shopt -s extglob

export FZF_DEFAULT_COMMAND='
  (git ls-tree -r --name-only HEAD ||
   find . -path "*/\.*" -prune -o -type f -print -o -type l -print |
      sed s/^..//) 2> /dev/null'

export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

set -o vi
[ -f ~/.fzf.bash ] && source ~/.fzf.bash
