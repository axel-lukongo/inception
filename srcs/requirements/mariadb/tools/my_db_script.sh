#!/bin/bash

cat <<EOF > /etc/mysql/my.cnf
[mysqld]
user = root
port = 3306
datadir = /var/lib/mysql
bind-address = 0.0.0.0
skip-bind-address
skip-networking = false
pid-file = /run/mysqld/mysqld.pid
socket = /run/mysqld/mysqld.sock
EOF

if [ -d /var/lib/mysql/mysql ]; then 
	echo "===> $NAME_OF_DB already exist !"
else
	echo "Create DATABASE $NAME_OF_DB"
	mysql_install_db --datadir=/var/lib/mysql
	mysqld_safe &
	sleep 2

	mysql -u  root  --skip-password << EOF
ALTER USER 'root'@'localhost' IDENTIFIED BY '${PASSWORD_OF_DB}';
CREATE DATABASE  IF NOT EXISTS $NAME_OF_DB CHARACTER SET utf8 COLLATE utf8_general_ci;
CREATE USER  IF NOT EXISTS '$WP_ADMIN'@'%' IDENTIFIED by '$WP_ADMIN_PASSWORD';
GRANT ALL PRIVILEGES ON $NAME_OF_DB.* TO '$WP_ADMIN'@'%';
FLUSH PRIVILEGES;
EOF
	mysqladmin -u root -p$PASSWORD_OF_DB shutdown
	sleep 2
fi

exec mysqld -u root