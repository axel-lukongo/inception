#!/bin/sh

wp core download --locale=fr_FR --allow-root

sleep 2

if [ -f /var/www/html/wp-config.php ]
then
	echo "===> wp-config.php already exist <==="
	sleep 2
else
echo "===> create wp-config.php <==== "
sleep 5

wp core config  --dbname=$NAME_OF_DB \
                --dbuser=$WP_ADMIN \
                --dbpass=$WP_ADMIN_PASSWORD \
                --dbhost=$DB_HOST_NAME \
                --dbcharset=$WP_CHARSET \
                --dbprefix=wp_ \
                --dbcollate="utf8_general_ci" \
                --allow-root

echo "===>  Install Wordpress <==== "
sleep 5

wp core install --url="alukongo.42.fr" \
                --title=INCEPTION \
                --admin_user=$WP_ADMIN\
                --admin_password=$WP_ADMIN_PASSWORD \
                --admin_email=$WP_ADMIN_EMAIL \
                --allow-root
echo "===> Create a user <==="
sleep 5

wp user create $WP_USER $WP_USER_EMAIL --role=author --user_pass=$WP_USER_PASSWORD --allow-root

fi
chown -R www-data:www-data /var/www/*
chmod -R 755 /var/www/*
echo "===> WORDPRESS IS UP <==="
exec php-fpm7.3 -F -R