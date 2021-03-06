# Dockerfile  -  https://github.com/kpu27/ubuntu-dockerfile
FROM        ubuntu:bionic
LABEL       MAINTAINER => Telegram : @kpu_27
ENV         DEBIAN_FRONTEND=noninteractive
EXPOSE      80 8080 5000
WORKDIR     /var/www/html
RUN sed -i.bak 's/main$/main universe/' /etc/apt/sources.list && \
apt-get update && apt-get -y upgrade && apt-get -y install language-pack-en-base && \
export LC_ALL=en_US.UTF-8 && export LANG=en_US.UTF-8 && apt-get -qq -y install \
curl apt-utils gnupg && curl -sL https://deb.nodesource.com/setup_11.x | bash - && \
apt-get -y update && apt-get -qq -y install software-properties-common \
\
                php             git              \ 
               sudo            wget              \
              gnupg           unzip              \
             daemon          psmisc              \
            apache2         procps               \ 
          net-tools        dh-make               \
         phpmyadmin       php-curl               \
         php-xmlrpc     php-zip                  \ 
        lsb-release    php-pear                  \ 
        php-imagick   php-dev                    \
        php-gettext  php-xml                     \ 
       php-mbstring nano vim                     \ 
      libmcrypt-dev  php-mysql                   \
      openjdk-8-jdk   php-fpm                    \
      packaging-dev    nodejs                    \
      apache2-utils     php-gd                   \
    ca-certificates      gnupg1                  \ 
   git-buildpackage       gnupg2                 \
 libapache2-mod-php        maven                 \  
apt-transport-https         composer             \ 
\
&& \
composer global require laravel/installer && \
npm i @angular/cli \
ENTRYPOINT ["apache2ctl"]
CMD       ["-DFOREGROUND"]
RUN ln -s $HOME/.composer/vendor/bin/laravel /usr/bin/laravel && cd /var/www/html \
&& composer create-project --prefer-dist laravel/laravel proyecto_laravel-angular && \
cd /var/www/html/proyecto_laravel-angular && php artisan preset react && \
npm cache clean --force  && npm install && npm run dev && a2enmod rewrite && \
apt remove -y software-properties-common && apt autoremove -y && \
rm -rf /var/lib/apt/lists/*

