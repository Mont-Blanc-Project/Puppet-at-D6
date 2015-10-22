class ldconfig_mb {
  file {'/etc/ld.so.conf.d':
    ensure => 'directory',
    recurse => true,
    source => 'puppet:///modules/ldconfig_mb/conf',
    owner => 'root',
    group => 'root',
    mode => '644',
    notify => Exec['ldconfig']
  }
	exec { 'ldconfig':
		path => '/sbin',
		user => 'root',
		refreshonly => true,
	}
}
