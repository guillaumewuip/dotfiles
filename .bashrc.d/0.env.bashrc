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

export HOMEBREW_PREFIX="/opt/homebrew";
export HOMEBREW_CELLAR="/opt/homebrew/Cellar";
export HOMEBREW_REPOSITORY="/opt/homebrew";
export PATH="/opt/homebrew/bin:/opt/homebrew/sbin${PATH+:$PATH}";
export MANPATH="/opt/homebrew/share/man${MANPATH+:$MANPATH}:";
export INFOPATH="/opt/homebrew/share/info:${INFOPATH:-}";

eval "$(rbenv init - --no-rehash bash)"

export PATH="$HOME/.bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"

export USE_GKE_GCLOUD_AUTH_PLUGIN=True
# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/g.clochard/google-cloud-sdk/path.bash.inc' ]; then . '/Users/g.clochard/google-cloud-sdk/path.bash.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/g.clochard/google-cloud-sdk/completion.bash.inc' ]; then . '/Users/g.clochard/google-cloud-sdk/completion.bash.inc'; fi

# pnpm
export PNPM_HOME="/Users/guillaume.clochard/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac

export PYENV_ROOT="$HOME/.pyenv"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

HOMEBREW_PREFIX="$(brew --prefix)"
if [[ -r "${HOMEBREW_PREFIX}/etc/profile.d/bash_completion.sh" ]]
then
  source "${HOMEBREW_PREFIX}/etc/profile.d/bash_completion.sh"
else
  for COMPLETION in "${HOMEBREW_PREFIX}/etc/bash_completion.d/"*
  do
    [[ -r "${COMPLETION}" ]] && source "${COMPLETION}"
  done
fi

eval "$(fzf --bash)"

if [ -d ~/.bash_completion.d ]; then
    for file in ~/.bash_completion.d/*; do
      source "$file"
  done
fi

export PROMPT_COMMAND='if [ "$(id -u)" -ne 0 ]; then echo "$(date "+%Y-%m-%d.%H:%M:%S") $(pwd) $(history 1)" >> ~/.logs/bash-history-$(date "+%Y-%m-%d").log; fi'

export STARSHIP_CONFIG=~/.config/starship/config.toml
eval "$(starship init bash)"
