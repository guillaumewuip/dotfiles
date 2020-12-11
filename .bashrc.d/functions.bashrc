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

function pong() {
  ping ${1:-"8.8.8.8"} | while read line; do echo "$(date): $line"; done
}

function port() {
  lsof -i ":${1:-80}"
}

function git-pr() {
  BRANCH_TITLE=$(git rev-parse --abbrev-ref HEAD)

  FIRT_TWO_WORDS=$(echo $BRANCH_TITLE | cut -f1,2 -d-)

  PREFIX=$([[ "$BRANCH_TITLE" =~ "BOYSCOUT-" ]] && echo "BOYSCOUT" || echo $FIRT_TWO_WORDS)

  NAME_WITH_DASH=$([[ "$BRANCH_TITLE" =~ "BOYSCOUT-" ]] && echo $BRANCH_TITLE | sed s/BOYSCOUT-//g || echo $BRANCH_TITLE | sed s/$FIRT_TWO_WORDS//g)

  NAME=$(echo $NAME_WITH_DASH | sed 's/-/ /g')

  TITLE="[$PREFIX] $NAME"

  MESSAGE="$TITLE\n\n> $PREFIX \n## Description\n\n\n## DEMO\n\n\n## TESTED"

  echo -e $MESSAGE | hub pull-request -a guillaumewuip --edit $@ -F -
}

function git-scb() {
  git switch -c BOYSCOUT-$1
}

function git-commit-b() {
  git commit -m "[BOYSCOUT] $1"
}
