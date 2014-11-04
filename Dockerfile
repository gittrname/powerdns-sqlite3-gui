FROM ubuntu:14.04
MAINTAINER David Noyes <david@raspberrypython.com>

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && apt-get -yq upgrade

ADD ./pdns-server_3.4.1-1_amd64.deb /tmp/pdns-server_3.4.1-1_amd64.deb
ADD ./sqlite3_3.8.7.1-1_amd64.deb /tmp/sqlite3_3.8.7.1-1_amd64.deb
ADD ./default_pdns.sql /opt/default_pdns.sql
ADD ./start.sh /opt/start.sh

RUN dpkg -i /tmp/sqlite3_3.8.7.1-1_amd64.deb && \
    apt-get install -yq libboost-serialization1.54.0 && \
    dpkg -i /tmp/pdns-server_3.4.1-1_amd64.deb

RUN apt-get clean && apt-get -yq autoremove && rm -rf /var/lib/apt/lists/* /tmp/*

VOLUME ["/data"]

EXPOSE 53/udp 53/tcp 8053

ENTRYPOINT ["/opt/start.sh"]

#ENTRYPOINT ["pdns_server"]
#CMD ["--no-config", "--master", "--daemon=no", "--local-address=0.0.0.0", "--launch=gsqlite3", "--gsqlite3-database=/data/${SQLITE3_DB}", "--webserver", "--webserver-address=0.0.0.0", "--webserver-port=8053", "--webserver-password=$WEBPASSWD", "--experimental-json-interface"]
