IGNORE_FILES="install.sh|remove.sh|README.md|.git|.gitignore"

HOME=~/          #home dir

find -E . -mindepth 1 -maxdepth 1 -a ! -regex "./($IGNORE_FILES)" | while read i
do
  i=`basename $i`

  file=`pwd`/$i
  homeFile=$HOME$i

  if [ -h $homeFile ] && [ `readlink $homeFile` == $file ]; then
    echo "unlink $homeFile"
    unlink $homeFile
  fi
done

