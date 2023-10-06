FROM  truongnhan0311/debian:bullseye-php8.2-nginx-symfony5-base
MAINTAINER Nhan.Nguyen. <truongnhan0311@gmail.com>

ADD . /var/www
RUN chown -R www-data:www-data /var/www && chmod 750 /var/www

ADD Docker/run.sh /run.sh
ADD Docker/composer.phar /usr/local/bin/composer
RUN chmod 755 /*.sh

RUN cd /var/www/chat-app && composer install --no-dev &&\
    php /usr/local/bin/composer clearcache &&\
    find /var/www/chat-app/vendor -name ".git" -exec rm -rf {} \; || true

EXPOSE 80 8000

CMD ["/run.sh"]
