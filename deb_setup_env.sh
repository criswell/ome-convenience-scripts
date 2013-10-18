#!/usr/bin/env bash

# Set up a dev environment

cd /root

# Get PERL to stop complaining, also fixes many minor annoyances like ls
# file order
export LC_ALL="C"

dpkg-divert --local --rename --add /sbin/initctl
ln -s /bin/true /sbin/initctl

# Update and install the base requirements
apt-get -y update
apt-get -y install vim aptitude openjdk-7-jdk python-pip python-scipy python-numpy wget curl unzip git

# Install ICE
wget http://www.zeroc.com/download/RPM-GPG-KEY-zeroc-release
apt-key add RPM-GPG-KEY-zeroc-release

curl -L http://www.zeroc.com/download/Ice/3.5/ubuntu/ice3.5-raring.list -o /etc/apt/sources.list.d/ice3.5-raring.list
aptitude -y update
aptitude -y install ice ice-dev ant zsh postgresql postgresql-client

# Random pip installs
pip install numexpr
pip install cython

