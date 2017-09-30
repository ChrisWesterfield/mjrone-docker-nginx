FROM debian:jessie

MAINTAINER Christopher Westerfield <chris@mjr.one>

RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install  -y \
        build-essential \
        zlib1g-dev \
        libpcre3-dev \
        libssl-dev \
        libxslt1-dev \
        libxml2-dev \
        libgd2-xpm-dev \
        libgeoip-dev \
        libgoogle-perftools-dev \
        libperl-dev \
        libldap-dev \
        libcurl4-gnutls-dev \
        unzip \
        apt-transport-https \
        ca-certificates \
        git && \
    cd /usr/src && \
    git clone https://bit.mjr.one/scm/public/nginx.git ./nginx && \
    cd /usr/src/nginx/nginx-1.13.4 && \
    ./configure \
      --prefix=/usr/share/nginx \
      --sbin-path=/usr/sbin/nginx \
      --conf-path=/etc/nginx/nginx.conf \
      --pid-path=/var/run/nginx.pid \
      --lock-path=/var/lock/nginx.lock \
      --error-log-path=/var/log/nginx.error.log \
      --http-log-path=/var/log/nginx.access.log \
      --user=www-data \
      --group=www-data \
      --build=MJR-ONE-NGINX-1.13.4 \
      --with-threads \
      --with-file-aio \
      --with-http_gzip_static_module \
      --with-http_realip_module \
      --with-http_xslt_module \
      --with-http_geoip_module \
      --with-http_dav_module \
      --with-http_flv_module \
      --with-http_mp4_module \
      --with-http_gunzip_module \
      --with-http_secure_link_module \
      --with-http_random_index_module \
      --with-http_auth_request_module \
      --with-http_stub_status_module \
      --with-http_perl_module \
      --with-mail=dynamic \
      --with-mail_ssl_module \
      --with-stream=dynamic \
      --with-stream_ssl_module \
      --with-google_perftools_module \
      --with-pcre \
      --add-dynamic-module=/usr/src/nginx/headers-more-nginx-module-master \
      --add-dynamic-module=/usr/src/nginx/naxsi-master/naxsi_src \
      --add-dynamic-module=/usr/src/nginx/nginx-upload-progress-module-master \
      --add-dynamic-module=/usr/src/nginx/ngx_http_accounting_module-master \
      --add-dynamic-module=/usr/src/nginx/nginx-module-vts-master \
      --add-dynamic-module=/usr/src/nginx/graphite-nginx-module-master \
      --with-http_ssl_module \
      --with-http_v2_module && \
    make && \
    make install && \
    mkdir /etc/nginx/sites.d && \
    apt-get purge -y \
        build-essential \
        unzip \
        gcc \
        libc6-dev \
        make \
        apt-transport-https \
        binutils \
        build-essential \
        bzip2 \
        ca-certificates \
        cpp \
        cpp-4.9 \
        dpkg-dev \
        fakeroot \
        openssh-client \
        openssl \
        patch \
        perl \
        perl-modules \
        pkg-config \
        rename \
        rsync \
        sgml-base \
        shared-mime-info \
        ucf \
        unzip \
        x11-common \
        xauth \
        xz-utils && \
    usermod -u 1000 www-data && \
    apt-get autoremove -y && \
    apt-get clean && \
    apt-get autoclean && \
    rm -Rf /usr/src/nginx && \
    rm -Rf /usr/src/* && \
    rm -rf /var/lib/apt/lists/* && \
    rm /etc/nginx/nginx.conf

ADD nginx.conf /etc/nginx/
USER www-data
CMD ["nginx"]
EXPOSE 80
EXPOSE 443
