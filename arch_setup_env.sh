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
    diffutils mcpp php which systemd python python2-virtualenv

ln -s /usr/bin/python2.7 /usr/bin/python

source /etc/profile

curl -L https://aur.archlinux.org/packages/ja/java-berkeleydb/java-berkeleydb.tar.gz -o /root/java-berkeleydb.tar.gz
tar xzvf java-berkeleydb.tar.gz
cd java-berkeleydb
makepkg --sign -s --noconfirm --asroot
pacman -U --noconfirm java-berkeleydb-*.pkg.tar.xz

cd /root

# Install ICE
curl -L https://aur.archlinux.org/packages/ze/zeroc-ice/zeroc-ice.tar.gz -o /root/zeroc-ice.tar.gz
tar xzvf /root/zeroc-ice.tar.gz

cd zeroc-ice
export JAVA_HOME=/usr/lib/jvm/java-7-openjdk/
makepkg --sign -s --noconfirm --asroot
pacman -U --noconfirm *.pkg.tar.xz

pacman -Syu --noconfirm apache-ant postgresql

virtualenv2 --system-site-packages -p /usr/bin/python2.7 /venv

# Final pip-2.7 installs
pip-2.7 install numexpr
pip-2.7 install cython

echo "##########################################"
echo "### Be sure to source /venv/bin/activate"
echo "##########################################"
