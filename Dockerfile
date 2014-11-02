FROM ubuntu:14.04
MAINTAINER David Noyes <david@raspberrypython.com>

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && apt-get -yq dist-upgrade && \
    apt-get install -yq wget \
                        build-essential \
                        git

RUN wget http://www.sqlite.org/2014/sqlite-autoconf-3080701.tar.gz -O - | tar -xz -C /tmp && \
    cd /tmp/sqlite-autoconf-3080701 && \
    ./configure && \
    make && \
    make install

RUN apt-get install -yq autoconf automake bison flex g++ git libboost-all-dev libtool make pkg-config ragel libmysqlclient-dev

RUN cd /tmp && \
    git clone https://github.com/PowerDNS/pdns.git && \
    cd pdns && \
    ./bootstrap && \
    ./configure --with-modules="gsqlite3" --without-lua && \
    make && \
    make install

RUN apt-get purge -yq wget \
                     build-essential 
                     git && \
    apt-get clean && apt-get -yq autoremove && rm -rf /var/lib/apt/lists/* /tmp/*

VOLUME ["/data"]

EXPOSE 53 8053

ENTRYPOINT ["pdns_server"]
CMD ["--no-config", "--master", "--daemon=no", "--local-address=0.0.0.0", "--launch=gsqlite3", "--gsqlite3-database=/data/${SQLITE3_DB}", "--webserver", "--webserver-address=0.0.0.0", "--webserver-port=8053", "--webserver-password=$WEBPASSWD"]
