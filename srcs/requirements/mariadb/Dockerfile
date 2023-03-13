FROM    debian:buster

RUN     apt-get update \
        && apt-get -y install apt-utils mariadb-server mariadb-client \
        && rm -rf /var/lib/mysql \
        && mkdir -p /var/lib/mysql /run/mysqld \
        && chown -R mysql:mysql /var/lib/mysql  /run/mysqld \
        && chmod 777 /var/run/mysqld 

EXPOSE  3306

#i copy my script on sur root
COPY    ./tools/my_db_script.sh .

# i execute my script
ENTRYPOINT ["bash", "./my_db_script.sh"]