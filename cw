#!/bin/sh

dir_name=$1
web_name=${2:-$dir_name}

mkdir /var/www/$dir_name

chown www-data:www-data /var/www/$dir_name

echo "<VirtualHost *:80>
    ServerName $web_name

    ServerAdmin webmaster@localhost
    DocumentRoot /var/www/$dir_name

    <Directory /var/www/$dir_name>
        RewriteEngine on
        RewriteCond %{REQUEST_FILENAME} !^favicon\.ico
        RewriteCond %{REQUEST_FILENAME} !-f
        RewriteRule ^.*$ index.php [L,QSA]
    </Directory>

    ErrorLog ${APACHE_LOG_DIR}/error.log
    CustomLog ${APACHE_LOG_DIR}/access.log combined

</VirtualHost>" > /etc/apache2/sites-available/$dir_name.conf

cd /etc/apache2/sites-enabled
ln -s ../sites-available/$dir_name.conf $dir_name.conf

service apache2 restart

# apache php php-mongo php-curl mongodb rewrite-enable php5-mongo 
