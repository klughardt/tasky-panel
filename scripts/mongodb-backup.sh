#!/bin/bash
DATE=$(date +%Y%m%d-%H%M%S) BACKUP_FILE="/tmp/mongodb-backup-$DATE.gz"

mongodump --archive=$BACKUP_FILE --gzip
aws s3 cp $BACKUP_FILE s3://${BACKUP_BUCKET}/mongodb-backups/ # TODO
rm $BACKUP_FILE 

# Add to crontab: 0 * * * * /scripts/mongodb-backup.sh # TODO
