#!/bin/bash
# - Install GLPI if not already installed
# - Run apache in foreground
### GENERAL CONF ###############################################################
APACHE_DIR="/var/www/html"
GLPI_DIR="${APACHE_DIR}/glpi"
#GLPI_SOURCE_URL=${GLPI_SOURCE_URL:-"https://forge.glpi-project.org/attachments/download/2020/glpi-0.85.4.tar.gz"}
GLPI_SOURCE_URL=${GLPI_SOURCE_URL:-"https://github.com/glpi-project/glpi/releases/download/9.5.3/glpi-9.5.3.tgz"}
### INSTALL GLPI IF NOT INSTALLED ALREADY ######################################

if [ "$(ls -A $GLPI_DIR/asdfads)" ]; then
  echo "GLPI is already installed at ${GLPI_DIR}"
else
  echo '-----------> Install GLPI <----------'
  echo "Using ${GLPI_SOURCE_URL}"
  #wget -O /tmp/glpi.tar.tgz $GLPI_SOURCE_URL --no-check-certificate
  tar -C $APACHE_DIR -xf /tmp/glpi.tar.tgz
  #GLPI_PLUGINS="${GLPI_DIR}/plugins"
  ##instalacion plugins
  #tar -C $GLPI_PLUGINS -xf /tmp/fusioninventory95.tar.bz2
fi

if [ "$(ls -A $GLPI_DIR/plugins/fusioninventory)" ]; then
  echo "plugins is already installed at ${GLPI_DIR}"
else
  echo '-----------> Install plugins <----------'
  ##instalacion plugins
  cp -R  /home/plugins $GLPI_DIR
fi


### REMOVE THE DEFAULT INDEX.HTML TO LET HTACCESS REDIRECTION ##################
# rm ${APACHE_DIR}/index.html
if [ "${GLPI_CERT}" = "0" ]; then
echo "nossl"
    a2dissite glpi-ssl.conf
    a2ensite 000-default.conf
else
echo "ssl"
  a2enmod ssl
  #openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/ssl/private/glpi-selfsigned.key -out /etc/ssl/certs/glpi-selfsigned.crt
  a2ensite glpi-ssl.conf
  a2dissite 000-default.conf
  #rm /etc/apache2/sites-enabled/000-default.conf
fi
HTACCESS="/var/www/html/.htaccess"
# /bin/cat <<EOM >$HTACCESS
# RewriteEngine On
# RewriteRule ^$ /glpi [L]
# EOM
# chown www-data /var/www/html/.htaccess
#chown www-data .
chown -R www-data $APACHE_DIR
##cambio srobinson
# sed -i 's/;extension=intl/extension=intl/' /etc/php/7.2/apache2/php.ini

### RUN APACHE IN FOREGROUND ###################################################

# stop apache service
# service apache2 stop
service apache2 restart

# start apache in foreground
# source /etc/apache2/envvars
# /usr/sbin/apache2 -D FOREGROUND
tail -f /var/log/apache2/error.log -f /var/log/apache2/access.log
