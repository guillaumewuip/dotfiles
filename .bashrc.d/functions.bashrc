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

function inframe() {
  docker run -ti --rm -v ${HOME}/.inframe:/root/.inframe -v ${HOME}/.aws:/root/.aws -v ${HOME}/.ssh/iadvize_github_rsa:/root/.ssh/id_rsa -v $(pwd):/config iadvize/inframe $@
}

