# Homebrew — set early so all scripts can find brew-installed tools
export HOMEBREW_PREFIX="/opt/homebrew"
export HOMEBREW_CELLAR="${HOMEBREW_PREFIX}/Cellar"
export HOMEBREW_REPOSITORY="/opt/homebrew"
export PATH="/opt/homebrew/bin:/opt/homebrew/sbin${PATH+:$PATH}"
export MANPATH="/opt/homebrew/share/man${MANPATH+:$MANPATH}:"
export INFOPATH="/opt/homebrew/share/info:${INFOPATH:-}"

export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

export EDITOR="/opt/homebrew/bin/nvim"

# Disable husky locally
export HUSKY=0

export PATH="$HOME/.bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"

export PATH="$HOME/.atuin/bin:$PATH"

export XDG_CONFIG_HOME="$HOME/.config"

export NODE_COMPILE_CACHE=~/.cache/nodejs/compile-cache

# pnpm
export PNPM_HOME="$HOME/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac

# export PYENV_ROOT="$HOME/.pyenv"
