#!/bin/sh

SUITE=$1
ARCH=$2
VERSION=$3

usage() {
    echo 'Usage: sudo ./create-rootfs.sh <suite> <arch> <version>'
    echo 'Example: sudo ./create-rootfs.sh etch amd64 20100619T041712Z'
    echo 'You can find available version at https://snapshot.debian.org/archive/debian/'
    exit 1
}

if [ $# -ne 3 ]; then
    usage
fi

DIR="$SUITE/$VERSION"
ROOTFS_DIR="$DIR/rootfs"

# Clean folder if already existed
if [ -d $ROOTFS_DIR ]; then 
    echo 'Old files detected, remove old files.'
    rm -rf $ROOTFS_DIR
fi

mkdir -p $ROOTFS_DIR

# Create root fs
debootstrap --arch=$ARCH $SUITE $ROOTFS_DIR "https://snapshot.debian.org/archive/debian/${VERSION}/" 
if [ $? -ne 0 ]; then
    echo 'debootstrap failed!'
    exit 1
fi

# Create tarball
tar cpzf "$DIR/rootfs.tar.gz" $ROOTFS_DIR

