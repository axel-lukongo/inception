
if [ -f "/var/lib/mysql/entry" ];then #check if the database has been initialized before or not 
	exec mysqld 		#start the MariaDB service 
	exit 	#	exit the script	

else 
	service mysql restart  #start the MariaDB service and create the initial database and root user
	
	mysql -e "CREATE DATABASE $DB_NAME" 
	#create the database  with the name $DB_NAME

	mysql -e "CREATE USER '$DB_ADMIN'@'%' IDENTIFIED BY '$DB_ADMIN_PASSWORD'; GRANT ALL PRIVILEGES ON $DB_NAME.* TO '$DB_ADMIN'@'%' IDENTIFIED BY '$DB_ADMIN_PASSWORD' WITH GRANT OPTION; flush privileges;" 
	#create the admin user with the name $DB_ADMIN and password $DB_ADMIN_PASSWORD and grant all privileges to the database $DB_NAME to the user $DB_ADMIN 

	mysql -e "SET PASSWORD FOR 'root'@'localhost' = PASSWORD('$WP_BASE_PASS') ; flush privileges ;" 
	#change the root password to $WP_BASE_PASS
	
	touch /var/lib/mysql/entry
	#mark the database as initialized 

	chmod 777 /var/lib/mysql/*
	#change the permission of the database files to 777
	
	exec mysqld_safe
	#start the MariaDB service 
fi