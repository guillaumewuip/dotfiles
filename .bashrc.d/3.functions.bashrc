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

function root() {
  # Function to check if we're in a git worktree
  is_git_worktree() {
    git rev-parse --is-inside-work-tree >/dev/null 2>&1 && \
    [ "$(git rev-parse --git-common-dir)" != "$(git rev-parse --git-dir)" ]
  }

  # Function to check if we're in a standard git repo (not a worktree)
  is_git_repo() {
    git rev-parse --is-inside-work-tree >/dev/null 2>&1 && \
    [ "$(git rev-parse --git-common-dir)" = "$(git rev-parse --git-dir)" ]
  }

  # Main logic
  if is_git_worktree; then
      # Case 1: We're in a git worktree, cd to the original repo
      # The git-common-dir points to the original repo's .git directory
      original_git_dir=$(git rev-parse --git-common-dir)
      original_repo=$(dirname "$original_git_dir")
      if [ -n "$original_repo" ]; then
          cd "$original_repo" || exit 1
          echo "Navigated to original repo: $(pwd)"
      else
          echo "Error: Could not determine original repo location" >&2
          exit 1
      fi
  elif is_git_repo; then
      # Case 2: We're in a standard git repo, cd to the root
      repo_root=$(git rev-parse --show-toplevel)
      if [ -n "$repo_root" ]; then
          cd "$repo_root" || exit 1
          echo "Navigated to repo root: $(pwd)"
      else
          echo "Error: Could not determine repo root" >&2
          exit 1
      fi
  else
      # Case 3: Not in a git repo or worktree, fail
      echo "Error: Not in a git repository or worktree" >&2
      exit 1
  fi
}
