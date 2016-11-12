FROM hortonworks/ycloud-debian7:0.2

RUN usermod -u 99 nobody && groupmod -g 99 nogroup

RUN apt-get update && apt-get install --force-yes -y net-tools openssl libssl-dev varnish

COPY default.vcl /etc/varnish/default.vcl
COPY varnish /etc/init.d/varnish
COPY run.sh /
RUN chown -R nobody:nogroup /etc /var /var/run /run 

CMD /run.sh
