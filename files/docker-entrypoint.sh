#!/bin/bash

service cron start
cd /var/www/satis
npm run server &
/usr/sbin/apache2ctl -D FOREGROUND
