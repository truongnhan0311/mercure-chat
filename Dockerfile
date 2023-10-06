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


ENV NVM_DIR /usr/local/nvm
ENV NODE_VERSION=v18.18.0

RUN apt-get update
RUN apt-get install -y curl apt-transport-https node-typescript git &&\
 curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - &&\
 echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list &&\
 apt-get update &&\
 apt-get -y install --no-install-recommends yarn &&\
 apt-get clean &&\
 apt-get autoremove -y &&\
 rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN rm /bin/sh && ln -s /bin/bash /bin/sh

RUN curl -sL https://raw.githubusercontent.com/creationix/nvm/v0.33.8/install.sh | bash &&\
    source $NVM_DIR/nvm.sh &&\
    nvm install $NODE_VERSION

ENV NODE_PATH $NVM_DIR/v$NODE_VERSION/lib/node_modules
ENV PATH      $NVM_DIR/v$NODE_VERSION/bin:$PATH


RUN source $NVM_DIR/nvm.sh &&  cd /var/www/chat-app && npm install --location=global npm@9.5.0
RUN source $NVM_DIR/nvm.sh && cd /var/www/chat-app && yarn install --location=global && npx browserslist@latest --update-db

EXPOSE 80 8000

CMD ["/run.sh"]
