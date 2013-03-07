#!/bin/bash

SERVER="s141"  # 192.168.1.141

FECHA=`date +"%d-%m-%Y"`
BACKUP_PATH="/root/backups"

bajar() {
    echo "status: bajando backup del servidor."
    SITE=$1
    TGZ="$SITE-sites_$FECHA.tar.gz"
    SQL="$SITE-db_$FECHA.sql.bz2"
    BACKUP_PATH="$BACKUP_PATH/$SITE"

    set -x  # show commands
    scp $SERVER:$BACKUP_PATH/$TGZ . &&
    scp $SERVER:$BACKUP_PATH/$SQL . &&
    set +x && \
    echo "status: Done!"
}

help() {
  echo "== ssh copy helper =="
  echo "Usage: $0 nombre_de_sitio"
  echo
  echo "   Baja al directorio actual los archivos que genero el script de backup de "
  echo "   sitios drupal que se encontraban en la carpeta $BACKUP_PATH/nombre_de_sitio/"
  echo "   Los archivos que se bajan son los del dia de hoy (fecha calculada automaticamente)."
  echo
}

if [ "$1" == "" ]; then
    help;
else
    bajar $1;
fi
