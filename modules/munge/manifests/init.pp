class munge {
	package { "openssl":
		ensure => latest,
	}
	package { "libssl-dev":
		ensure => latest,
	}
	package { "munge":
		ensure  => present,
		require => [Package["openssl"],Package["libssl-dev"]]
	}
	group {"munge":
		ensure => 'present',
		system => true,
	}
	user {"munge":
		ensure => 'present',
		system => true,
		gid    => "munge",
		require => Group['munge'],
	}
	file {"munge_key":
		path    => '/etc/munge/munge.key',
		ensure  => file,
		owner   => 'munge',
		require => [User['munge'],Package['munge']],
		group   => 'munge',
		mode    => '400',
		source  => "puppet:///modules/munge/munge.key",
		notify  => Service['munge']
	}
	file {"munge_force":
		path	=> "/etc/default/munge",
		ensure	=> file,
		owner	=> 'root',
		group	=> 'root',
		mode	=> '644',
		require	=> [Package['munge'],User['munge']],
		content => 'OPTIONS="--force"',
		notify  => Service['munge']
	}
	service { "munge":
		ensure => running,
		enable => true,
		hasstatus => true,
		hasrestart => true,
		require => [Package['munge'],User['munge'],File['munge_key'],File['munge_force']]
	}
}
