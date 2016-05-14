HOME=~/          #home dir
DIR="* .[^.]*"   #current dir

for i in $DIR; do

    #don't link this script
    if [ $i == "install.sh" -o $i == "remove.sh" -o "README.md" -o ".git"]; then
        continue;
    fi

    homeFile=$HOME$i	#target file
    file=$(pwd)/$i 	#full path to current file

    if [ -e $homeFile ]; then #file exist

        if [ $file == $(readlink $homeFile) ]; then
                echo "$i already linked"
                continue;
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

curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim
git submodule update --init --recursive

