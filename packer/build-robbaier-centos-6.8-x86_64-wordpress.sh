#!/bin/sh

: ${BUILD_VERSION:="v$(date +'%Y%m%d')"}
export BUILD_VERSION

rm -i builds/robbaier-centos-6.8-x86_64-wordpress.box
packer build build-robbaier-centos-6.8-x86_64-wordpress.json
shasum -a 256 builds/robbaier-centos-6.8-x86_64-wordpress.box
