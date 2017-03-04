FROM debian:jessie

MAINTAINER Christopher Westerfield <chris@mjr.one>

RUN apt-get update
RUN apt-get upgrade -y
RUN apt-get install build-essential zlib1g-dev libpcre3-dev libssl-dev libxslt1-dev libxml2-dev libgd2-xpm-dev libgeoip-dev libgoogle-perftools-dev libperl-dev libldap-dev libcurl4-gnutls-dev unzip -y
RUN apt-get install -y apt-transport-https ca-certificates
RUN apt-get install git -y

RUN cd /usr/src && git clone https://cwesterfield@bit.mjr.one/scm/public/nginx.git ./nginx && cd /usr/src/nginx && ./build.sh

ADD nginx.conf /etc/nginx/
ADD server.key /etc/nginx/server.key
ADD server.crt /etc/nginx/server.crt
ADD dhparam.pem /etc/nginx/dhparam.pem

RUN mkdir /etc/nginx/conf.d
#RUN echo "upstream php-upstream { server php:9000; }" > /etc/nginx/conf.d/upstream.conf

RUN usermod -u 1000 www-data

CMD ["nginx"]

EXPOSE 80
EXPOSE 443
