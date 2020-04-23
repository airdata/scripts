BACKUP_PATH="/backups/www"
WWW_PATH="/var/www"
DAYS_TO_KEEP=7 # to keep forever use 0

# Create a backup directory if it doesn't already exist
if [ ! -d ${BACKUP_PATH} ]; then
    mkdir -p ${BACKUP_PATH}
    echo "Successfully created the backup directory: $BACKUP_PATH"
fi

# Change current directory to the web root directory
cd ${WWW_PATH}
if [ $(pwd) != ${WWW_PATH} ]; then
    echo "Failed to change the current directory to the web root directory"
    exit;
fi

# Backup every directory in the web root directory
for website in *; do
    if [[ -d ${website} && ! -L ${website} ]]; then
        echo "Making backup of: $website"
        tar -cvpzf ${BACKUP_PATH}/$(date -I)-${website}.tar.gz ${website}
    fi
done

# Delete old backups
if [ ${DAYS_TO_KEEP} -gt 0 ]; then
    echo "Deleting backups older then $DAYS_TO_KEEP days"
    find ${BACKUP_PATH}/* -mtime +${DAYS_TO_KEEP} -exec rm {} \;
fi
