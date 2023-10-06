#!/bin/bash

cat /var/www/Docker/supervisor/supervisor.symfony-server >>/etc/supervisor/conf.d/supervisord.conf
cat /var/www/Docker/supervisor/supervisor.webpack-server >>/etc/supervisor/conf.d/supervisord.conf

exec supervisord -n
