FROM alpine:edge

MAINTAINER EgoFelix <docker@egofelix.de>

# Install mariadb
RUN apk --no-cache add \
    mariadb

ADD run.sh /run.sh
RUN chmod 755 /run.sh

EXPOSE 3306
VOLUME ["/var/lib/mysql"]
ENTRYPOINT ["/run.sh"]