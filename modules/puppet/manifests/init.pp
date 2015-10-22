class puppet {
 	package { "puppet":
    ensure => latest,
 	}
	group { "puppet":
		ensure  => present,
		require => Package['puppet'],
	}
	user { "puppet":
		ensure => present,
		gid => 'puppet',
		shell => '/bin/false',
		home => '/var/lib/puppet',
		require => Group['puppet'],
	}
	file { '/etc/puppet/puppet.conf':
		ensure => present,
		source => "puppet:///modules/puppet/puppet.conf",
		owner => 'puppet',
		group => 'puppet',
		mode => '644',
		require => User['puppet'],
	}
	service { "puppet":
		ensure     => stopped,
		enable     => false,
	}
	cron { "puppetrun":
		ensure => present,
		command => '/usr/bin/puppet agent --no-daemonize --onetime',
		user => 'root',
		hour => "*",
		minute =>"0",
	}
}
