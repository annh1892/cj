FROM ubuntu:14.04

WORKDIR .  /app

ADD . /app
CMD yum install nginx \
                service nginx start 

EXPOSE 80