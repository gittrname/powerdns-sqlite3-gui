FROM ubuntu:14.04
MAINTAINER David Noyes <david@raspberrypython.com>

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && apt-get -yq upgrade

ADD ./powerdns_3.4.1-1_amd64.deb /tmp/powerdns_3.4.1-1_amd64.deb
ADD ./sqlite3_3.8.7.1-1_amd64.deb /tmp/sqlite3_3.8.7.1-1_amd64.deb

RUN dpkg -i /tmp/sqlite3_3.8.7.1-1_amd64.deb && \
    dpkg -i /tmp/powerdns_3.4.1-1_amd64.deb

RUN apt-get clean && apt-get -yq autoremove && rm -rf /var/lib/apt/lists/* /tmp/*

VOLUME ["/data"]

EXPOSE 53 8053

ENTRYPOINT ["pdns_server"]
CMD ["--no-config", "--master", "--daemon=no", "--local-address=0.0.0.0", "--launch=gsqlite3", "--gsqlite3-database=/data/${SQLITE3_DB}", "--webserver", "--webserver-address=0.0.0.0", "--webserver-port=8053", "--webserver-password=$WEBPASSWD", "--experimental-json-interface"]
