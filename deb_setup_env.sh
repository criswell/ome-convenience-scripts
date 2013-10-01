#!/usr/bin/env bash

# Set up a dev environment

cd /root

# Get PERL to stop complaining, also fixes many minor annoyances like ls
# file order
export LC_ALL="C"

# Update and install the base requirements
apt-get -y update
apt-get -y install vim aptitude openjdk-7-jdk python-pip python-scipy python-numpy wget curl unzip git

# Install ICE
wget http://www.zeroc.com/download/RPM-GPG-KEY-zeroc-release
apt-key add RPM-GPG-KEY-zeroc-release

curl -L http://www.zeroc.com/download/Ice/3.5/ubuntu/ice3.5-raring.list -o /etc/apt/sources.list.d/ice3.5-raring.list
aptitude -y update
aptitude -y install ice ice-dev


#apt-get -y install python-zeroc-ice unzip git zeroc-ice libzeroc-ice-dev

#apt-get -y install postgresql-9.1 postgresql-server-dev-9.1

# Random pip installs
pip install numexpr
pip install cython

#apt-get -y install libhdf5-serial-dev
#pip install tables

#pip install PIL

#apt-get -y install libfreetype6-dev libpng-dev libpng++-dev sudo
#pip install matplotlib

#pip install scikits-image

# DB
#sudo -iu postgres createuser -P -D -R -S omero
#sudo -iu postgres createdb -O omero omero
#sudo -iu postgres createlang plpgsql omero
