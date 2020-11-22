#!/bin/bash

COMMAND=$1

rclone=/usr/local/bin/rclone

case $COMMAND in
  documents)
    $rclone sync --stats-file-name-length 0 ~/Documents/Livres wuips-documents:/Livres
    $rclone sync --stats-file-name-length 0 ~/Documents/Officiel wuips-documents:/Officiel
    $rclone sync --stats-file-name-length 0 ~/Documents/Professionel wuips-documents:/Professionel

    touch /tmp/backup-documents
    date +%s > /tmp/backup-documents

    echo "documents sync done"
    ;;

  mails)
    # $rclone sync --stats-file-name-length 0 ~/mail wuips-mail:

    touch /tmp/backup-mails
    date +%s > /tmp/backup-mails

    echo "mails sync done"
    ;;

  *)
    echo "backup.sh [documents|mails]"
    ;;
esac
