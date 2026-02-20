# Disable oh-my-zsh's built-in title management (DISABLE_AUTO_TITLE set in .zshrc)

# Set terminal window title: "<cmd> - <path>" or just "<path>" when idle
function _title_precmd() {
  printf '\e]0;%s\a' "${${PWD/#$HOME/~}}" > "$TTY"
}

function _title_preexec() {
  local cmd="${1%% *}"
  printf '\e]0;%s - %s\a' "$cmd" "${${PWD/#$HOME/~}}" > "$TTY"
}

add-zsh-hook precmd _title_precmd
add-zsh-hook preexec _title_preexec
