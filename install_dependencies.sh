#!/usr/bin/env bash

# Install everything
sudo apt-get install -qq apache2

# Configure Apache
WEBROOT="$(pwd)/htdocs"
echo "WEBROOT: $WEBROOT"
sudo echo "<VirtualHost *:80>
        DocumentRoot $WEBROOT
        <Directory />
                Options FollowSymLinks
                AllowOverride All
        </Directory>
        <Directory $WEBROOT >
                Options Indexes FollowSymLinks MultiViews
                AllowOverride All
                Order allow,deny
                allow from all
        </Directory>
</VirtualHost>" | sudo tee /etc/apache2/sites-available/default > /dev/null
cat /etc/apache2/sites-available/default

# Configure PHP
echo "export PATH=/home/vagrant/.phpenv/bin:$PATH" | sudo tee -a /etc/apache2/envvars > /dev/null
echo "# PHPENV Setup
<IfModule alias_module>
    ScriptAlias /phpenv '/home/vagrant/.phpenv/shims'
    <Directory '/home/vagrant/.phpenv/shims'>
        Order allow,deny
        Allow from all
    </Directory>
</IfModule>

<IfModule mime_module>
    AddType application/x-httpd-php5 .php
</IfModule>

<IfModule dir_module>
    DirectoryIndex index.php index.html
</IfModule>

Action application/x-httpd-php5 '/phpenv/php-cgi'" | sudo tee /etc/apache2/conf.d/phpconfig > /dev/null

sudo a2enmod rewrite
sudo a2enmod actions
sudo service apache2 restart

# Configure custom domain
echo "127.0.0.1 mydomain.local" | sudo tee --append /etc/hosts

echo "TRAVIS_PHP_VERSION: $TRAVIS_PHP_VERSION"