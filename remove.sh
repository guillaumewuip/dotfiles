HOME=~/          #home dir
DIR="* .[^.]*"   #current dir

for i in $DIR; do

    if [ $i == "install.sh" -o $i == "remove.sh" -o "README.md" -o ".git"]; then
        continue;
    fi

    file=$(pwd)/$i
    homeFile=$HOME$i

    if [ -h $homeFile -a $(readlink $homeFile) == $file ]; then
        echo "unlink $homeFile"
        unlink $homeFile
    fi

done

