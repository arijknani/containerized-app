podman build -t my-app .

podman network create -d bridge app-network

podman run --name mysql-container --network=app-network -e MYSQL_ROOT_PASSWORD=Arijk123* -e MYSQL_DATABASE=my-app -v $(pwd)/mysql_data:/var/lib/mysql  -d -p 3306:3306 mysql

podman run --name springboot-app-container --network=app-network -e DB_URL=jdbc:mysql://mysql-container:3306/my-app -e DB_USERNAME=root -e DB_PASSWORD=Arijk123* -e -d -p 8080:8080 my-app

podman exec -it mysql-container bash

mysql -u root -p
SHOW DATABASES;
use my-app;
SHOW tables;
DESCRIBE user;
SELECT * FROM user;
