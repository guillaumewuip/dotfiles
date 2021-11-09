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

function cdnvm() { # @see https://github.com/nvm-sh/nvm#bash
  command cd "$@";
  nvm_path=$(nvm_find_up .nvmrc | tr -d '\n')

  # If there are no .nvmrc file, use the default nvm version
  if [[ ! $nvm_path = *[^[:space:]]* ]]; then
      declare default_version;
      default_version=$(nvm version default);

      # If there is no default version, set it to `node`
      # This will use the latest version on your machine
      if [[ $default_version == "N/A" ]]; then
          nvm alias default node;
          default_version=$(nvm version default);
      fi

      # If the current version is not the default version, set it to use the default version
      if [[ $(nvm current) != "$default_version" ]]; then
          nvm use default;
      fi

      elif [[ -s $nvm_path/.nvmrc && -r $nvm_path/.nvmrc ]]; then

      declare nvm_version
      nvm_version=$(<"$nvm_path"/.nvmrc)

      declare locally_resolved_nvm_version
      # `nvm ls` will check all locally-available versions
      # If there are multiple matching versions, take the latest one
      # Remove the `->` and `*` characters and spaces
      # `locally_resolved_nvm_version` will be `N/A` if no local versions are found
      locally_resolved_nvm_version=$(nvm ls --no-colors "$nvm_version" | tail -1 | tr -d '\->*' | tr -d '[:space:]')

      # If it is not already installed, install it
      # `nvm install` will implicitly use the newly-installed version
      if [[ "$locally_resolved_nvm_version" == "N/A" ]]; then
          nvm install "$nvm_version";
      elif [[ $(nvm current) != "$locally_resolved_nvm_version" ]]; then
          nvm use "$nvm_version";
      fi
  fi
}
