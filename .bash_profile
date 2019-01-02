# Important to be able to write 'é' or others frenchies' things inside Kitty/Alacritty
export LC_ALL=fr_FR.UTF-8
export LANG=fr_FR.UTF-8
export TERM=xterm-256color

# https://medium.com/@waxzce/use-bashrc-d-directory-instead-of-bloated-bashrc-50204d5389ff
for file in ~/.bashrc.d/*.bashrc;
do
  source "$file"
done

if [ "$TMUX" = "" ]; then
  exec tmux new -A -s 0
fi

