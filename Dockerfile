FROM wordpress:latest

RUN touch /usr/local/etc/php/conf.d/upload-limit.ini \
 && echo "upload_max_filesize = 32M" >> /usr/local/etc/php/conf.d/upload-limit.ini \
 && echo "post_max_size = 32M" >> /usr/local/etc/php/conf.d/upload-limit.ini
#Paste above this line.
RUN a2enmod rewrite expires headers

# install the PHP extensions we need
RUN apt-get update && apt-get install -y unzip libpng12-dev libjpeg-dev && rm -rf /var/lib/apt/lists/* \
        && docker-php-ext-configure gd --with-png-dir=/usr --with-jpeg-dir=/usr \
        && docker-php-ext-install gd mysqli opcacheFROM wordpress:latest

VOLUME /var/www/html

COPY docker-entrypoint.sh /entrypoint.sh

# grr, ENTRYPOINT resets CMD now
ENTRYPOINT ["/entrypoint.sh"]
CMD ["apache2-foreground"]
