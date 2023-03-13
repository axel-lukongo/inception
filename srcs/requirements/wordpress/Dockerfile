FROM    debian:buster

RUN     apt-get -y update \
        && apt-get install -y  \
        php7.3-cli \
        php7.3-common \
        php7.3-curl \
        php7.3-mbstring \
        php7.3-mysql \
        php-fpm curl \
        mariadb-client \
        curl 

EXPOSE  9000

#i copy my config file in pool.d
COPY    ./config/www.conf /etc/php/7.3/fpm/pool.d/

RUN     mkdir -p /run/php

# i move in this repo
WORKDIR /var/www/html/

# i install the CLI
RUN     curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && php wp-cli.phar --info 
RUN     chmod +x wp-cli.phar
RUN     mv wp-cli.phar /usr/local/bin/wp
RUN     wp --info
COPY    ./tools/my_script.sh .

ENTRYPOINT ["bash", "my_script.sh"]



