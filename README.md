powerdns-sqlite3
================

Docker container with the latest Debian Jessie packages of Sqlite 3.8.7 and PowerDNS 3.4

Usage:

docker run -d --name pdns -p 53:53/udp -p 53:53/tcp -p 8053:8053 -v /your/shared/volume:/data -e "WEBPASSWD=password" raspberrypython/powerdns-sqlite3 --master --daemon=no --local-address=0.0.0.0 --launch=gsqlite3 --webserver --webserver-address=0.0.0.0 --webserver-port=8053 --webserver-password=$WEBPASSWD --experimental-json-interface --experimental-api-key=$WEBPASSWD

Possible additional parameter
--gsqlite3-database=/data/pdns.sqlite3      Trying to use symlinks at start up to get the mounted database into the default location but so far no luck. Use this to force to the data volume
