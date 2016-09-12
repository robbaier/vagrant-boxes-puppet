# CentOS 6.8 LAMP Virtual Machines

## About
The goal of these Virtual Machines (VMs) is to provide consistent, reliable development environments while also providing additional development tools.

## Features
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

# Prerequisites

## Vagrant
* These VMs are built for Vagrant
* To begin working with them, you will need to install Vagrant for your local computer before you can do anything else. 
* See https://www.vagrantup.com/

## VirtualBox
In order to run these VMs, you'll need a VM provider for your local computer. These specific VMs are designed to work with VirtualBox from Oracle. You may be able to get them working with other VM providers such as VM Ware or Parallels, but that is outside of the scope of this project.

* VirtualBox Downloads - https://www.virtualbox.org/wiki/Downloads

## Vagrant Plugins
This project leverages a few Vagrant plugins to make certain tasks easier. You'll need to install these to work with these VMs in Vagrant:

### Vagrant Hostupdater
* This plugin is used to update the hosts file on both your local machine and inside the VM to make sure custom domain names work properly
* https://github.com/cogitatio/vagrant-hostsupdater
* To install, run: vagrant plugin install vagrant-hostsupdater'
    
### Vagrant Librarian Puppet
* This plugin is used to manage module dependencies for Puppet
* https://github.com/voxpupuli/vagrant-librarian-puppet
* To install, run: vagrant plugin install vagrant-librarian-puppet
    
### Vagrant VBGuest (optional, but recommended)
* This plugin checks the versions of Guest Additions running both within your local VirtualBox installation and within the VM and updates the version within the VM to match.
* This helps eliminate problems with differing versions of VirtualBox Guest Additions.
* https://github.com/dotless-de/vagrant-vbguest
* To install, run: vagrant plugin install vagrant-vbguest
    
# Puppet Modules
The following Puppet modules are used to build this VM:

* puppetlabs-apache - https://github.com/puppetlabs/puppetlabs-apache
* puppetlabs-mysql - https://github.com/puppetlabs/puppetlabs-mysql
* mayflower-php - https://github.com/mayflower/puppet-php

# Ruby
The default system Ruby on CentOS is 1.8.7, which is very old. This version of Ruby is no longer supported by many gems. For this VM, this version of Ruby is still in place as the system Ruby to prevent things from breaking.

In order to work with current gems such as Sass, Compass and Jekyll, a newer version of Ruby has been installed using RVM and set as the default Ruby. This means the commands for Sass, Compass and Jekyll will work without any extra steps. However, this also means anything requiring the system Ruby will require running this command first:

    rvm use system
    
To go back to the newer version of Ruby, use this command, replacing the version number as appropriate:

    rvm use 2.3.1




# Prerequisites
* Ruby
* Packer
* Bundler

# Install Packer
* https://www.packer.io/intro/getting-started/setup.html
* On a Mac with Homebrew installed: $ brew install packer

# Install Bundler
* http://bundler.io/
* $ gem install bundler

# Download Puppet Modules
* cd puppet
* bundle install
* bundle exec librarian-puppet install

# Run Build Script
* ./build-wordpress.sh
* ./build-drupal.sh
