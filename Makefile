
all: up

up:
	cd srcs && sudo docker-compose up
down:
	cd srcs && sudo docker-compose down
	
clean:
	sudo docker system prune -af
re:
	cd srcs && docker-compose up --build