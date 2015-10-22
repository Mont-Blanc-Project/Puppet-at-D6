class nfs($server,$mounts){
	include stdlib
	define mountNFS($server){
		$remote = $mountPoints[$title]
                mount{$title:
			device  => "${server}:${remote}",
			fstype  => 'nfs',
			ensure  => mounted,
			options => 'rw,hard,intr,vers=3,nolock,_netdev',
			require => Package['nfs-common'],
                }
                file{$title:
                        ensure => directory,
                        mode   => '755',
                }		
	}
	package {"nfs-common":
                ensure => installed,
        }
        mountNFS{$mounts:
                server      => $server,
        }
}
