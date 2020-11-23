#!/bin/bash

COMMAND=$1

rclone=/usr/local/bin/rclone

BACKUPS_FILE="/tmp/backups.json"

function readBackupFile() {
  [ -f $BACKUPS_FILE ] && cat $BACKUPS_FILE || echo "{}"
}

case $COMMAND in
  documents)
    {
      echo $(readBackupFile | jq '.documents.status = "running"') > $BACKUPS_FILE

      $rclone sync --stats-file-name-length 0 ~/Documents/Livres wuips-documents:/Livres
      $rclone sync --stats-file-name-length 0 ~/Documents/Officiel wuips-documents:/Officiel
      $rclone sync --stats-file-name-length 0 ~/Documents/Professionel wuips-documents:/Professionel

      echo $(readBackupFile | jq '.documents.status = "done"') > $BACKUPS_FILE
      echo $(readBackupFile | jq '.documents.lastUpdate = '$(date +%s)'') > $BACKUPS_FILE

      echo "documents sync done"
    } || {
      echo $(readBackupFile | jq '.documents.status = "error"') > $BACKUPS_FILE
      echo $(readBackupFile | jq '.documents.lastUpdate = '$(date +%s)'') > $BACKUPS_FILE

      echo "documents sync error"
    }
    ;;

  mails)
    {
      echo $(readBackupFile | jq '.mails.status = "running"') > $BACKUPS_FILE

      $rclone sync --stats-file-name-length 0 ~/mail/guillaume-wuips wuips-mail:/guillaume-wuips
      $rclone sync --stats-file-name-length 0 ~/mail/clochard-guillaume-gmail wuips-mail:/clochard-guillaume-gmail
      $rclone sync --stats-file-name-length 0 ~/mail/guigui-wuip-gmail wuips-mail:/guigui-wuip-gmail

      echo $(readBackupFile | jq '.mails.status = "done"') > $BACKUPS_FILE
      echo $(readBackupFile | jq '.mails.lastUpdate = '$(date +%s)'') > $BACKUPS_FILE

      echo "mails sync done"
    } || {
      echo $(readBackupFile | jq '.mails.status = "error"') > $BACKUPS_FILE
      echo $(readBackupFile | jq '.mails.lastUpdate = '$(date +%s)'') > $BACKUPS_FILE

      echo "documents sync error"
    }
    ;;

  *)
    echo "backup.sh [documents|mails]"
    ;;
esac
