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
pacman -Syu --noconfirm jdk7-openjdk python2-scipy python2-numpy wget curl unzip git

curl -L https://aur.archlinux.org/packages/ze/zeroc-ice/PKGBUILD -o /root/zeroc-ice.PKGBUILD

