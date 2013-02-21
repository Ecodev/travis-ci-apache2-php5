#!/usr/bin/env bash

# Install everything
sudo apt-get install -qq libapache2-mod-php5

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
sudo a2enmod rewrite
sudo service apache2 restart

curl http://localhost/
