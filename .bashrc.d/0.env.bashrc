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

export STARSHIP_CONFIG=~/.config/starship/config.toml
eval "$(starship init bash)"

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

nvm_path=$(nvm_find_up .nvmrc | tr -d '\n')

# If there are no .nvmrc file, use the default nvm version
if [[ -s $nvm_path/.nvmrc && -r $nvm_path/.nvmrc ]]; then
  declare nvm_version
  nvm_version=$(<"$nvm_path"/.nvmrc)

  declare locally_resolved_nvm_version
  # `nvm ls` will check all locally-available versions
  # If there are multiple matching versions, take the latest one
  # Remove the `->` and `*` characters and spaces
  # `locally_resolved_nvm_version` will be `N/A` if no local versions are found
  locally_resolved_nvm_version=$(nvm ls --no-colors "$nvm_version" | tail -1 | tr -d '\->*' | tr -d '[:space:]')

  # If it is not already installed, install it
  # `nvm install` will implicitly use the newly-installed version
  if [[ "$locally_resolved_nvm_version" == "N/A" ]]; then
      nvm install "$nvm_version";
  elif [[ $(nvm current) != "$locally_resolved_nvm_version" ]]; then
      nvm use "$nvm_version";
  fi
fi
