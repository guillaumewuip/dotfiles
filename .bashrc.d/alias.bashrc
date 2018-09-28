
### Aliases
alias vlc='/Applications/VLC.app/Contents/MacOS/VLC'
alias cmus='cmus 2> /dev/null'
alias vim='nvim'

#Git
alias  gl="git ls"
alias gll="git ll"
alias glg="git lg"
alias gaa="git add ."
alias  ga="git add"
alias gap="git add -p"

alias gc="git commit -m"
alias gcan="git commit --amend --no-edit"
alias gv="git commit -v"
alias gf="git fix"
alias grb="git rebasef"
alias gaf="git addf"


alias gd="git diff"
alias gdc="git diff --cached"

alias gs="git status -sb"

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
alias web="cd /Users/Guillaume/Documents/Informatique/Web/"
alias sco="cd /Users/Guillaume/Documents/Scolaire/5A/S9"

# Enable aliases to be sudoâed
alias sudo='sudo '

alias weather='curl http://wttr.in'

## The fuck
# https://github.com/nvbn/thefuck
alias fuck='$(thefuck $(fc -ln -1))'
