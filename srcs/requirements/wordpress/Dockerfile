FROM debian:buster

# apt-get update is used to update the debian image -q is for quiet mode quiet mode is used to avoid the output of the update
RUN apt-get update -yq

# install php-fpm  
RUN apt install php-fpm -yq

RUN apt-get -y install php-cli php-mysql php-curl php-gd php-intl

# expose the port 9000 to the host machine
EXPOSE 9000

# set the working directory to the var/www directory
WORKDIR /var/www/

# update the debian image 
RUN apt-get update -yq  

# update the debian image and install wget  install php7.3 php-mysqli php-fpm  
RUN apt-get install wget -yq && apt-get install -yq php7.3 php-mysqli php-fpm

# download the wp-cli.phar file 
RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar

# make the wp-cli.phar file executable and move it to the usr/local/bin directory 
RUN chmod +x wp-cli.phar && mv wp-cli.phar /usr/local/bin/wp

# RUN mkdir -p /var/www/wordpress/config/
# set the working directory to the root directory
WORKDIR /
COPY /conf/www.conf etc/php/7.3/fpm/pool.d


# COPY /conf/wp-config.php /var/www/wordpress/config

COPY ./tools/my_script.sh /var/www/
COPY ./ /var/www/wordpress/


# RUN chmod 777 /var/www/wordpress/config/wp-config.php
RUN chmod +x /var/www/my_script.sh

# stop the php7.3-fpm service 
RUN  service php7.3-fpm start && service php7.3-fpm stop 

# set the my_script to the my_script.sh file
ENTRYPOINT [ "/var/www/my_script.sh" ] 
