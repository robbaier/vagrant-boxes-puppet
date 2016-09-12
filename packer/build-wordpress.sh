#!/bin/sh

: ${BUILD_VERSION:="v$(date +'%Y%m%d')"}
export BUILD_VERSION

rm -i builds/*-${BUILD_VERSION}-wordpress.box
packer build CentOS-6.8-wordpress.json
shasum -a 256 builds/*-${BUILD_VERSION}-wordpress.box
