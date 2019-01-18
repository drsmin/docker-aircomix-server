#! /bin/sh

htpasswd -bcm /data/.htpasswd AirComix ${PASSWORD}

exec /usr/sbin/httpd -D FOREGROUND -f /etc/apache2/httpd.conf
