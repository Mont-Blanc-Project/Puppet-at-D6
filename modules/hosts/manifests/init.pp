class hosts {
	file {'/etc/hosts':
		ensure => file,
		owner => 'root',
		group => 'root',
		mode => '644',
		content => template("hosts/hosttemplate.erb")
	}
}
