#!/bin/bash

# path where are the drupal sites
WWW_PATH="/var/www"

# path where the backups are stored
BACKUP_PATH="/root/backups"

backup() {
    SITE=$1
    SITE_PATH="$WWW_PATH/$SITE"
    BACKUP_PATH="$BACKUP_PATH/$SITE"

    DATE=`date +"%d-%m-%Y"`
    TGZ="$BACKUP_PATH/$SITE-sites_$DATE.tar.gz"
    SQL="$BACKUP_PATH/$SITE-db_$DATE.sql"

    mkdir -p $BACKUP_PATH

    if [ -f $TGZ ]; then 
        echo "$TGZ exists! ... backup aborted."
        exit
    fi
    if [ -f $SQL ]; then 
        echo "$SQL exists! ... backup aborted."
        exit
    fi

    echo "Creating tar.gz file..."
    pushd $SITE_PATH ; tar czf $TGZ sites/ ; popd

    echo "Exporting database..."
    pushd $SITE_PATH ; drush sql-dump > $SQL && bzip2 $SQL ; popd

    echo "Script finished, check the backup to make sure it's ok."
}

help() {
  echo " == Script to backup drupal sites == "
  echo
  echo " 1) creates a backup of $WWW_PATH/site_name/sites/ in the current folder"
  echo "    with the name: site_name-sites_current_date.tar.gz"
  echo " 2) dumps the database of the site, the command used is:"
  echo "    drush sql-dump, and the file is named: site_name-db_current_date.sql.bz2"
  echo " 3) stores the resulting files in: $BACKUP_PATH/site_name/"
  echo
  echo " Usage: $0 site_name"
  echo
  echo " site_name : Creates a backup of the site in $WWW_PATH/site_name"
  echo
}

if [ "$1" == "" ]; then
    help;
else
    backup $1;
fi
