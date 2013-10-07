#!/usr/bin/env bash

# Simple utility script to generate dev chroots for openmicroscopy

PROGNAME=${0##*/}
MY_CWD=`pwd`

MY_PATH="`dirname \"$0\"`"

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
cp -f ${MY_PATH}/sources.list ${DEST}/etc/apt/sources.list
cp -f ${MY_PATH}/deb_setup_env.sh ${DEST}/root/.
cp -f ${MY_PATH}/init_env.sh ${DEST}/root/.
chmod a+x ${DEST}/root/deb_setup_env.sh

chroot ${DEST} /root/deb_setup_env.sh

echo ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"
echo ">> Chroot setup. Run /root/init_env.sh once in chroot to"
echo ">> initialize the development environment"
echo ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"