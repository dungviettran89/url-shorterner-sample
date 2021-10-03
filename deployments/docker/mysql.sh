sudo docker run \
  -d \
  --restart=always \
  -p 8000:8000 \
  -p 9443:9443 \
  --name portainer \
  -v /var/run/docker.sock:/var/run/docker.sock \
  -v /data/portainer:/data \
  portainer/portainer-ce:latest

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

sudo docker run \
  -d \
  --link mysql:db \
  --restart=always \
  --name phpmyadmin \
  -p 6604:80 \
  phpmyadmin