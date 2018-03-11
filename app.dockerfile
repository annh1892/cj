FROM php:7.0.4-fpm

RUN apt-get update \
	&& apt-get install -y libmcrypt-dev \
    mysql-client libmagickwand-dev --no-install-recommends \
    && pecl install imagick \
    && docker-php-ext-enable imagick \
    && docker-php-ext-install mcrypt pdo_mysql \
    && curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/bin --filename=composer \
    && apt-get install -y build-essential \
	    vim \
	    unzip \
	    curl \
	    wget \
	    dialog \
	    net-tools \
	    git \
	    supervisor \
	    nginx \
	    php7.0-common \
	    php7.0-dev \
	    php7.0-fpm \
	    php7.0-bcmath \
	    php7.0-curl \
	    php7.0-gd \
	    php7.0-geoip \
	    php7.0-imagick \
	    php7.0-intl \
	    php7.0-json \
	    php7.0-ldap \
	    php7.0-mbstring \
	    php7.0-mcrypt \
	    php7.0-memcache \
	    php7.0-memcached \
	    php7.0-mongo \
	    php7.0-mysqlnd \
	    php7.0-pgsql \
	    php7.0-redis \
	    php7.0-sqlite \
	    php7.0-xml \
	    php7.0-xmlrpc \
	    php7.0-zip \
	    php7.0-xdebug \
	&& apt-get autoclean \
	&& rm -vf /var/lib/apt/lists/*.* /tmp/* /var/tmp/*    