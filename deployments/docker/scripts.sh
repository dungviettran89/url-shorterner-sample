#Portainer can be used to manage docker
docker rm -f portainer
rm -rf /data/portainer
docker run \
  -d \
  --restart=always \
  -p 8000:8000 \
  -p 9443:9443 \
  --name portainer \
  -v /var/run/docker.sock:/var/run/docker.sock \
  -v /data/portainer:/data \
  portainer/portainer-ce:latest

#MariaDB can be installed easily
docker rm -f mariadb
rm -rf /data/urlshorterner/mariadb
docker run \
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
docker rm -f phpmyadmin
docker run \
  -d \
  --link mariadb:db \
  --restart=always \
  --name phpmyadmin \
  -p 6604:80 \
  phpmyadmin

#We can build Java backend with this
docker rm -f url-shortener-backend-java-spring
docker build -t dungviettran89/url-shortener-backend-java-spring:latest .
docker run -d --link mariadb:db --name url-shortener-backend-java-spring dungviettran89/url-shortener-backend-java-spring:latest
docker logs -f url-shortener-backend-java-spring

#We can build Node backend with this
docker rm -f url-shortener-backend-node-nestjs
docker build -t dungviettran89/url-shortener-backend-node-nestjs:latest .
docker run -d --link mariadb:db --name url-shortener-backend-node-nestjs dungviettran89/url-shortener-backend-node-nestjs:latest
docker logs -f url-shortener-backend-node-nestjs

#We can build Node front end with this
docker rm -f url-shortener-frontend-react
docker build -t dungviettran89/url-shortener-frontend-react:latest .
docker run -d --link url-shortener-backend-java-spring:backend --name url-shortener-frontend-react -p 80:80  dungviettran89/url-shortener-frontend-react:latest
docker logs -f url-shortener-frontend-react
