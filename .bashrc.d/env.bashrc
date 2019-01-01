export EDITOR="/usr/bin/vim"

# Extend cf tab completion
export CDPATH=$CDPATH:.
export CDPATH=$CDPATH:/Users/Guillaume/Documents/Informatique/Web/

# enables extended globbing, usefull for ls !(*.*)
shopt -s extglob

set -o vi
[ -f ~/.fzf.bash ] && source ~/.fzf.bash

