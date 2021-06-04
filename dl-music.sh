COMMAND=$1

case $COMMAND in
  youtube)
    shift
    command="youtube-dl --extract-audio --audio-format=mp3 --audio-quality=0 $@"
    ;;

  soundcloud)
    shift
    command="scdl --addtofile -l $@"
    ;;

  bandcamp)
    shift
    command="bandcamp-dl $@"
    ;;

  *)
    echo "Unknown command"
    exit 1
    ;;
esac

echo $command
$command
