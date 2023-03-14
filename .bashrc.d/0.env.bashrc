set -o vi

export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export TERM=xterm-256color

export EDITOR="/opt/homebrew/bin/nvim"

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

# Print the timestamp of each command
# HISTTIMEFORMAT='%F %T '

# Set no limit for history file size
HISTFILESIZE=5000

# Do not store a duplicate of the last entered command
HISTCONTROL=ignoredups

# Disable husky locally
export HUSKY=0

GIT_MACHETE_REBASE_OPTS="--autosquash"

export CONSUL_HTTP_TOKEN_FILE=$HOME/.config/bbc/.onelogin-id-token
export CONSUL_HTTP_ADDR=https://consul.tools-1.blbl.cr

[ -f .private-env.bashrc ] && source .private-env.bashrc

[[ -r "/opt/homebrew/etc/profile.d/bash_completion.sh" ]] && . "/opt/homebrew/etc/profile.d/bash_completion.sh"

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

if [ -d ~/.bash_completion.d ]; then
    for file in ~/.bash_completion.d/*; do
      source "$file"
  done
else
  echo "no dir"
fi

. "$HOME/.cargo/env"

# pnpm
export PNPM_HOME="/Users/g.clochard/Library/pnpm"
export PATH="$PNPM_HOME:$PATH"

# rancher
export PATH="/Users/g.clochard/.rd/bin:$PATH"

export USE_GKE_GCLOUD_AUTH_PLUGIN=True

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Run 'nvm use' automatically every time there's
# a .nvmrc file in the directory. Also, revert to default
# version when entering a directory without .nvmrc
#
enter_directory() {
  if [[ $PWD == $PREV_PWD ]]; then
   return
  fi

  PREV_PWD=$PWD
  if [[ -f ".nvmrc" ]]; then
     nvm use
     NVM_DIRTY=true
  elif [[ $NVM_DIRTY = true ]]; then
     # nvm use default
     NVM_DIRTY=false
  fi
}

export PROMPT_COMMAND=enter_directory

export STARSHIP_CONFIG=~/.config/starship/config.toml
eval "$(starship init bash)"
