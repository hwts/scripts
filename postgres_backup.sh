#!/bin/bash

# Backup postgresql

STOR_TIME="14"
DB_LIST="db1,db2,db3"
DIR="/mnt/backup/dayly/"
TIMENAME=`date +%Y-%m-%d`
PG_DUMP="/usr/bin/pg_dump"
SUDO="/usr/bin/sudo"
GZIP="/bin/gzip"
ExcludeTable="-T cdr"
IFS=","
for DBNAME in $DB_LIST;
do
$SUDO -u postgres $PG_DUMP $DBNAME $ExcludeTable 2> /dev/null | $GZIP > $DIR/$DBNAME-backup-$TIMENAME-db.sql.gz && find $DIR/$DBNAME* -mtime +$STOR_TIME -delete;
echo `/usr/bin/du -hsx $DIR/$DBNAME-backup-$TIMENAME-db.sql.gz`;
done
