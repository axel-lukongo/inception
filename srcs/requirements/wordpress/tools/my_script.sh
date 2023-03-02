#!/bin/bash

# sed -ie 's/$DB_NAME/'$DB_OF_NAME'/' /var/www/wordpress/wp-config.php # replace $DB_NAME by $DB_DATA_BASE_NAME in wp-config.php file
# sed -ie 's/$DB_USER/'$DB_ADMIN'/' /var/www/wordpress/wp-config.php # replace $DB_USER by $DB_ADMIN in wp-config.php file 
# sed -ie 's/$DB_PASSWORD/'$DB_ADMIN_PASSWORD'/' /var/www/wordpress/wp-config.php # replace $DB_PASSWORD by $DB_ADMIN_PASSWORD in wp-config.php file

	echo "ici\n"
	echo "ici\n"
	echo "ici\n"
	echo "ici\n"
	echo "ici\n"
	echo "ici\n"
	echo "ici\n"
	echo "ici\n"
	echo "ici\n"
	echo "ici\n"
	echo "ici\n"
	echo "ici\n"
	echo "ici\n"
	echo "ici\n"
	echo "ici\n"
	echo "ici\n"
	echo "ici\n"
	echo "ici\n"
	echo "ici\n"
	echo "ici\n"
	echo "ici\n"
	echo "ici\n"
	echo "ici\n"
	echo "ici\n"
	echo "ici\n"
	echo "ici\n"
	echo "ici\n"
	echo "ici\n"
	echo "ici\n"
	echo "ici\n"
	echo "ici\n"
	echo "ici\n"


if [ -f /var/www/wordpress/wp-config.php ];then # if conf file exists 
    echo "----------------------sdscdsdc---------------------------------------sdvscsc------------------" # do nothing 
else
	echo "dedans\n"
	echo "dedans\n"
	echo "dedans\n"
	echo "dedans\n"
	echo "dedans\n"
	echo "dedans\n"
	echo "dedans\n"
	echo "dedans\n"
    cd /var/www/wordpress # go to wordpress directory  
	sleep 10; # wait for mysql to be ready to accept connections 
	
    wp core --allow-root download --locale=fr_FR

    # wp config create --allow-root --dbname=$DB_ADMIN --dbuser=$DB_ADMIN --dbpass=$DB_ADMIN_PASSWORD --dbhost=$DB_HOST --dbprefix=$DB_PREFIX
	echo "==============>>> creat wp-config.php <<<================"

	sleep 10
	wp core config --dbname=$DB_OF_NAME --dbuser=$DB_ADMIN --dbpass=$DB_ADMIN_PASSWORD --dbhost=$DB_HOST --dbcharset=$WP_CHARSET --dbprefix=wp_ --dbcollate="utf8_general_ci" --allow-root

	sleep 10

    wp core --allow-root install --url="https://alukongo.42.fr/" --title="Inception alukongo" --admin_name=$WP_ADMIN_USER --admin_email=$WP_ADMIN_EMAIL --admin_password=$WP_ADMIN_PASSWORD; 
    # install wordpress
	sleep 10

    wp --allow-root user create $WP_USER other@gmail.com --user_pass=$WP_USER_PASSWORD
    # create other user

    touch conf # create conf file to know that wordpress is configured
fi

exec /usr/sbin/php-fpm7.3 -F -R # start php-fpm server in foreground mode and restart it if it crashes 
