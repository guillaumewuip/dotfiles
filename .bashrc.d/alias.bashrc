### Aliases
alias vim='nvim'

#Git
alias  gl="git ls"
alias gll="git ll"
alias glg="git lg"
alias gaa="git add ."
alias  ga="git add"
alias gap="git add -p"
alias gaf="git addf"

alias gc="git commit -m"
alias gcb="git cb"
alias gcan="git commit --amend --no-edit"
alias gv="git commit -v"
alias gf="git fix"
alias gfh="git fixh"
alias gw="git switchf"
alias gwm="git wm"

alias gd="git diff"
alias gdc="git diff --cached"

alias gs="git status -sb"
alias gpr="git-pr"
alias gscb="git-scb"

#Tmux
alias tl="tmux list-sessions"
alias ta="tmux attach -t"

# Color LS
colorflag="-G"
alias ls="command ls ${colorflag}"
alias l="ls -lF ${colorflag}" # all files, in long format
alias la="ls -laF ${colorflag}" # all files inc dotfiles, in long format
alias lsd='ls -lF ${colorflag} | grep "^d"' # only directories

# Quicker navigation
alias home="cd ~"
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."

# Shortcuts to my Code folder in my home directory
alias go='cd ~/workspace/$(cd ~/workspace; fd . --maxdepth 5 --type d | fzf)'

# Enable aliases to be sudo
alias sudo='sudo '

## The fuck
# https://github.com/nvbn/thefuck
alias fuck='$(thefuck $(fc -ln -1))'

[ -f private-alias.bashrc ] && source private-alias.bashrc
