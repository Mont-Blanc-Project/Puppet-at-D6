class path ($paths){
	$PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games"
	file { '/etc/environment':
		ensure  => file,
        owner   => 'root',
        group   => 'root',
        mode    => '644',
		content => template("path/paths.erb")
    }
}
