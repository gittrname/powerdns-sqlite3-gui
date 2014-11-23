FROM debian:jessie
MAINTAINER David Noyes <david@raspberrypython.com>

ENV DEBIAN_FRONTEND noninteractive
ENV WEBPASSWD changeme

RUN apt-get update && \
    apt-get install -yq pdns-server pdns-backend-sqlite3 && \
    apt-get clean && \
    apt-get -yq autoremove && \
    rm -rf /var/lib/apt/lists/*

RUN rm -f /etc/powerdns/pdns.d/pdns.simplebind.conf

COPY ./start.sh /opt/start.sh

VOLUME ["/data"]

EXPOSE 53/udp 53/tcp 80

ENTRYPOINT ["/opt/start.sh"]

