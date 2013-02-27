#!/usr/bin/env bash

# Install everything
sudo apt-get install -qq rubygems
echo "Installing Compass..."
sudo gem install --no-rdoc --no-ri sass compass bootstrap-sass
