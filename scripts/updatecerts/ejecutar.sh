#!/bin/bash
echo "Actualizando certificados en las rutas determinadas"
FILE1=/home/scripts/updatecerts/glpi-signed.crt
FILE2=/home/scripts/updatecerts/glpi-signed.key
if test -f "$FILE1"; then
    echo "$FILE1 existe."
    if test -f "$FILE2"; then
        echo "$FILE2 existe"
        rm /etc/ssl/glpi/certs/glpi-selfsigned.crt
        rm /etc/ssl/glpi/private/glpi-selfsigned.key
        cp /home/scripts/updatecerts/glpi-signed.crt /etc/ssl/glpi/certs/glpi-selfsigned.crt
        cp /home/scripts/updatecerts/glpi-signed.key /etc/ssl/glpi/private/glpi-selfsigned.key
    fi
fi
service apache2 restart