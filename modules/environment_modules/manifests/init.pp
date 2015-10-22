class environment_modules {
	package { "tclx8.4-dev":
		ensure => latest,
	}
	package { "tcl-dev":
		ensure => latest,
	}
	file { "/etc/profile.d/modules.sh":
		ensure => file,
		owner => 'root',
		group => 'root',
		mode => '644',
		source => "puppet:///modules/environment_modules/modules.sh",
		require => [Package['tclx8.4-dev'],Package['tcl-dev']],
	} 	
}
