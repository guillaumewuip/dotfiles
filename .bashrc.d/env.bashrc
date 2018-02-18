
# Ruby
export RBENV_ROOT="$(brew --prefix rbenv)"
export GEM_HOME="$(brew --prefix)/opt/gems"
export GEM_PATH="$(brew --prefix)/opt/gems"
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi

export EDITOR="/usr/bin/vim"

# Extend cf tab completion
export CDPATH=$CDPATH:.
export CDPATH=$CDPATH:/Users/Guillaume/Documents/Informatique/Web/
export CDPATH=$CDPATH:/Users/Guillaume/Documents/Scolaire/5A/S9/
export CDPATH=$CDPATH:/Users/Guillaume/Documents/Scolaire/5A/DU/dev/

# enables extended globbing, usefull for ls !(*.*)
shopt -s extglob

### Go GVM
[[ -s "~/.gvm/scripts/gvm" ]] && source "~/.gvm/scripts/gvm"

[ -f ~/.env_global ] && source ~/.env_global

[ -f /usr/local/etc/bash_completion ] && . /usr/local/etc/bash_completion

