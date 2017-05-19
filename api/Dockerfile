FROM alpine:3.5
MAINTAINER Kyle Bai <kyle.b@inwinstack.com>

RUN apk add --no-cache \
  curl \
  git \
  apache2 \
  php5 \
  php5-apache2 \
  php5-json \
  php5-phar \
  php5-openssl \
  php5-curl \
  php5-xsl \
  php5-mcrypt \
  php5-ctype \
  php5-pdo \
  php5-pdo_mysql && \
  curl -sS https://getcomposer.org/installer -o setup.php && \
  php setup.php --install-dir=/usr/local/bin --filename=composer && \
  rm setup.php && \
  git clone https://github.com/inwinstack/s3-portal-api.git -b dev /app && \
  cd /app && composer install && \
  cp .env.example .env && \
  mkdir /run/apache2 && \
  chown -R apache:apache /app && \
  composer clearcache && \
  apk del --no-cache git && \
  rm -f /usr/local/bin/composer && \
  rm -f /var/cache/apk/*

RUN sed -i "s/#LoadModule\ rewrite_module/LoadModule\ rewrite_module/" /etc/apache2/httpd.conf && \
  sed -i "s#^DocumentRoot \".*#DocumentRoot \"/app/public\"#g" /etc/apache2/httpd.conf && \
  sed -i "s#/var/www/localhost/htdocs#/app/public#" /etc/apache2/httpd.conf && \
  printf "\n<Directory \"/app/public\">\n\tRewriteEngine on\n\tAllowOverride All\n</Directory>\n" >> /etc/apache2/httpd.conf

COPY entrypoint.sh /usr/local/bin/
COPY check.php /app/check.php

WORKDIR /app
EXPOSE 80 443

ENTRYPOINT ["entrypoint.sh"]
