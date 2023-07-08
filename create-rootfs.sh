#!/bin/sh

SUITE=$1
ARCH=$2

usage() {
    echo 'Usage: ./create-rootfs.sh <suite> <arch>'
    echo 'Example: ./create-rootfs.sh etch amd64'
    echo 'You can find available version at https://archive.kernel.org/debian-archive/debian/'
    exit 1
}

if [ $# -ne 2 ]; then
    usage
fi

DIR="$SUITE"
ROOTFS_DIR="$DIR/rootfs"

# Clean folder if already existed
if [ -d $ROOTFS_DIR ]; then 
    echo 'Old files detected, remove old files.'
    sudo rm -rf $ROOTFS_DIR
    sudo rm -f $DIR/rootfs.tar.gz
fi

mkdir -p $ROOTFS_DIR

# Create root fs
sudo debootstrap --arch=$ARCH $SUITE $ROOTFS_DIR "http://archive.kernel.org/debian-archive/debian/" 
if [ $? -ne 0 ]; then
    echo 'debootstrap failed!'
    exit 1
fi

# Create tarball
echo 'Create tarball...'
cd $ROOTFS_DIR
sudo tar cpzf ../rootfs.tar.gz .
sudo chown $USER:$USER ../rootfs.tar.gz
cd $PWD
echo 'Done!'
