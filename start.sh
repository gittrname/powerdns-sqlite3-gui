#!/bin/bash

if [[ ! -e /data/$SQLITE3_DB ]]; then
	echo "Creating new database $SQLITE3_DB"
	sqlite3 /data/$SQLITE3_DB < /opt/default_pdns.sql
fi

pdns_server --no-config --master --daemon=no --local-address=0.0.0.0 --launch=gsqlite3 --gsqlite3-database=/data/$SQLITE3_DB --webserver --webserver-address=0.0.0.0 --webserver-port=8053 --webserver-password=$WEBPASSWD --experimental-json-interface
