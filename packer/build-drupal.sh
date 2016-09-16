#!/bin/sh

: ${BUILD_VERSION:="v$(date +'%Y%m%d')"}
export BUILD_VERSION

rm -i builds/centos-6.8-drupal.box
packer build centos-6.8-drupal.json
shasum -a 256 builds/centos-6.8-drupal.box
