#!/bin/sh

SUITE=$1
ARCH=$2
OVERRIDE_DIR=$3

usage() {
    echo 'Usage: ./publish-image.sh <suite> <arch> [override_dir]'
    echo 'Example: ./publish-image.sh etch amd64'
    echo '         ./publish-image.sh 4 amd64 etch'
    exit 1
}

if [ $# -ne 2 ] && [ $# -ne 3 ]; then
    usage
fi

if [ $OVERRIDE_DIR ]; then
    if [ ! -d $OVERRIDE_DIR ]; then
        echo 'Override directory not found!'
        exit 1
    fi
    DIR="$OVERRIDE_DIR"
else
    DIR="$SUITE"
fi

# Enter image directory
cd $DIR

IMAGE_NAME="ppodds/debian:$SUITE-$ARCH"

# Create image
docker build -t $IMAGE_NAME --platform $ARCH .
# Push image
docker push $IMAGE_NAME
