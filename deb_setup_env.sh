#!/usr/bin/env bash

# Set up a dev environment

apt-get -y update

apt-get -y install aptitude openjdk-7-jdk python-pip python-scipy python-numpy

apt-get -y install python-zeroc-ice unzip git zeroc-ice libzeroc-ice-dev icee-translators

apt-get -y install postgresql-9.1 postgresql-server-dev-9.1

pip install numexpr
pip install cython

apt-get -y install libhdf5-serial-dev
pip install tables

pip install PIL

apt-get -y install libfreetype6-dev libpng-dev libpng++-dev sudo
pip install matplotlib

pip install scikits-image

# DB
sudo -iu postgres createuser -P -D -R -S omero
sudo -iu postgres createdb -O omero omero
sudo -iu postgres createlang plpgsql omero
