class mount_nfs ($ipHome,$ipApps,$clus){
    package { "nfs-common":
        ensure => latest,
    }
    mount { "/home":
		device => "$ipHome:/volume1/homeless",
		fstype => "nfs",
		ensure => "mounted",
		options => "rw,hard,intr,vers=3,nolock,_netdev",
		require => Package['nfs-common'],
    }
	file { "/apps":
		ensure => directory,
    mode   => '755',
    owner  => 'root',
    group  => 'root',
	}
	mount { "/apps":
		device => "$ipApps:/volume1/$clus-apps",
		fstype => "nfs",
		ensure => "mounted",
		options => "rw,hard,intr,vers=3,nolock,_netdev",
		require => Package['nfs-common'],
	}
}
