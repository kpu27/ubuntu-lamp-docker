# Dockerfile  -  https://github.com/kpu27/ubuntu-dockerfile
FROM        ubuntu:bionic
LABEL       MAINTAINER => Telegram : @kpu_27
ENV         DEBIAN_FRONTEND=noninteractive
EXPOSE      80 8080
#             ----- CHANGE MOUNT ROUTE ----- 
VOLUME      ["/home/kpu/Archivos/webserver/web", "/var/www/html"]
WORKDIR     /var/www/html
RUN sed -i.bak 's/main$/main universe/' /etc/apt/sources.list && \
apt-get update && apt-get -y upgrade && apt-get -y install language-pack-en-base && \
export LC_ALL=en_US.UTF-8 && export LANG=en_US.UTF-8 && apt-get -qq -y install \
curl apt-utils gnupg && curl -sL https://deb.nodesource.com/setup_11.x | bash - && \
apt-get -y update && apt-get -qq -y install software-properties-common \
\
                php          git                 \ 
            apache2         unzip                \ 
          net-tools        dh-make               \
         phpmyadmin       php-curl               \
         php-xmlrpc     php-zip                  \ 
        lsb-release    php-pear                  \ 
        php-imagick   php-dev                    \
        php-gettext  php-xml                     \ 
       php-mbstring php-mysql                    \ 
      libmcrypt-dev  php-fpm                     \
      packaging-dev   composer                   \
      apache2-utils    nodejs                    \ 
    ca-certificates     php-gd                   \  
   git-buildpackage      nano                    \
 libapache2-mod-php       vim                    \  
apt-transport-https                           && \
\
composer global require laravel/installer
ENTRYPOINT ["apache2ctl"]
CMD       ["-DFOREGROUND"]
RUN ln -s $HOME/.composer/vendor/bin/laravel /usr/bin/laravel && cd /var/www/html \
&& composer create-project --prefer-dist laravel/laravel proyecto_laravel-angular && \
cd /var/www/html/proyecto_laravel-angular && php artisan preset react && \
npm cache clean --force  && npm install && npm run dev && a2enmod rewrite && \
apt remove -y software-properties-common && apt autoremove -y && \
rm -rf /var/lib/apt/lists/*
