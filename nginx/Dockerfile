FROM nginx

RUN apt-get update && apt-get install -y php5-common php5-cli php5-fpm

COPY html /usr/share/nginx/html

COPY default.conf /etc/nginx/conf.d/default.conf
