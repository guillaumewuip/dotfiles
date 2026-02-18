### Aliases
alias vim='nvim'

#Git
alias git="git"
alias  gl="git ls"
alias gll="git ll"
alias glg="git lg"
alias gaa="git add ."
alias  ga="git add"
alias gap="git add -p"
alias gaf="git addf"

alias gc="git commit -m"
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

alias goo='cd ~/workspace/$(cd ~/workspace; fd . --maxdepth 7 --type d | fzf)'
alias go='cd $(fd . --maxdepth 7 --type d | fzf)'
alias gog='cd $(git rev-parse --show-toplevel)/$(cd $(git rev-parse --show-toplevel); fd . --maxdepth 5 --type d | fzf)'

# Enable aliases to be sudo
alias sudo='sudo '

## The fuck
# https://github.com/nvbn/thefuck
alias fuck='$(thefuck $(fc -ln -1))'

alias pp="pnpm i; pnpm turbo run build"
alias p="pnpm turbo run build"
alias ci="pnpm run format --fix && pnpm run lint --fix && pnpm run test:unit -u"

alias c="copilot --enable-all-github-mcp-tools --allow-all-tools --experimental --disable-mcp-server=tana --disable-mcp-server=atlassian"
alias t="copilot --allow-all-tools --disable-mcp-server=atlassian --disable-mcp-server=context7"
