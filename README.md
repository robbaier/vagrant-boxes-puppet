# CentOS 6.8 LAMP Virtual Machines for Vagrant

## About
The goal of these Virtual Machines (VMs) is to provide consistent, reliable development environments while also providing additional development tools.

## What's Included
These VMs include the following:

### LAMP Stack
* CentOS 6.8
* Apache 2.2.15
* MySQL 5.5.51
* PHP 5.6.24

### Package and Dependency Management
* Bower
* Bundler
* Composer
* NPM and Node
* RVM and Ruby

### Build Tools
* Grunt
* Gulp

### Frontend
* Compass
* Jekyll
* Less
* Sass

### Testing Tools
* Browser Sync
* Phing
* XDebug

### Version Control
* Git
* Subversion

# Using these Boxes
You'll need the following in order to run these boxes:

## Vagrant
* These VMs are built for Vagrant
* To begin working with them, you will need to install Vagrant for your local computer before you can do anything else. 
* See https://www.vagrantup.com/

## VirtualBox
In order to run these VMs, you'll need a VM provider for your local computer. These specific VMs are designed to work with VirtualBox from Oracle. You may be able to get them working with other VM providers such as VM Ware or Parallels, but that is outside of the scope of this project.
* VirtualBox Downloads - https://www.virtualbox.org/wiki/Downloads
    
# Building these Boxes
If you want to build these boxes yourself, you'll need the following:
* Ruby
* Packer
* Bundler

## Install Packer
* https://www.packer.io/intro/getting-started/setup.html
* On a Mac with Homebrew installed: $ brew install packer

## Install Bundler
* http://bundler.io/
* $ gem install bundler

## Run Build Script
* ./build-robbaier-centos-6.8-x86-64-wordpress.sh
* ./build-robbaier-centos-6.8-x86-64-drupal.sh
