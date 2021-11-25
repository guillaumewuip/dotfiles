## Start an HTTP server from a directory, optionally specifying the port
function server() {
  local port="${1:-8000}"
  open "http://localhost:${port}/" && python2 -m SimpleHTTPServer "$port"
}

function pong() {
  ping ${1:-"8.8.8.8"} | while read line; do echo "$(date): $line"; done
}

function port() {
  lsof -i ":${1:-80}"
}
