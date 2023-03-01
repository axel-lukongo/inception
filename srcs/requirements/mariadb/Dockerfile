FROM debian:buster
# 

RUN apt-get update -yq
# update the debian image -q is for quiet mode quiet mode is used to avoid the output of the update

RUN apt-get upgrade -y
# update the debian image and upgrade the packages 

RUN apt-get install -y mariadb-server
# install mariadb-server   

EXPOSE 3306
# expose the port 3306 to the host machine 

COPY ./conf/50-server.cnf /etc/mysql/mariadb.conf.d
COPY ./ /var/www/
# copy the conf file to the mariadb.conf.d folder and copy the whole folder to the var/www folder

RUN service mysql start 
#start the mysql server 

COPY tools/my_script.sh /my_script.sh
# copy the my_script.sh file to the root directory 

VOLUME  "/var/lib/mysql"
# create a volume to the mysql folder 

ENTRYPOINT  [ "sh", "my_script.sh"]
# start the my_script.sh file in the foreground so that the container does not stop 
