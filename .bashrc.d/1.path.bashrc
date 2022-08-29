export HOMEBREW_PREFIX="/opt/homebrew";
export HOMEBREW_CELLAR="/opt/homebrew/Cellar";
export HOMEBREW_REPOSITORY="/opt/homebrew";
export PATH="/opt/homebrew/bin:/opt/homebrew/sbin${PATH+:$PATH}";
export MANPATH="/opt/homebrew/share/man${MANPATH+:$MANPATH}:";
export INFOPATH="/opt/homebrew/share/info:${INFOPATH:-}";

export PATH="/opt/homebrew/opt/ruby/bin:/opt/homebrew/lib/ruby/gems/3.0.0/bin:$PATH"
export PATH="$HOME/.bin:$PATH"

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/g.clochard/google-cloud-sdk/path.bash.inc' ]; then . '/Users/g.clochard/google-cloud-sdk/path.bash.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/g.clochard/google-cloud-sdk/completion.bash.inc' ]; then . '/Users/g.clochard/google-cloud-sdk/completion.bash.inc'; fi
