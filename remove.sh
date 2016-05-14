IGNORE_FILES="install.sh|remove.sh|README.md|.git|.gitignore"

HOME=~/          #home dir

find -E . -mindepth 1 -maxdepth 1 -a ! -regex "./($IGNORE_FILES)" | while read i
do
    i=`basename $i`

    if [ $i == "install.sh" -o $i == "remove.sh" -o "README.md"
        -o ".git" -o ".gitignore"]; then
        continue;
    fi

    file=`pwd`/$i
    homeFile=$HOME$i

    if [ -h $homeFile -a `readlink $homeFile` == $file ]; then
        echo "unlink $homeFile"
        unlink $homeFile
    fi

done

