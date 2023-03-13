all: up

up:
		sudo systemctl restart docker 
		# sudo service mysql stop
		sudo docker-compose -f srcs/docker-compose.yml build #--no-cache
		sudo docker-compose -f srcs/docker-compose.yml up --force-recreate #-d --force-recreate


down:
		sudo docker-compose -f srcs/docker-compose.yml down 

ps:		
		sudo docker-compose -f srcs/docker-compose.yml ps -a
		sudo docker ps -a

clean:	down
		sudo docker system prune -af
		sudo docker system prune
		sudo docker volume rm srcs_db srcs_website
		sudo rm -rf /home/alukongo/data/db
		sudo rm -rf /home/alukongo/data/website
		
		mkdir -p /home/alukongo/data/db
		mkdir -p /home/alukongo/data/website

re : 	clean up

mariadb:
		sudo docker exec -it mariadb bash
nginx:
		sudo docker exec -it nginx bash

wordpress:
		sudo docker exec -it wordpress bash


.PHONY: start stop re ps clean