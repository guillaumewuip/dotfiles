
## Add android sdk/tools and android sdk/platform-tools
export PATH="$PATH:/Applications/Android SDK/tools:/Applications/Android SDK/platform-tools" 
#Mongo
export PATH="$PATH:/usr/local/mongodb/bin/"
## Add macport
export PATH="/opt/local/bin:/opt/local/sbin:$PATH"
#heroku
export PATH="/usr/local/heroku/bin:$PATH"
#rabbitmq
export PATH="$PATH:/usr/local/sbin"

export EDITOR="/usr/bin/vim"

alias arduino="/Applications/Arduino.app/Contents/MacOs/JavaApplicationStub"

### Aliases

#Git
alias  gl="git ls"
alias gll="git ll"
alias gaa="git add ."
alias  ga="git add"
alias gap="git add -p"

alias  gc="git commit -m"
alias gca="git commit -a -m"

alias gd="git diff"

alias gs="git status -s"

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
alias scolaire="cd /Users/Guillaume/Documents/Scolaire/L2/S4"

# Enable aliases to be sudo’ed
alias sudo='sudo '

## Start an HTTP server from a directory, optionally specifying the port
function server() {
    local port="${1:-8000}"
    open "http://localhost:${port}/" && python -m SimpleHTTPServer "$port"
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

alias setProxies="export http_proxy=http://cache.etu.univ-nantes.fr && export https_proxy=http://cache.etu.univ-nantes.fr"
alias unsetProxies="unset http_proxy && unset https_proxy"

### Prompt Colors
# Modified version of @gf3’s Sexy Bash Prompt
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


# Change this symbol to something sweet.
# (http://en.wikipedia.org/wiki/Unicode_symbols)
symbol="⚡  "

export PS1="\[${BOLD}${MAGENTA}\]\u \[$ORANGE\]in \[$GREEN\]\w\[$ORANGE\]\$([[ -n \$(git branch 2> /dev/null) ]] && echo \" on \")\[$PURPLE\]\$(parse_git_branch)\[$WHITE\]\n$symbol\[$RESET\]"
export PS2="\[$ORANGE\]→ \[$RESET\]"


### Misc

# Only show the current directory's name in the tab
export PROMPT_COMMAND='echo -ne "\033]0;${PWD##*/}\007"'


### Extra

. ~/z.sh

### Go GVM
[[ -s "/Users/Guillaume/.gvm/scripts/gvm" ]] && source "/Users/Guillaume/.gvm/scripts/gvm"

### Docker
### reset boot2docker env
### http://stackoverflow.com/questions/27528337/am-i-trying-to-connect-to-a-tls-enabled-daemon-without-tls
### $(boot2docker shellinit)
$(boot2docker shellinit 2>/dev/null)

## The fuck
# https://github.com/nvbn/thefuck
alias fuck='$(thefuck $(fc -ln -1))'
