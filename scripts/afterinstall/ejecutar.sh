#!/bin/bash
echo "configuracion crontab"
crontab -l | grep -v 'glpi' > mycron
echo "* * * * * /usr/bin/php /var/www/html/glpi/front/cron.php &>/dev/null" >> mycron
echo "* * * * * echo \$(date) > /home/cronejecucionglpi.log" >> mycron
crontab mycron
rm mycron
crontab -l
echo "borrar el archivo de instalacion"
rm /var/www/html/glpi/install/install.php
service cron start