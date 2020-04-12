FROM ubuntu:bionic

MAINTAINER DKing <dking@tot.im>

LABEL Vendor="DKing"
LABEL Description="php 7.2 for WHMCS with deps"
LABEL Version="1.0.0"

WORKDIR "/var/www/whmcs"
EXPOSE 80

ARG DEBIAN_FRONTEND=noninteractive

RUN usermod -u 1000 www-data && groupmod -g 1000 www-data
RUN mkdir -p /run/php /usr/local/ioncube 


# Install selected extensions and other stuff
RUN apt-get update -yqq
RUN apt-get install -y tzdata ca-certificates gcc make wget mc curl sendmail nginx php7.2-fpm openssl
RUN dpkg-reconfigure -f noninteractive tzdata
RUN apt-get install -y php7.2-common php7.2-mysql php7.2-curl php7.2-gd php7.2-json php7.2-imap php7.2-mbstring php7.2-iconv php7.2-xml

COPY start.sh /start.sh
RUN chmod 0755 /start.sh
COPY ioncube_loader_lin_7.2.so /usr/local/ioncube/ioncube_loader_lin_7.2.so
COPY ioncube.ini /etc/php/7.2/mods-available/ioncube.ini
RUN ln -s /etc/php/7.2/mods-available/ioncube.ini  /etc/php/7.2/fpm/conf.d/00-ioncube.ini
RUN ln -s /etc/php/7.2/mods-available/ioncube.ini  /etc/php/7.2/cli/conf.d/00-ioncube.ini

RUN echo "include(\`/etc/mail/tls/starttls.m4')dnl"  >>  /etc/mail/sendmail.mc
RUN sendmailconfig

# RUN apt-get clean; rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /usr/share/doc/*
CMD ["/start.sh"]
