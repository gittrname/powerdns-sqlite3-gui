FROM debian:jessie
MAINTAINER David Noyes <david@raspberrypython.com>

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && apt-get -yq upgrade

RUN apt-get install -yq pdns-backend-sqlite3

RUN apt-get clean && apt-get -yq autoremove && rm -rf /var/lib/apt/lists/*

RUN rm -f /etc/powerdns/pdns.d/pdns.simplebind.conf

ADD ./start.sh /opt/start.sh

VOLUME ["/data"]

EXPOSE 53/udp 53/tcp 8053

ENTRYPOINT ["/opt/start.sh"]

CMD ["--master", "--daemon=no", "--local-address=0.0.0.0", "--launch=gsqlite3", "--webserver", "--webserver-address=0.0.0.0", "--webserver-port=8053", "--webserver-password=$WEBPASSWD", "--experimental-json-interface", "--experimental-api-key=$WEBPASSWD"]
