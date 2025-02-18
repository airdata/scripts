#!/bin/bash

# Define remote names and paths
FOLDER_SYNC="$(pwd)"
GDRIVE_REMOTE="gdrive:git"
EXCLUDE_FROM_FILE="/tmp/rclone-excludes.txt"
LOG_FILE="$HOME/rclone_sync.log"

rm -rf $LOG_FILE
cd $FOLDER_SYNC && find . -type d -name .git | sed -e 's/$/\//' -e 's/^.//' > $EXCLUDE_FROM_FILE
cd $FOLDER_SYNC && find . -name .DS_Store | sed -e 's/$/\//' -e 's/^.//' | sed 's:/$::' >> $EXCLUDE_FROM_FILE

# Sync options
SYNC_OPTIONS="--verbose --progress --transfers 10 --checkers 8 --copy-links --log-file=$LOG_FILE"
# Sync pCloud to Google Drive
echo "Starting sync to Google Drive from $FOLDER_SYNC"
rclone sync $SYNC_OPTIONS --exclude-from=$EXCLUDE_FROM_FILE $FOLDER_SYNC $GDRIVE_REMOTE --delete-excluded
if [ $? -eq 0 ]; then
  echo "copy $FOLDER_SYNC to Google Drive completed successfully."
  rm -rf $EXCLUDE_FROM_FILE $LOG_FILE
else
  echo "Error occurred during pCloud to Google Drive sync. Check the log file: $LOG_FILE"
fi