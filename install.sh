IGNORE_FILES="install.sh|remove.sh|README.md|.git|.gitignore"

HOME=~/

find -E . -mindepth 1 -maxdepth 1 -a ! -regex "./($IGNORE_FILES)" | while read i
do
    i=`basename $i`

    homeFile=$HOME$i	#target file
    file=`pwd`/$i       #full path to current file

    if [ -e $homeFile ]; then #file exist

        if [ $file == `readlink $homeFile` ]; then
            echo "$i already linked"
            continue
        else
            #save old version
            echo "mv $homeFile $homeFile.old"
            mv $homeFile $homeFile.old
        fi

    fi

    #link the file
    echo "$homeFile --> $file"
    ln -s $file $homeFile

done

echo "git submodule update --init --recursive"
git submodule update --init --recursive

