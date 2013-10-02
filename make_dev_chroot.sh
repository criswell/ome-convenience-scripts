#!/usr/bin/env bash

# Simple utility script to generate dev chroots for openmicroscopy

PROGNAME=${0##*/}
MY_CWD=`pwd`

if [ "$1" = "" ]; then
    echo "USAGE:"
    echo "${PROGNAME} <DEST-DIRECTORY>"
    exit 1
fi

if [ "$(id -u)" != "0" ]; then
    echo "This script must be run as root!"
    exit 1
fi

DEST=$1

debootstrap raring ${DEST}
cp -f sources.list ${DEST}/etc/apt/sources.list
cp -f deb_setup_env.sh ${DEST}/root/.
chmod a+x ${DEST}/root/deb_setup_env.sh

chroot ${DEST} /root/deb_setup_env.sh

echo "Be sure to do something like:"
echo "  export SLICEPATH=/usr/share/Ice-3.5.0/slice"
echo "inside your chroot to be able to build...."
