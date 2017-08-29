FROM alpine:edge

MAINTAINER EgoFelix <docker@egofelix.de>

# Install mariadb
RUN apk --no-cache add \
    mariadb


EXPOSE 3306
VOLUME ["/var/lib/mysql"]
ENTRYPOINT /usr/bin/mysqld --user=mysql