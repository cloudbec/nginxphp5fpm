FROM nuagebec/ubuntu:14.04
MAINTAINER David Tremblay <david@nuagebec.ca>

#install php5fpm
RUN apt-get update && apt-get upgrade -y && \
    apt-get install -y php5-fpm php5-mysql php5-gd supervisor mysql-client nginx && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

ADD supervisor_php5fpm.conf /etc/supervisor/conf.d/php5fpm.conf 
ADD www.conf /etc/php5/fpm/pool.d/www.conf

RUN ln -sf /dev/stdout /var/log/nginx/access.log && \
    ln -sf /dev/stderr /var/log/nginx/error.log && \
    ln -sf /dev/stderr /var/log/php-fpm.log


RUN mkdir -p /var/www/html && chown www-data:www-data /var/www/html

RUN echo "<?php phpinfo();" > /var/www/html/index.php

EXPOSE 80

CMD ["/data/run.sh"]

