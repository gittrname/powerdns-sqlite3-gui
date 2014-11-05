powerdns-sqlite3
================

Docker container with the latest Debian Jessie packages of Sqlite 3.8.7 and PowerDNS 3.4

Usage:

docker run -d --name pdns -p 53:53/udp -p 53:53/tcp -p 8053:8053 -v /your/shared/volume:/data -e "WEBPASSWD=password" powerdns-sqlite3:latest
