FROM nginx:1.10
COPY docker/nginx/vhost/vhost.conf /etc/nginx/conf.d/default.conf