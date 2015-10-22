class ldconfig_jetson {
	file { '/etc/ld.so.conf.d/slurm.conf':
		ensure => file,
		source => 'puppet:///modules/ldconfig_jetson/slurm.conf',
		owner => 'root',
		group => 'root',
		mode => '644',
		notify => Exec['ldconfig']
	}
	file { '/etc/ld.so.conf.d/mpich2.conf':
		ensure => file,
		source => 'puppet:///modules/ldconfig_jetson/mpich2.conf',
		owner => 'root',
		group => 'root',
		mode => '644',
		notify => Exec['ldconfig']
	}
	file { '/etc/ld.so.conf.d/cuda.conf':
        ensure => file,
        owner => 'root',
        group => 'root',
        mode => '644',
		content => "/usr/local/cuda-6.0/targets/armv7-linux-gnueabihf/lib\n",
        notify => Exec['ldconfig']
    }
	exec { 'ldconfig':
		path => '/sbin',
		user => 'root',
		refreshonly => true,
	}
}
