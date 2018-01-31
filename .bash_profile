
export PATH=$PATH:/usr/local/sbin
## Add macport
export PATH=$PATH:/opt/local/bin:/opt/local/sbin
#heroku
export PATH=$PATH:/usr/local/heroku/bin
## Add android sdk/tools and android sdk/platform-tools
export PATH=$PATH:/Users/Guillaume/Library/Android/sdk/tools
export PATH=$PATH:/Users/Guillaume/Library/Android/sdk/platform-tools
export PATH=$PATH:/Library/TeX/texbin

# Ruby
export RBENV_ROOT="$(brew --prefix rbenv)"
export GEM_HOME="$(brew --prefix)/opt/gems"
export GEM_PATH="$(brew --prefix)/opt/gems"
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi
export PATH=$PATH:/usr/local/opt/gems/bin

# Rust
export PATH="$HOME/.cargo/bin:$PATH"

export EDITOR="/usr/bin/vim"

alias arduino="/Applications/Arduino.app/Contents/MacOs/JavaApplicationStub"

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

alias  gc="git commit -m"
alias gca="git commit -a -m"
alias  gv="git commit -v"

alias gd="git diff"

alias gs="git status -sb"

#load autocompletions
source /usr/local/etc/bash_completion.d/git-completion.bash
source /usr/local/etc/bash_completion.d/npm

#Tmux
alias tl="tmux list-sessions"
alias ta="tmux attach -t"

# Open specified files in Sublime Text
# "s ." will open the current directory in Sublime
alias sublime='open -a "Sublime Text"'

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

export CDPATH=$CDPATH:.
export CDPATH=$CDPATH:/Users/Guillaume/Documents/Informatique/Web/
export CDPATH=$CDPATH:/Users/Guillaume/Documents/Scolaire/5A/S9/
export CDPATH=$CDPATH:/Users/Guillaume/Documents/Scolaire/5A/DU/dev/

# Enable aliases to be sudoâed
alias sudo='sudo '

alias weather='curl http://wttr.in'

## Start an HTTP server from a directory, optionally specifying the port
function server() {
    local port="${1:-8000}"
    open "http://localhost:${port}/" && python2 -m SimpleHTTPServer "$port"
}

## matrix fun
function hax0r() {
    perl -e '$|++; while (1) { print " " x (rand(35) + 1), int(rand(2)) }'
}

## Get the process on a given port
function port() {
  lsof -i ":${1:-80}"
}

function loc() {
  open "http://localhost:${1:-8080}"
}

## Create a port-forward ssh connexion
## Default via the bastion ssh host (@see .ssh/config)
function sshTunnel() {
    ssh -f -N -L ${1}:${2}:${3} ${4:-Mac-mini.local}
}
alias tunnelVPN="sshTunnel 1194 guillaumewuip.ddns.net 1194 bastion"

proxies="export http_proxy=http://cache.etu.univ-nantes.fr:3128"
proxies="$proxies && export https_proxy=http://cache.etu.univ-nantes.fr:3128"
alias setProxies="${proxies}"
alias unsetProxies="unset http_proxy && unset https_proxy && unset HTTP_PROXY && unset HTTPS_PROXY"

function pong() {
  ping ${1:-"8.8.8.8"} | while read line; do echo "$(date): $line"; done
}

function port() {
  lsof -i ":${1:-80}"
}

### Prompt Colors
# Modified version of @gf3âs Sexy Bash Prompt
# (https://github.com/gf3/dotfiles)
if [[ $COLORTERM = gnome-* && $TERM = xterm ]] && infocmp gnome-256color >/dev/null 2>&1; then
	export TERM=gnome-256color
elif infocmp xterm-256color >/dev/null 2>&1; then
	export TERM=xterm-256color
fi

if tput setaf 1 &> /dev/null; then
	tput sgr0
	if [[ $(tput colors) -ge 256 ]] 2>/dev/null; then
		BLACK=$(tput setaf 190)
		MAGENTA=$(tput setaf 9)
		ORANGE=$(tput setaf 172)
		GREEN=$(tput setaf 190)
		PURPLE=$(tput setaf 141)
		WHITE=$(tput setaf 0)
	else
		BLACK=$(tput setaf 190)
		MAGENTA=$(tput setaf 5)
		ORANGE=$(tput setaf 4)
		GREEN=$(tput setaf 2)
		PURPLE=$(tput setaf 1)
		WHITE=$(tput setaf 7)
	fi
	BOLD=$(tput bold)
	RESET=$(tput sgr0)
else
	BLACK="\033[01;30m"
	MAGENTA="\033[1;31m"
	ORANGE="\033[1;33m"
	GREEN="\033[1;32m"
	PURPLE="\033[1;35m"
	WHITE="\033[1;37m"
	BOLD=""
	RESET="\033[m"
fi

export BLACK
export MAGENTA
export ORANGE
export GREEN
export PURPLE
export WHITE
export BOLD
export RESET

# Git branch details
function parse_git_dirty() {
	[[ $(git status 2> /dev/null | tail -n1) != *"working directory clean"* ]] && echo "*"
}
function parse_git_branch() {
	git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e "s/* \(.*\)/\1$(parse_git_dirty)/"
}

# Send OSX notification after long process exit
function f_notifyme {
    case "$OSTYPE" in
        darwin*)
            LAST_EXIT_CODE=$?
            CMD=$(history 1 | sed 's/^ *[^ ]* *//')
            ~/.notifier "$CMD" "$LAST_EXIT_CODE" &
            ;;
        *);;
    esac
}


# Change this symbol to something sweet.
# (http://en.wikipedia.org/wiki/Unicode_symbols)
#symbol="â¡  "
symbol=""

PS1="\[${BOLD}${MAGENTA}\]\u \[$ORANGE\]in \[$GREEN\]\w\[$ORANGE\]\$([[
-n \$(git branch 2> /dev/null) ]] && echo \" on \")\[$PURPLE\]\$(parse_git_branch)\[$WHITE\]\[$RESET\]\n$symbol"
PS1='$(f_notifyme)'$PS1
export PS1=$PS1
export PS2="\[$RESET\]\[$ORANGE\]â  \[$RESET\]"


### Misc

# Only show the current directory's name in the tab
export PROMPT_COMMAND='echo -ne "\033]0;${PWD##*/}\007"'

shopt -s extglob # enables extended globbing, usefull for ls !(*.*)

### Extra

. ~/z.sh

### Go GVM
[[ -s "~/.gvm/scripts/gvm" ]] && source "~/.gvm/scripts/gvm"

## The fuck
# https://github.com/nvbn/thefuck
alias fuck='$(thefuck $(fc -ln -1))'

[[ -r ~/.bashrc ]] && . ~/.bashrc

if [ "$TMUX" = "" ]; then exec tmux; fi

[ -f /usr/local/etc/bash_completion ] && . /usr/local/etc/bash_completion

