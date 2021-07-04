URL=$1

case $URL in
  *"youtube"*)
    command="youtube-dl --extract-audio --audio-format=mp3 --audio-quality=0 $URL"
    ;;

  *"soundcloud"*)
    command="scdl --addtofile -l $URL"
    ;;

  *"bandcamp"*)
    command="bandcamp-dl $URL"
    ;;

  *)
    echo "Unknown command"
    exit 1
    ;;
esac

echo $command
$command
