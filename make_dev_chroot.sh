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

error_wrongDistro() {
cat <<EOF

 This script must be run in a one of the following distributions:
    * Debian-derived distribution (such as Ubuntu)
    * Arch Linux

 Your distribution does not appear to be supported.

EOF
}

strap_deb() {
    debootstrap raring ${DEST}
    cp -f ${MY_PATH}/sources.list ${DEST}/etc/apt/sources.list
    cp -f ${MY_PATH}/deb_setup_env.sh ${DEST}/root/setup_env.sh
}

strap_arch() {
    mkdir -p ${DEST}
    pacstrap -d ${DEST} bash python2-pip python2 pacman vim less
    # We assume we want our parent's mirrorlist
    cp -f /etc/pacman.d/mirrorlist ${DEST}/etc/pacman.d/mirrorlist
    cp -f ${MY_PATH}/arch_setup_env.sh ${DEST}/root/setup_env.sh
}

if [ -f "/etc/debian_version" ]; then
    strap_deb
elif [ -f "/etc/arch-release" ]; then
    strap_arch
else
    error_wrongDistro
    exit 1
fi

cp -f ${MY_PATH}/init_env.sh ${DEST}/root/.
chmod a+x ${DEST}/root/setup_env.sh

chroot ${DEST} /root/setup_env.sh

cat <<EOF
>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
>> Chroot setup. Run /root/init_env.sh once in chroot to
>> initialize the development environment
>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
EOF
