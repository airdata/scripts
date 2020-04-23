#!/bin/bash

####################################
#
# MUTUAL SETTINGS
#
####################################
TODAY="$(date +"%d-%m-%Y")" # Get date in dd-mm-yyyy format
NOW="$(date +"%d-%m-%Y_%H-%M-%S")" # Get date in dd-mm-yyyy format
DAYS=7 # How many days we want to save backups

####################################
#
# VHOST SETTINGS
#
####################################
VHOSTDESTINATION="/backups/www/$TODAY"
VHOSTSOURCEFOLDER="/var/www" # The folder that contains the files that we want to backup

####################################
#
# MYSQL SETTINGS
#
####################################
MyUSER="DB_USERNAME"  # DB_USERNAME
MyPASS="DB_PASSWORD"  # DB_PASSWORD
MyHOST="DB_HOSTNAME"  # DB_HOSTNAME
MyDEST="/backups/mysql/$TODAY" # Backup Dest directory
MYSQL="$(which mysql)" # Linux bin paths, needed for dumps
MYSQLDUMP="$(which mysqldump)" # Linux bin paths, needed for dumps
MySKIP="information_schema performance_schema sys mysql innodb" # Skip these DBs when exporting

####################################
#
# MYSQL START BACKUP
#
####################################
MBD="$MyDEST/$NOW" # Create MySQL Backup sub-directories
install -d $MBD

DBS="$($MYSQL -h $MyHOST -u $MyUSER -p$MyPASS -Bse 'show databases')" # Get all databases

# Archive database dumps
for db in $DBS
do
    skipdb=-1
    if [ "$MySKIP" != "" ];
    then
    for i in $MySKIP
    do
      [ "$db" == "$i" ] && skipdb=1 || :
    done
    fi
 
    if [ "$skipdb" == "-1" ] ; then
      FILE="$MBD/$db.sql"
  $MYSQLDUMP -h $MyHOST -u $MyUSER -p$MyPASS $db > $FILE
    fi
done

# Enter MySQL backup directory, create the backup and compress/archive it
cd $MyDEST
tar -cpzf $NOW.tar.gz $NOW # Create the backup with tar. c:create, p: preserve permissions for the new files, z: compress the files in order to reduce the size, f: use archive file or device ARCHIVE

# Print mysql backup end status message and delete the last folder used for creating archive
echo
rm -rf $NOW
echo "MySQL backup is completed! Backup name is $NOW.tar.gz"
date
####################################
#
# MYSQL END BACKUP
#
####################################

####################################
#
# VHOST START BACKUP
#
####################################
# Print start status message so that we know what is being backuped and where
echo "Backing up everything to $VHOSTDESTINATION from $VHOSTSOURCEFOLDER"
date
echo
# Create the directory for today backups and backup the files 
VBD="$VHOSTDESTINATION/$NOW"
install -d $VBD
cd $VHOSTDESTINATION
tar -cpzf $NOW.tar.gz $VHOSTSOURCEFOLDER # Create the backup with tar. c:create, p: preserve permissions for the new files, z: compress the files in order to reduce the size, f: use archive file or device ARCHIVE
# Print mysql backup end status message and delete the last folder used for creating archive
echo
rm -rf $NOW
echo "Vhost backup finished. Backup name is $NOW.tar.gz"
date
####################################
#
# VHOST END BACKUP
#
####################################

####################################
#
# END BACKUP CLEANUP
#
####################################
# Remove backups older than $days which is set on top of this script
ls -d -1tr $MyDEST/../* | head -n -$DAYS | xargs -d '\n' rm -rf
ls -d -1tr $VHOSTDESTINATION/../* | head -n -$DAYS | xargs -d '\n' rm -rf
echo "Old backups older than $DAYS days removed."
date
