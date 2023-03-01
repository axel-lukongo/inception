
# sed -ie 's/$DB_USER/'$DB_ADMIN'/' /var/www/wordpress/confg/wp-config.php # replace $DB_USER by $DB_ADMIN in wp-config.php file 
# sed -ie 's/$DB_NAME/'$DB_NAME'/' /var/www/wordpress/confg/wp-config.php # replace $DB_NAME by $DB_NAME in wp-config.php file
# sed -ie 's/$DB_PASSWORD/'$DB_ADMIN_PASSWORD'/' /var/www/wordpress/config/wp-config.php # replace $DB_PASSWORD by $DB_ADMIN_PASSWORD in wp-config.php file

# if [ -f "/var/www/wordpress/conf" ];then # if conf file exists 
#     echo "i do nothing" # do nothing 
# else
#     cd /var/www/wordpress # go to wordpress directory  

# 	sleep 10; # wait for mysql to be ready to accept connections 
	
#     wp core --allow-root download --locale=fr_FR
    
#     # install wordpress
#     wp config create --allow-root --dbname=$DB_ADMIN --dbuser=$DB_ADMIN --dbpass=$DB_ADMIN_PASSWORD --dbhost=$DB_HOST --dbprefix=$DB_PREFIX

#     wp core --allow-root install --url="https://alukongo.42.fr/" --title="Inception alukongo" --admin_name=$WP_ADMIN_USER --admin_email=$WP_ADMIN_EMAIL --admin_password=$WP_ADMIN_PASSWORD; 
#     # 1/10 [--dbpass=<dbpass>]: type_your_password
#     # Success: Generated 'wp-config.php' file.


#     wp --allow-root user create $WP_USER other@gmail.com --user_pass=$WP_USER_PASSWORD
#     # create other user

#     touch conf # create conf file to know that wordpress is configured
# fi

# exec /usr/sbin/php-fpm7.3 -F -R # start php-fpm server in foreground mode and restart it if it crashes 







#!/bin/bash

wp core download --locale=fr_FR --allow-root

sleep 2

if [ -f /var/www/html/wp-config.php ]
then
	echo "===> wp-config.php already exist <==="
	sleep 2
else
echo "===> create wp-config.php <==== "
sleep 5

wp core config  --dbname=$DB_NAME \ #
                --dbuser=$WP_ADMIN_USER \ #
                --dbpass=$WP_ADMIN_PASSWORD \ #
                --dbhost=$DB_ADMIN \ #
                --dbcharset=$WP_CHARSET \
                --dbprefix=wp_ \
                --dbcollate="utf8_general_ci" \
                --allow-root

echo "===>  Install Wordpress <==== "
sleep 5

wp core install --url="alukongo.42.fr" \
                --title=INCEPTION \
                --admin_user=$WP_ADMIN_USER\ #
                --admin_password=$WP_ADMIN_PASSWORD \ #
                --admin_email=$WP_ADMIN_EMAIL \ #
                --allow-root
echo "===> Create a user <==="
sleep 5

wp user create $WP_USER $WP_USER_EMAIL --role=author --user_pass=$WP_USER_PASSWORD --allow-root

fi
chown -R www-data:www-data /var/www/*
chmod -R 755 /var/www/*
echo "===> WORDPRESS IS UP <==="
exec php-fpm7.3 -F -R