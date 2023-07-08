#!/bin/sh

SUITE=$1

usage() {
    echo 'Usage: ./create-manifest.sh <suite>'
    echo 'Example: ./create-manifest.sh 4'
    exit 1
}

if [ $# -ne 1 ]; then
    usage
fi

IMAGE_NAME="ppodds/debian:$SUITE"

# Create manifest
echo 'Create manifest...'
docker manifest create $IMAGE_NAME $IMAGE_NAME-amd64 $IMAGE_NAME-i386
# Push manifest
echo 'Push manifest...'
docker manifest push $IMAGE_NAME
