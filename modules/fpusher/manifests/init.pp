class fpusher {
  file { "/etc/init.d/filepusher":
    ensure => file,
    source => 'puppet:///modules/fpusher/filepusher.sh',
    owner  => 'root',
    group  => 'root',
    mode   => '755',
    notify => Service['filepusher']
  }
  service { "filepusher":
    ensure     => running,
    enable     => true,
    hasrestart => true,
	  require => File["/etc/init.d/filepusher"],
  }
}
