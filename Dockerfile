FROM alpine:edge

MAINTAINER EgoFelix <docker@egofelix.de>

# Install mariadb
RUN apk --no-cache add \
    mariadb

# Entry
ENTRYPOINT /usr/bin/mysqld --user=mysql