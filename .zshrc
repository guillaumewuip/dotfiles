# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Path to oh-my-zsh installation
export ZSH="$HOME/.oh-my-zsh"

# Theme
ZSH_THEME="powerlevel10k/powerlevel10k"

# Plugins
plugins=(
  zsh-vi-mode
  git
  gitfast
  kubectx
  sudo
  fzf
  fzf-tab
  fast-syntax-highlighting
  zsh-dot-up
)

DISABLE_FZF_KEY_BINDINGS="true"
DISABLE_AUTO_TITLE="true"

function zvm_config() {
  ZVM_SYSTEM_CLIPBOARD_ENABLED=true
}

source $ZSH/oh-my-zsh.sh

# ============================================================================
# Vi mode settings (replaces .inputrc)
# ============================================================================
bindkey -v

# Ctrl-L/A/E in both vi modes
bindkey -M viins '^L' clear-screen
bindkey -M viins '^A' beginning-of-line
bindkey -M viins '^E' end-of-line
bindkey -M vicmd '^L' clear-screen
bindkey -M vicmd '^A' beginning-of-line
bindkey -M vicmd '^E' end-of-line

# Shift-TAB cycles completions backward
bindkey "${terminfo[kcbt]}" reverse-menu-complete

# ============================================================================
# Completion settings (replaces .inputrc show-all-if-ambiguous + ignore-case)
# ============================================================================
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'

eval $(thefuck --alias)

# ============================================================================
# Source modular config files
# ============================================================================
for file in ~/.zshrc.d/*.zsh; do
  source "$file"
done

# ============================================================================
# Powerlevel10k config — run `p10k configure` to regenerate
# ============================================================================
[[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh
