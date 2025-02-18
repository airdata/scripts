#!/bin/bash

# Define remote names and paths
PCLOUD_REMOTE="pcloud:"
GDRIVE_REMOTE="gdrive:"

# Log file for rclone
LOG_FILE="$HOME/rclone_sync.log"

# Sync options
SYNC_OPTIONS="--verbose --progress --transfers 4 --checkers 8 --copy-links --log-file=$LOG_FILE"

# Sync pCloud to Google Drive
echo "Starting sync from Google Drive to pCloud..."
rclone sync $SYNC_OPTIONS "$GDRIVE_REMOTE" "$PCLOUD_REMOTE"
if [ $? -eq 0 ]; then
  echo "Google Drive to pCloud sync completed successfully."
else
  echo "Error occurred during pCloud to Google Drive sync. Check the log file: $LOG_FILE"
fi

# Sync Google Drive to pCloud
echo "Starting sync from Google Drive to pCloud..."
rclone sync $SYNC_OPTIONS "$GDRIVE_REMOTE" "$PCLOUD_REMOTE"
if [ $? -eq 0 ]; then
  echo "Google Drive to pCloud sync completed successfully."
else
  echo "Error occurred during Google Drive to pCloud sync. Check the log file: $LOG_FILE"
fi
