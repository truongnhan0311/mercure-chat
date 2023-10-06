#!/bin/bash

cat /var/www/Docker/supervisor.symfony-server >>/etc/supervisor/conf.d/supervisord.conf

exec supervisord -n
