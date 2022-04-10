## Start an HTTP server from a directory, optionally specifying the port
function server() {
  local port="${1:-8000}"
  open "http://localhost:${port}/" && python2 -m SimpleHTTPServer "$port"
}

function pong() {
  gping ${1:-"8.8.8.8"}
}

function port() {
  lsof -i ":${1:-80}"
}
