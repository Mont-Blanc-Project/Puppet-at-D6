class apt {
	file {"/etc/apt/sources.list":
		ensure => file,
		owner => 'root', 
		group => 'root', 
		mode => '644', 
		source => "puppet:///modules/apt/sources.list"
	}
}
