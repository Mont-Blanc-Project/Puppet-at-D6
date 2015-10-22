class mount_src_mb {
	file { "/usr/src":
		ensure => directory,
	}
	mount { "/usr/src":
		device => "hca-server:/srv/nfs4/mb-kernel_srcs",
		fstype => "nfs",
		ensure => "mounted",
		options => "rw,hard,intr,vers=3,nolock,_netdev",
		require => [Package['nfs-common'],File['/usr/src']]
	}
}
