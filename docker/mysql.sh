#!/bin/bash
[ ! -d /docker_data ] && mkdir -p /docker_data/mysql/conf/mysql.conf.d

docker rm -f mysql5.7
docker run --name mysql5.7 -p 3306:3306 \
   -e MYSQL_ROOT_PASSWORD=123456 \
   -v /docker_data/mysql/data:/var/lib/mysql \
   -v /docker_data/mysql/conf:/etc/mysql \
   -v /docker_data/mysql/logs:/var/log/mysql  \
   -d mysql:5.7


