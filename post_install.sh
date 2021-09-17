cd BookStack && \
echo -ne 'yes' | php artisan key:generate && echo -ne 'yes' | php artisan migrate && \
chown -R www-data:www-data /var/www/html/BookStack/ && \
chmod -R 755 /var/www/html/BookStack/ && \
a2ensite BookStack.conf && \
a2enmod rewrite && \
a2dissite 000-default.conf && \
service apache2 reload 
