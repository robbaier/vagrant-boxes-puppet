include stdlib
include '::gnupg'

service { 'iptables':
  ensure    => 'stopped',
  hasstatus => 'true',
  status    => 'true',
}

# Extra Packages for Enterprise Linux (EPEL)
package { 'epel-release':
  ensure => installed
}

# Vim
package { 'vim-enhanced':
  ensure => installed
}

# Update packages
#exec { 'update_packages':
#  command => '/usr/bin/yum clean all; /usr/bin/yum update -y',
#  require => Package['epel-release']
#}

# Apache
class { 'apache': }

# MySQL
class { '::mysql::server':
  root_password           => 'password',
  override_options        => {
    'mysqld' => {
      'datadir'             => '/var/lib/mysql',
      'socket'              => '/var/lib/mysql/mysql.sock',
      'user'                => 'mysql',
      'symbolic-links'      => '0',
      'max_allowed_packet'  => '64M',
      'bind-address'        => '0.0.0.0',
      'port'                => '3306'
    },
    'mysqld_safe' => {
      'log-error' => '/var/log/mysqld.log',
      'pid-file'  => '/var/run/mysqld/mysqld.pid'
    }
  },
}

# PHP
class { '::php::globals':
  php_version => '5.6',
}->
class { '::php':
  ensure       => latest,
  manage_repos => true,
  fpm          => false,
  dev          => true,
  composer     => true,
  pear         => true,
  phpunit      => false,
  extensions   => {
    gd         => {},
    mbstring   => {},
    mcrypt     => {},
    mysql      => {},
    xdebug     => {
      provider => 'pecl',
      zend     => true,
      settings => {
        'xdebug.default_enable'       => true,
        'xdebug.remote_enable'        => true,
        'xdebug.remote_autostart'     => false,
        'xdebug.remote_connect_back'  => true,
        'xdebug.remote_handler'       => 'dbgp',
        'xdebug.remote_host'          => '10.0.2.2',
        'xdebug.remote_port'          => 9000,
      }
    }
  },
  settings     => {
    'date.timezone' => 'America/Chicago',
    'max_execution_time'  => '90',
    'max_input_time'      => '300',
    'memory_limit'        => '256M',
    'post_max_size'       => '256M',
    'upload_max_filesize' => '256M',
  },
}

# Phing
# https://www.phing.info/
exec { 'install_phing':
  command => '/usr/bin/pear channel-discover pear.phing.info; /usr/bin/pear install --alldeps phing/phing',
  require => Class['::php']
}

# Subversion
# https://subversion.apache.org/
package { 'subversion':
  ensure => installed,
}

# Git
# https://git-scm.com/
package { 'git-all':
  ensure => installed,
}

# RVM
gnupg_key { 'rvm-key':
  ensure      => 'present',
  key_id      => 'D39DC0E3',
  user        => 'root',
  key_server  => 'hkp://pgp.mit.edu:80',
  key_type    => public,
}

class { '::rvm':
  gnupg_key_id => false,
  require => Gnupg_key['rvm-key']
}
rvm::system_user { vagrant: ; }

# Ruby
rvm_system_ruby {
  'ruby-2.3.1':
    ensure      => 'present',
    default_use => true
}

rvm_gem {

  # Bundler
  # http://bundler.io/
  'ruby-2.3.1/bundler':
    ensure  => latest,
    require => Rvm_system_ruby['ruby-2.3.1'];

  # Sass
  # http://sass-lang.com/
  'ruby-2.3.1/sass':
    ensure  => latest,
    require => Rvm_system_ruby['ruby-2.3.1'];

  # Compass
  # http://compass-style.org/
  'ruby-2.3.1/compass':
    ensure  => latest,
    require => Rvm_system_ruby['ruby-2.3.1'];

  # Jekyll
  # https://jekyllrb.com/
  'ruby-2.3.1/jekyll':
    ensure  => latest,
    require => Rvm_system_ruby['ruby-2.3.1'];

  # Capistrano
  # http://capistranorb.com/
  'ruby-2.3.1/capistrano':
    ensure  => latest,
    require => Rvm_system_ruby['ruby-2.3.1'];

  # Capistrano WP-CLI
  # https://github.com/lavmeiker/capistrano-wpcli
  'ruby-2.3.1/capistrano-wpcli':
    ensure  => latest,
    require => Rvm_system_ruby['ruby-2.3.1'];
}

# NodeJS
class { 'nodejs': }

# Grunt
# http://gruntjs.com/
package { 'grunt-cli':
  ensure   => 'present',
  provider => 'npm',
}

# Gulp
# http://gulpjs.com/
package { 'gulp-cli':
  ensure   => 'present',
  provider => 'npm',
}

# Bower
# https://bower.io/
package { 'bower':
  ensure   => 'present',
  provider => 'npm',
}

# Less
# http://lesscss.org/
package { 'less':
  ensure   => 'present',
  provider => 'npm',
}

# Browser Sync
# https://www.browsersync.io/
package { 'browser-sync':
  ensure   => 'present',
  provider => 'npm',
}

# PhantomJS
# http://phantomjs.org/
# exec { 'install_phantomjs':
#   command => '/usr/bin/npm install -g phantomjs',
#   require => Package['npm']
# }

# SlimerJS
# http://slimerjs.org/
# exec { 'install_slimerjs':
#   command => '/usr/bin/npm install -g slimerjs',
#   require => Package['npm']
# }

# CasperJS
# http://casperjs.org
# exec { 'install_casperjs':
#   command => '/usr/bin/npm install -g casperjs',
#   require => Package['npm']
# }

# Global Bash RC file
#file_line { 'bashrc_login_info':
#  path => '/etc/bashrc',
#  line => 'source /vagrant/build/vagrant/scripts/vagrant-login-default.sh'
#}

# SSH Config
#file_line { 'ssh_config':
#  path  => '/etc/ssh/sshd_config',
#  line  => 'PermitUserEnvironment yes'
#}

#exec { 'restart_ssh':
#  command => '/etc/init.d/sshd restart',
#  require => File_line['ssh_config']
#}
