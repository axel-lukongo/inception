# #!/bin/sh
# set -eux
# #check if wp-config.php exist
# if [ -f ./wp-config.php ]
# then
# 	echo "wordpress already downloaded"
# else

# ####### MANDATORY PART ##########

# 	#Download wordpress and all config file
# 	wget http://wordpress.org/latest.tar.gz
# 	tar xfz latest.tar.gz
# 	mv wordpress/* .
# 	rm -rf latest.tar.gz
# 	rm -rf wordpress

# 	#Inport env variables in the config file
# 	sed -i "s/username_here/$MYSQL_USER/g" wp-config-sample.php
# 	sed -i "s/password_here/$MYSQL_PASSWORD/g" wp-config-sample.php
# 	sed -i "s/localhost/$MYSQL_HOSTNAME/g" wp-config-sample.php
# 	sed -i "s/database_name_here/$MYSQL_DATABASE/g" wp-config-sample.php
# 	cp wp-config-sample.php wp-config.php
# ###################################

# ####### BONUS PART ################

# ## redis ##



# ###  end of redis part  ###

# ###################################
# fi

# exec "$@"


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

wp core config  --dbname=$MYSQL_DB_NAME \
                --dbuser=$WP_ADMIN \
                --dbpass=$WP_ADMIN_PASSWORD \
                --dbhost=$MYSQL_DB_HOST \
                --dbcharset=$WP_CHARSET \
                --dbprefix=wp_ \
                --dbcollate="utf8_general_ci" \
                --allow-root

echo "===>  Install Wordpress <==== "
sleep 5

wp core install --url="idouidi.42.fr" \
                --title=INCEPTION \
                --admin_user=$WP_ADMIN\
                --admin_password=$WP_ADMIN_PASSWORD \
                --admin_email=$WP_ADMIN_EMAIL \
                --allow-root
echo "===> Create a user <==="
sleep 5

wp user create $WP_USER $WP_USER_EMAIL --role=author --user_pass=123 --allow-root

fi
chown -R www-data:www-data /var/www/*
chmod -R 755 /var/www/*
echo "===> WORDPRESS IS UP <==="
exec php-fpm7.3 -F -R