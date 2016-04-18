node 'lampstack-provision.local' {
  # Configure mysql
  #class { 'mysql::server':
  #  config_hash => { 'root_password' => 'rootmysql' }
  #}
  include mysql::php

  # Configure apache
  include apache
  include apache::mod::php
  apache::vhost { $::fqdn:
    port    => '80',
    docroot => '/var/www/test',
    require => File['/var/www/test'],
  }

  # Configure Docroot and index.html
  file { ['/var/www', '/var/www/test']:
    ensure => directory
  }

  file { '/var/www/test/index.php':
    ensure  => file,
    content => '<?php echo \'<p>Hello World</p>\'; ?> ',
  }

  # Realize the Firewall Rule
  #Firewall <||>
}

