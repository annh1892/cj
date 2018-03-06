FROM ubuntu:14.04

WORKDIR .  /app

ADD . /app
CMD sudo apt-get update \
              apt-get install nginx \
                service nginx start 

EXPOSE 80