#!/bin/sh

: ${BUILD_VERSION:="v$(date +'%Y%m%d')"}
export BUILD_VERSION

rm -i builds/robbaier-centos-6.8-drupal.box
packer build robbaier-centos-6.8-drupal.json
shasum -a 256 builds/robbaier-centos-6.8-drupal.box
