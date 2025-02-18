
BUCKET=<bucketname>

MYSQL_USER=<user>
MYSQL_PASSWORD=<password>
MYSQL_HOST=<host>

mysqldump -u $MYSQL_USER \
          -p $MYSQL_PASSWORD \
          -h $MYSQL_HOST \
          --single-transaction \
          --routines --triggers \
          --all-databases | gzip > backup.gz

S3_KEY=$BUCKET/backups/$(date "+%Y-%m-%d")-backup.gz
aws s3 cp backup.gz s3://$S3_KEY --sse AES256

rm -f backup.gz

