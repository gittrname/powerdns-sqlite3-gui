#!/bin/bash

SQLITE3_DB=pdns.sqlite3
SQLITE3_DB_HOME=/var/lib/powerdns
DATA_VOLUME=/data


if [[ ! -e $SQLITE3_DB_HOME/$SQLITE3_DB.default ]]; then
    echo "Creating default database"
    mv $SQLITE3_DB_HOME/$SQLITE3_DB $SQLITE3_DB_HOME/$SQLITE3_DB.default
fi

if [[ ! -e $DATA_VOLUME/$SQLITE3_DB ]]; then
    echo "Cloning default database"
    cp -p $SQLITE3_DB_HOME/$SQLITE3_DB.default $DATA_VOLUME/$SQLITE3_DB
fi

if [[ ! -L $SQLITE3_DB_HOME/$SQLITE3_DB ]]; then
    echo "Linking existing DB from $DATA_VOLUME/$SQLITE3_DB to $SQLITE3_DB_HOME/$SQLITE3_DB"
    ln -s $DATA_VOLUME/$SQLITE3_DB $SQLITE3_DB_HOME/$SQLITE3_DB
fi

echo "Starting pdns_server"
/usr/sbin/pdns_server "$@"
