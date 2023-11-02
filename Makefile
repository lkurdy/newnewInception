NAME = inception

all : 
	sudo docker-compose -f srcs/docker-compose.yml up -d --build

up :
	sudo docker-compose -f srcs/docker-compose.yml up -d

stop : 
	sudo docker-compose -f srcs/docker-compose.yml stop

clean : 
	sudo docker-compose -f srcs/docker-compose.yml down

fclean: clean
	sudo docker system prune -af

re : fclean
	make all

.PHONY: all up stop clean fclean re
