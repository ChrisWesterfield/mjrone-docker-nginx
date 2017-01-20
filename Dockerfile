FROM debian:jessie

MAINTAINER Christopher Westerfield <chris@mjr.one>

RUN apt-get update && apt-get install -y \
    nginx vim nmap

ADD nginx.conf /etc/nginx/
ADD server.key /etc/nginx/server.key
ADD server.crt /etc/nginx/server.crt
ADD dhparam.pem /etc/nginx/dhparam.pem


RUN echo "upstream php-upstream { server php:9000; }" > /etc/nginx/conf.d/upstream.conf

RUN usermod -u 1000 www-data

CMD ["nginx"]

EXPOSE 80
EXPOSE 443
