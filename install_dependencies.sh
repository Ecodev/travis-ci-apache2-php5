#!/usr/bin/env bash

sudo apt-get install -qq libapache2-mod-php5
sudo a2enmod rewrite

echo "TRAVIS_BUILD_DIR: $TRAVIS_BUILD_DIR"

sudo echo "<VirtualHost *:80>
        DocumentRoot $TRAVIS_BUILD_DIR/htdocs
        <Directory />
                Options FollowSymLinks
                AllowOverride All
        </Directory>
        <Directory $TRAVIS_BUILD_DIR/htdocs >
                Options Indexes FollowSymLinks MultiViews
                AllowOverride All
                Order allow,deny
                allow from all
        </Directory>
</VirtualHost>" > /etc/apache2/sites-available/default
more /etc/apache2/sites-available/default

sudo service apache2 restart

curl http://localhost/
