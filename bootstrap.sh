#!/bin/bash

OMERO_SERVER="OMERO.server-4.4.8-ice34-b256.zip"
OMERO_DIR="OMERO.server-4.4.8-ice34-b256"

apt-get -y update

apt-get -y install aptitude openjdk-7-jdk python-pip python-scipy python-numpy

apt-get -y install python-zeroc-ice unzip git zeroc-ice libzeroc-ice-dev

apt-get -y install postgresql-9.1 postgresql-server-dev-9.1

pip install numexpr
pip install cython

apt-get -y install libhdf5-serial-dev
pip install tables

pip install PIL

apt-get -y install libfreetype6-dev libpng-dev libpng++-dev
pip install matplotlib

pip install scikits-image

#wget http://cvs.openmicroscopy.org.uk/snapshots/omero/4.4.8/OMERO.clients-4.4.8-ice33-b256.linux.zip

# Note: Does no checking if what we have is correct
if [ ! -f "$OMERO_SERVER" ]; then
    wget http://cvs.openmicroscopy.org.uk/snapshots/omero/4.4.8/${OMERO_SERVER}
fi

if [ ! -d "$OMERO_DIR" ]; then
    unzip $OMERO_SERVER
fi

chown -R vagrant.vagrant $OMERO_DIR

# Create DB
sudo -u postgres createuser -P -D -R -S omero
sudo -u postgres createdb -O omero omero
sudo -u postgres createlang plpgsql omero
cd ${OMERO_DIR}
sudo -u vagrant bin/omero db script
psql -h localhost -U omero omero < OMERO4.4__0.sql

