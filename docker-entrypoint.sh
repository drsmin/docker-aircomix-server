#! /bin/bash

htpasswd -bcm /data/.htpasswd AirComix ${PASSWORD}
service apache2 start

exec /bin/bash
