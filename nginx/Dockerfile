FROM nginx

RUN usermod -u 99 nobody && groupmod -g 99 nogroup
RUN apt-get update && apt-get install -y php5-common php5-cli php5-fpm

COPY html /usr/share/nginx/html
COPY default.conf /etc/nginx/conf.d/default.conf
COPY nginx.conf /etc/nginx/nginx.conf
COPY www.conf /etc/php5/fpm/pool.d/www.conf
COPY run.sh /
RUN chown -R nobody:nogroup /etc /var /var/run /run /usr/share/nginx

CMD /run.sh
