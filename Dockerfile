FROM	debian:buster

RUN		apt update && \
		apt-get install \
		apache2 \
		php7.3 \
		libapache2-mod-php7.3 \
		php7.3-common \
		php7.3-sqlite3 \
		php7.3-curl \
		php7.3-intl \
		php7.3-mbstring \
		php7.3-xmlrpc \
		php7.3-mysql \
		php7.3-gd \
		php7.3-xml \
		php7.3-cli \
		php7.3-tidy \
		php7.3-zip \
		unzip \
		wget \
		git -y

RUN 	php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" && \
		php composer-setup.php && \
		php -r "unlink('composer-setup.php');" && \
		mv composer.phar /usr/local/bin/composer

WORKDIR	/var/www/html
RUN 	git clone https://github.com/BookStackApp/BookStack.git --branch release --single-branch && cd BookStack && composer install

COPY  	.env /var/www/html/BookStack/.env
COPY  	BookStack.conf /etc/apache2/sites-available/BookStack.conf
  
#RUN 	cd BookStack && \
#		echo -ne 'yes' | php artisan key:generate && echo -ne 'yes' | php artisan migrate && \
#		chown -R www-data:www-data /var/www/html/BookStack/ && \
#		chmod -R 755 /var/www/html/BookStack/ && \
#		a2ensite BookStack.conf && \
#		a2enmod rewrite && \
#		a2dissite 000-default.conf && \
#		service apache2 reload 
    
EXPOSE 	80	

