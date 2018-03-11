FROM ubuntu:16.04

MAINTAINER <annh1892@gmail.com>
WORKDIR .  /app

RUN apt-get update
RUN apt-get install -y nginx 
ENTRYPOINT ["/usr/sbin/nginx","-g","daemon off;"]

EXPOSE 80 
