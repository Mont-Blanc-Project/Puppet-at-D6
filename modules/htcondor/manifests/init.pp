class htcondor {
	package { "htcondor":
		ensure => latest,
	}
	file { '/etc/condor/condor_config':
		ensure  => file,
		source => 'puppet:///modules/htcondor/condor_config',
		require => [Package['htcondor']],
	}
}
