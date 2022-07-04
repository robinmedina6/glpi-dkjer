#!/bin/bash
# - Install GLPI if not already installed

docker-compose pause
docker run -d --name backup -v glpi_glpi_data:/var/www/html/glpi ubuntu:trusty tar -czvf /tmp/glpi_data.tgz /var/www/html/glpi
docker wait backup
docker cp backup:/tmp/glpi_data.tgz glpi_data.tgz
docker rm -fv backup
docker run -d --name backup -v glpi_mysql_data:/var/lib/mysql ubuntu:trusty tar -czvf /tmp/mysql_data.tgz /var/lib/mysql 
docker wait backup
docker cp backup:/tmp/mysql_data.tgz mysql_data.tgz
docker rm -fv backup