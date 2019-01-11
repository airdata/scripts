#!/bin/bash

# Basic variables
mysqlhost="$mysqlhost"
mysqlpass="$mysqlpass"
bucket="$bucket"
mysqluser="$mysqluser"

# Timestamp (sortable AND readable)
stamp=`date +"%d %b %Y"`
# List all the databases
databases=`mysql -h$mysqlhost -u$mysqluser -p$mysqlpass -e "SHOW DATABASES;" | tr -d "| " | grep  _prod`


# Feedback
echo -e "Dumping to \e[1;32m$bucket/$stamp/\e[00m"

# Loop the databases
for db in $databases; do

  # Define our filenames
  filename="$stamp - $db.sql.gz"
  tmpfile="/tmp/$filename"
  object="$bucket/$stamp/$filename"

  # Feedback
  echo -e "\e[1;34m$db\e[00m"

  # Dump and zip
  echo -e "  creating \e[0;35m$tmpfile\e[00m"
  mysqldump  -h$mysqlhost -u$mysqluser -p$mysqlpass --force --opt --databases "$db" | gzip -c > "$tmpfile"

  # Upload
  echo -e "  uploading..."
  aws s3 cp "$tmpfile" "$object"

  # Delete
  rm -f "$tmpfile"

done;

# Jobs a goodun
echo -e "\e[1;32mJobs a goodun\e[00m"
