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

# Disable husky locally
export HUSKY=0

HOMEBREW_PREFIX="$(brew --prefix)"
export HOMEBREW_CELLAR="${HOMEBREW_PREFIX}/Cellar";
export HOMEBREW_REPOSITORY="/opt/homebrew";
export PATH="/opt/homebrew/bin:/opt/homebrew/sbin${PATH+:$PATH}";
export MANPATH="/opt/homebrew/share/man${MANPATH+:$MANPATH}:";
export INFOPATH="/opt/homebrew/share/info:${INFOPATH:-}";

if [[ -r "${HOMEBREW_PREFIX}/etc/profile.d/bash_completion.sh" ]]
then
  source "${HOMEBREW_PREFIX}/etc/profile.d/bash_completion.sh"
else
  for COMPLETION in "${HOMEBREW_PREFIX}/etc/bash_completion.d/"*
  do
    [[ -r "${COMPLETION}" ]] && source "${COMPLETION}"
  done
fi

eval "$(rbenv init - --no-rehash bash)"

export PATH="$HOME/.bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"

export PATH="$HOME/.jenv/bin:$PATH"
eval "$(jenv init -)"

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/guillaume.clochard/google-cloud-sdk/path.bash.inc' ]; then . '/Users/guillaume.clochard/google-cloud-sdk/path.bash.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/guillaume.clochard/google-cloud-sdk/completion.bash.inc' ]; then . '/Users/guillaume.clochard/google-cloud-sdk/completion.bash.inc'; fi

export NODE_COMPILE_CACHE=~/.cache/nodejs/compile-cache

# pnpm
export PNPM_HOME="/Users/guillaume.clochard/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac

source ~/completion-for-pnpm.bash

export PYENV_ROOT="$HOME/.pyenv"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

[[ -f ~/.bash-preexec.sh ]] && source ~/.bash-preexec.sh

# Setting fd as the default source for fzf
export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'

# To apply the command to CTRL-T as well
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

if [ -d ~/.bash_completion.d ]; then
    for file in ~/.bash_completion.d/*; do
      source "$file"
  done
fi

if [[ "$TERM_PROGRAM" != "vscode" ]]; then
  export STARSHIP_CONFIG=~/.config/starship/config.toml
  eval "$(starship init bash)"
fi

. "$HOME/.atuin/bin/env"
eval "$(atuin init bash)"
