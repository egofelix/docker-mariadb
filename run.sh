#!/bin/sh

if [ ! -d "/run/mysqld" ]; then
	mkdir -p /run/mysqld
	chown -R root:root /run/mysqld
fi

if [ ! -d /var/lib/mysql/mysql ]; then
	echo "[i] MySQL data directory not found, creating initial DBs"

	chown -R root:root /var/lib/mysql

	mysql_install_db --user=root > /dev/null

	if [ "$MYSQL_ROOT_PASSWORD" = "" ]; then
	    apk --no-cache add pwgen
	
		MYSQL_ROOT_PASSWORD=`pwgen 16 1`
		echo "[i] MySQL root Password: $MYSQL_ROOT_PASSWORD"
	fi

	tfile=`mktemp`
	if [ ! -f "$tfile" ]; then
	    return 1
	fi

	cat << EOF > $tfile
USE mysql;
FLUSH PRIVILEGES;
GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' identified by '$MYSQL_ROOT_PASSWORD' WITH GRANT OPTION;
GRANT ALL PRIVILEGES ON *.* TO 'root'@'localhost' identified by 'MYSQL_ROOT_PASSWORD' WITH GRANT OPTION;
UPDATE user SET password=PASSWORD("") WHERE user='root' AND host='localhost';
EOF

	/usr/bin/mysqld --user=root --bootstrap --verbose=0 < $tfile
	rm -f $tfile
fi

echo "[i] Starting MySQL"
exec /usr/bin/mysqld --user=root --console