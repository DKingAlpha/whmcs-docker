#!/bin/bash

/etc/init.d/php7.2-fpm restart
/etc/init.d/nginx restart
tail -F /var/log/nginx/error.log
exit 0
