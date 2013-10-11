#!/usr/bin/env bash

cd /root

# Get PERL to stop complaining, also fixes many minor annoyances like ls
# file order
export LC_ALL="C"

# Key skullduggery
rm -fr /etc/pacman.d/gnupg/
pacman-key --init
pacman-key --populate archlinux
pacman-key --refresh-keys

# Now the packages
pacman -Syu --noconfirm jdk7-openjdk python2-scipy python2-numpy wget \
    curl unzip git gcc tar gzip grep automake make glib2 file patch \
    diffutils mcpp php python

source /etc/profile

curl -L https://aur.archlinux.org/packages/ja/java-berkeleydb/java-berkeleydb.tar.gz -o /root/java-berkeleydb.tar.gz
tar xzvf java-berkeleydb.tar.gz
cd java-berkeleydb
makepkg --sign -s --noconfirm --asroot
pacman -U --noconfirm java-berkeleydb-*.pkg.tar.xz

# Install ICE
curl -L https://aur.archlinux.org/packages/ze/zeroc-ice/zeroc-ice.tar.gz -o /root/zeroc-ice.tar.gz
tar xzvf zeroc-ice.tar.gz
cd zeroc-ice
export JAVA_HOME=/usr/lib/jvm/java-7-openjdk/
makepkg --sign -s --noconfirm --asroot
pacman -U --noconfirm *.pkg.tar.xz

pacman -Syu --noconfirm apache-ant postgresql

# Final pip installs
pip install numexpr
pip install cython