FROM alpine

MAINTAINER EgoFelix <docker@egofelix.de>

# Install mariadb
RUN apk --no-cache add \
    mariadb sed

# Enable networking
RUN sed -ri -e 's/^(bind-address|skip-networking|socket)/#\1/' /etc/my.cnf.d/mariadb-server.cnf

COPY run.sh /run.sh
RUN chmod 755 /run.sh

EXPOSE 3306
VOLUME ["/var/lib/mysql"]
ENTRYPOINT ["/run.sh"]
