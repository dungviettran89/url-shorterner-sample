#Portainer can be used to manage docker
sudo docker rm -f portainer
sudo rm -rf /data/portainer
sudo docker run \
  -d \
  --restart=always \
  -p 8000:8000 \
  -p 9443:9443 \
  --name portainer \
  -v /var/run/docker.sock:/var/run/docker.sock \
  -v /data/portainer:/data \
  portainer/portainer-ce:latest

#MariaDB can be installed easily
sudo docker rm -f mariadb
sudo rm -rf /data/urlshorterner/mariadb
sudo docker run \
  -d \
  --restart=always \
  --name mariadb \
  -p 6603:3306 \
  -v /data/urlshorterner/mariadb:/var/lib/mysql \
  -e MARIADB_RANDOM_ROOT_PASSWORD=yes \
  -e MYSQL_DATABASE=urlshortener \
  -e MYSQL_USER=urlshortener \
  -e MYSQL_PASSWORD=urlshortener \
  mariadb:10.6

#phpmyadmin can be installed to manage mariadb
sudo docker rm -f phpmyadmin
sudo docker run \
  -d \
  --link mariadb:db \
  --restart=always \
  --name phpmyadmin \
  -p 6604:80 \
  phpmyadmin

#We can build Java backend with this
sudo docker rm -f url-shortener-backend-java-spring
sudo docker build -t dungviettran89/url-shortener-backend-java-spring:latest .
sudo docker run -d --link mariadb:db --name url-shortener-backend-java-spring dungviettran89/url-shortener-backend-java-spring:latest
sudo docker logs -f url-shortener-backend-java-spring

#We can build Node backend with this
sudo docker rm -f url-shortener-backend-node-nestjs
sudo docker build -t dungviettran89/url-shortener-backend-node-nestjs:latest .
sudo docker run -d --link mariadb:db --name url-shortener-backend-node-nestjs dungviettran89/url-shortener-backend-node-nestjs:latest
sudo docker logs -f url-shortener-backend-node-nestjs

#We can build Node front end with this
sudo docker rm -f url-shortener-frontend-react
sudo docker build -t dungviettran89/url-shortener-frontend-react:latest .
sudo docker run -d --link url-shortener-backend-java-spring:backend --name url-shortener-frontend-react -p 80:80  dungviettran89/url-shortener-frontend-react:latest
sudo docker logs -f url-shortener-frontend-react
