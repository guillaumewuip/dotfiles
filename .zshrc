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

ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets)
ZSH_HIGHLIGHT_MAXLENGTH=512

typeset -A ZSH_HIGHLIGHT_STYLES

ZSH_HIGHLIGHT_STYLES[default]='none'
ZSH_HIGHLIGHT_STYLES[reserved-word]='none'
ZSH_HIGHLIGHT_STYLES[suffix-alias]='none'
ZSH_HIGHLIGHT_STYLES[global-alias]='none'
ZSH_HIGHLIGHT_STYLES[precommand]='none'
ZSH_HIGHLIGHT_STYLES[commandseparator]='none'
ZSH_HIGHLIGHT_STYLES[autodirectory]='none'
ZSH_HIGHLIGHT_STYLES[path]='none'
ZSH_HIGHLIGHT_STYLES[path_pathseparator]='none'
ZSH_HIGHLIGHT_STYLES[path_prefix_pathseparator]='none'
ZSH_HIGHLIGHT_STYLES[globbing]='none'
ZSH_HIGHLIGHT_STYLES[history-expansion]='none'
ZSH_HIGHLIGHT_STYLES[command-substitution]='none'
ZSH_HIGHLIGHT_STYLES[command-substitution-delimiter]='none'
ZSH_HIGHLIGHT_STYLES[process-substitution]='none'
ZSH_HIGHLIGHT_STYLES[process-substitution-delimiter]='none'
ZSH_HIGHLIGHT_STYLES[single-hyphen-option]='none'
ZSH_HIGHLIGHT_STYLES[double-hyphen-option]='none'
ZSH_HIGHLIGHT_STYLES[back-quoted-argument]='none'
ZSH_HIGHLIGHT_STYLES[back-quoted-argument-delimiter]='none'
ZSH_HIGHLIGHT_STYLES[single-quoted-argument]='none'
ZSH_HIGHLIGHT_STYLES[double-quoted-argument]='none'
ZSH_HIGHLIGHT_STYLES[dollar-quoted-argument]='none'
ZSH_HIGHLIGHT_STYLES[rc-quote]='none'
ZSH_HIGHLIGHT_STYLES[dollar-double-quoted-argument]='none'
ZSH_HIGHLIGHT_STYLES[back-double-quoted-argument]='none'
ZSH_HIGHLIGHT_STYLES[back-dollar-quoted-argument]='none'
ZSH_HIGHLIGHT_STYLES[assign]='none'
ZSH_HIGHLIGHT_STYLES[redirection]='none'
ZSH_HIGHLIGHT_STYLES[comment]='none'
ZSH_HIGHLIGHT_STYLES[named-fd]='none'
ZSH_HIGHLIGHT_STYLES[numeric-fd]='none'
ZSH_HIGHLIGHT_STYLES[arg0]='none'

ZSH_HIGHLIGHT_STYLES[bracket-error]='fg=red,bold'
ZSH_HIGHLIGHT_STYLES[bracket-level-1]='none'
ZSH_HIGHLIGHT_STYLES[bracket-level-2]='none'
ZSH_HIGHLIGHT_STYLES[bracket-level-3]='none'
ZSH_HIGHLIGHT_STYLES[bracket-level-4]='none'
ZSH_HIGHLIGHT_STYLES[bracket-level-5]='none'
ZSH_HIGHLIGHT_STYLES[cursor-matchingbracket]='none'

DISABLE_FZF_KEY_BINDINGS="true"
DISABLE_AUTO_TITLE="true"

function zvm_config() {
  ZVM_SYSTEM_CLIPBOARD_ENABLED=true
}

# Plugins
plugins=(
  zsh-vi-mode
  git
  gitfast
  kubectx
  sudo
  fzf
  fzf-tab
  zsh-dot-up
  zsh-syntax-highlighting
)

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
