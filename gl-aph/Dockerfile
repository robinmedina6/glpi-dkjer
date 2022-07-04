FROM ubuntu:18.04
#MAINTAINER cedric@zestprod.com
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update 

#RUN sudo apt-get install -y software-properties-common \
#  && add-apt-repository -y  ppa:ondrej/php  && apt-get update 

RUN apt-get install -y  \
  apache2 \
  wget \
  php libapache2-mod-php php-mysql \
  php-mysql \
  php-ldap \
  php-xmlrpc \
  curl \
  php-curl \
  php-gd \
  php-mbstring \
  php-simplexml \
  php-xml \
  php-apcu \
  php-imap \
   php-cas \
  php-zip \
  php-intl \
  php-bz2 \
  cron \
  nano

#  php5.6  php5.6-mysql  php5.6-ldap   php5.6-xmlrpc   curl   php5.6-curl  php5.6-gd  php5.6-mbstring \
#  php5.6-simplexml  php5.6-xml  php5.6-apcu php5.6-imap

RUN a2enmod rewrite && service apache2 stop
RUN a2enmod ssl
WORKDIR /var/www/html
COPY glpi-9.5.0.tgz /tmp/../tmp/glpi.tar.tgz
COPY start.sh /opt/../opt/../opt/../opt/../opt/
COPY aph-siteaval/ /etc/apache2/sites-available/
COPY ssl-glpi/ /etc/ssl/glpi/
COPY plugins/ /home/plugins
RUN chmod +x /opt/start.sh
#RUN mkdir /etc/ssl/glpi/ && mkdir /etc/ssl/glpi/private && mkdir /etc/ssl/glpi/certs
#RUN usermod -u 1000 www-data
#RUN rm -R /var/www/html/glpi
CMD /opt/start.sh
EXPOSE 80
EXPOSE 443
