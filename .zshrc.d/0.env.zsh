export TERM=xterm-256color

# Extend cd tab completion
export CDPATH=$CDPATH:.

# Extended glob (zsh equivalent of bash's shopt -s extglob)
setopt extended_glob

#eval "$(rbenv init - zsh)"

# export PATH="$HOME/.jenv/bin:$PATH"
# eval "$(jenv init -)"

# The next line updates PATH for the Google Cloud SDK.
if [ -f "$HOME/google-cloud-sdk/path.zsh.inc" ]; then
  source "$HOME/google-cloud-sdk/path.zsh.inc"
fi

# The next line enables shell command completion for gcloud.
if [ -f "$HOME/google-cloud-sdk/completion.zsh.inc" ]; then
  source "$HOME/google-cloud-sdk/completion.zsh.inc"
fi

# export PYENV_ROOT="$HOME/.pyenv"
# eval "$(pyenv init -)"
# eval "$(pyenv virtualenv-init -)"

# Setting fd as the default source for fzf
export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

# atuin
zvm_after_init_commands+=(
  'eval "$(atuin init zsh)"'
)
