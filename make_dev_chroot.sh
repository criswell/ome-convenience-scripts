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

debootstrap testing ${DEST}