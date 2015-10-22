class ldconfig_octo {
	file { '/etc/ld.so.conf.d/slurm.conf':
		ensure => file,
		source => 'puppet:///modules/ldconfig_octo/slurm.conf',
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
