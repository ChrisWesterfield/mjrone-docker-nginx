FROM debian:jessie

MAINTAINER Christopher Westerfield <chris@mjr.one>

RUN apt-get update && apt-get upgrade -y
RUN apt-get install build-essential zlib1g-dev libpcre3-dev libssl-dev libxslt1-dev libxml2-dev libgd2-xpm-dev libgeoip-dev libgoogle-perftools-dev libperl-dev libldap-dev libcurl4-gnutls-dev unzip apt-transport-https ca-certificates git -y
RUN cd /usr/src && git clone https://cwesterfield@bit.mjr.one/scm/public/nginx.git ./nginx && cd /usr/src/nginx && ./build.sh
RUN mkdir /etc/nginx/conf.d
RUN apt-get purge build-essential unzip gcc libc6-dev make apt-transport-https binutils build-essential bzip2 ca-certificates cpp cpp-4.9 dpkg-dev fakeroot openssh-client openssl patch perl perl-modules pkg-config rename rsync sgml-base shared-mime-info ucf unzip x11-common xauth xz-utils -y
RUN usermod -u 1000 www-data
RUN apt-get autoremove -y && apt-get clean && apt-get autoclean
RUN rm -Rf /usr/src/nginx
ADD nginx.conf /etc/nginx/
ADD server.key /etc/nginx/server.key
ADD server.crt /etc/nginx/server.crt
ADD dhparam.pem /etc/nginx/dhparam.pem
CMD ["nginx"]
EXPOSE 80
EXPOSE 443
