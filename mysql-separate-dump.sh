#!/bin/bash
# Backup all MySQL databases in separate files.

# Load settings from a separate file
source /usr/local/etc/mysql-separate-dump-settings.sh

mkdir -p $MSD_DEST_FOLDER
cd $MSD_DEST_FOLDER

MSD_DB_LIST=`mysql -u$MSD_SQL_USER -p$MSD_SQL_PASSWORD -e "SHOW DATABASES;" | tr -d "| " | grep -v Database`
for DB in $MSD_DB_LIST; do
    if [[ "$DB" != "information_schema" ]] && [[ "$DB" != _* ]] && [[ "$DB" != performance_schema ]] ; then
        #echo "Dumping database: $DB"
        mysqldump -u$MSD_SQL_USER -p$MSD_SQL_PASSWORD --opt --force --events --databases $DB > $MSD_DEST_FOLDER/$DB.sql
        #gzip -f -9 $MSD_DEST_FOLDER/$DB.sql
    fi
done
