#!/usr/bin/env bash

# Install everything
sudo apt-get install -qq rubygems
echo "Installing Compass..."

gem install --no-rdoc --no-ri sass compass bootstrap-sass oily_png
gem list
sudo gem list