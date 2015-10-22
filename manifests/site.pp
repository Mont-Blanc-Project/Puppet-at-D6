class basenode($clus_name ){
	include basic_packages
	class { 'locales':
        default_locale  => 'en_US.UTF-8',
        locales         => ['en_US.UTF-8 UTF-8', 'es_ES.UTF-8 UTF-8'],
    }
	include compilation_tools
	include hosts
	class { 'mount_nfs':
		ipHome => "nas-1", 	
		ipApps => "nas-1", 	
		clus	=> $clus_name,
	}
	include ldap
	include puppet
	include ssh
	include sudo
  sudo::conf {'uriviba':
    priority => 10,
    content  => 'uriviba ALL=(ALL) NOPASSWD: ALL',
  }
  sudo::conf {'druiz':
    priority => 10,
    content  => 'druiz ALL=(ALL) NOPASSWD: ALL',
  }
  sudo::conf {'fmantovani':
    priority => 10,
    content  => 'fmantovani ALL=(ALL) NOPASSWD: ALL',
  }
  sudo::conf {'benchmark':
    priority => 20,
    content  => '%benchmark ALL=NOPASSWD: /usr/bin/cpufreq-set, /usr/sbin/memtester',
  }
  class {'pam_slurm':
    clus => $clus_name,
  }
	include ntp
	include munge
	class { 'slurm':
		clus	=> $clus_name,
	}
	Class['munge'] -> Class['slurm'] 
	Class['mount_nfs'] -> Class['slurm'] 
  package {"mercurial": 
    ensure => latest,
  }
}

class junoNode {
	class { 'basenode':
		clus_name => "juno",
	}
}
node 'juno-1.alps' {
	include junoNode
	include allow_access
}
node 'juno-2.alps' {
	include junoNode
  class { 'allow_access':
    users => []
  }
}

class jetsonNode{
	class { 'basenode':
		clus_name => "jetson",
	}
	include cuda
	class { 'path':
		paths => ['/usr/local/cuda/bin','/usr/local/java/jdk/bin', '/apps/slurm/2.6.5/bin', '/apps/slurm/2.6.5/sbin'],
	}
	include ldconfig_jetson
  class { 'ganglia':
    clustername => "jetson",
  }
  include environment_modules
  package {"libunwind8-dev":
    ensure => latest
  }
  package {"mmv":
    ensure => latest
  }
}





class octodroidNode{
	class { 'basenode':
		clus_name => "octodroid",	
	}
	include ldconfig_octo
  class { 'ganglia':
    clustername => "octodroid",
  }
  include environment_modules
  include htcondor
}





class mbNode{
	class { 'basenode':
		clus_name => "mb",	
	}
  include mali
  include modulees
  include random_packages
  include ldconfig_mb
  include fpusher
  #  include apt
  class { 'python':
    version => '3.4',
  }
	class { 'path':
		paths => ['/apps/slurm/2.6.5/bin', '/apps/slurm/2.6.5/sbin'],
	}
  include mount_src_mb
  include lustre
  python::pip { "six" :
    ensure => latest,
  }
  file { '/usr/lib/python2.7/dist-packages/six.py':
    ensure => absent,
  }
  file { '/usr/lib/python2.7/dist-packages/six.pyc':
    ensure => absent,
  }
  python::pip { "mako" :
    ensure => latest,
  }
  python::pip { "mpi4py" :
    ensure      => latest,
    environment => 'MPICC=/apps/openmpi/1.8.3/bin/mpicc',
  }
  python::pip { "mpmath" :
    ensure => latest,
  }
  python::pip { "numpy" :
    ensure => latest,
  }
  python::pip { "pytools" :
    ensure => latest,
  }
  python::pip { "scotch" :
    ensure => latest,
  }
  package {"mmv":
    ensure => latest
  }
  package {"libnetcdf-dev":
    ensure => latest
  }
  package {"libsparskit-dev":
    ensure => latest
  }
  package {"libetsf-io-dev":
    ensure => latest
  }
  package {"libxc1":
    ensure => latest
  }
  package {"valgrind":
    ensure => latest
  }
  sudo::conf {'patc':
    priority => 20,
    content  => '%patc ALL=NOPASSWD: /usr/bin/cpufreq-set',
  }

}


class give_node($user){
  class {'allow_access':
    users => [$user]
  }
  sudo::conf {"$user":
    priority => 20,
    content  => "$user ALL=(ALL) NOPASSWD: ALL"
  }

}



#----JETSON----
node 'jetson-1.alps' {
	include jetsonNode
	include allow_access
  sudo::conf {'jcebrian':
    priority => 10,
    content  => 'jcebrian ALL=(ALL) NOPASSWD: ALL',
  }

}
node /^jetson-[2-8]\.alps$/ {
	include jetsonNode
  class { 'allow_access':
    users => []
  }
}

#----OCTODROID----
node 'octodroid-1.alps' {
	include octodroidNode
	include allow_access
  sudo::conf {'kchronaki':
    priority    => 20,
    content => 'kchronaki ALL=NOPASSWD: /usr/bin/cpufreq-set',
  }
}
node /^octodroid-[2-3]\.alps$/ {
	include octodroidNode
  class { 'allow_access':
    users => []
  }
}
node /^octodroid-[4-6]\.alps$/ {
	include octodroidNode
	include allow_access
	sudo::conf {'kchronaki':
		priority	=> 20,
		content => 'kchronaki ALL=NOPASSWD: /usr/bin/cpufreq-set',
	}
}
node /^octodroid-[7-9]\.alps$/ {
	include octodroidNode
  class { 'allow_access':
    users => []
  }
}
node 'octodroid-10.alps' {
	include octodroidNode
  class { 'allow_access':
    users => []
  }
}
node 'octodroid-11.alps' {
	include octodroidNode
  class { 'allow_access':
    users => []
  }
}
node 'octodroid-12.alps' {
	include octodroidNode
  class { 'allow_access':
    users => []
  }
}
node 'octodroid-13.alps' {
	include octodroidNode
  class { 'allow_access':
    users => []
  }
}
#----Mont-Blanc----
# Login nodes
node 'mb-1101.alps' {
	include mbNode
	include allow_access
}
node 'mb-1104.alps' {
  include mbNode
  class { 'give_node':
		user => "vmehta"
	}
}
node 'mb-1105.alps' {
  include mbNode
  class { 'give_node':
		user => "vmehta"
	}
}
node 'mb-1106.alps' {
  include mbNode
  class { 'give_node':
		user => "vmehta"
	}
}
node 'mb-1107.alps' {
  include mbNode
  class { 'give_node':
		user => "vmehta"
	}
}
node 'mb-1108.alps' {
  include mbNode
  class { 'give_node':
		user => "vmehta"
	}
}
node 'mb-1109.alps' {
  include mbNode
  class { 'give_node':
		user => "vmehta"
	}
}
node 'mb-1110.alps' {
  include mbNode
  class { 'give_node':
		user => "vmehta"
	}
}
# Compute nodes
node /^mb-(([1-8][1-9](0[2-9]|1[0-5]))|[1-8][2-9]01)\.alps$/ {
	include mbNode
  class { 'allow_access':
    users => []
  }
}

$server = "nas-1.alps"
node /^mb-([1-9]|[1-9]\d|1[0-2]\d|13[0-5])\.alps$/ {
        class {"ntp":
          servers => ['hca.alps'],
        }
        package {"nfs-common":
          ensure => installed,
        }
        mount{"/apps":
          device  => "${server}:/volume1/mb-apps",
          fstype  => 'nfs',
          ensure  => mounted,
          options => 'rw,hard,intr,vers=3,nolock,_netdev',
          require => Package['nfs-common'],
        }
        mount{"/home":
          device  => "${server}:/volume1/homeless",
          fstype  => 'nfs',
          ensure  => mounted,
          options => 'rw,hard,intr,vers=3,nolock,_netdev',
          require => Package['nfs-common'],
        }
        include sudo
        include users
        include ldap
        sudo::conf {'uriviba':
                priority    => 10,
                content => 'uriviba ALL=(ALL) NOPASSWD: ALL',
        }
        sudo::conf {'druiz':
                priority    => 10,
                content => 'druiz ALL=(ALL) NOPASSWD: ALL',
        }
        class { 'locales':
                default_locale => 'en_US.UTF-8',
                locales        => ['en_US.UTF-8 UTF-8', 'es_ES.UTF-8 UTF-8'],
        }
        include basic_packages
        include mali
        include ldconfig_mb
        include munge
        class { 'slurm':
          clus => "mb",
        }
        Class['munge'] -> Class['slurm']
}

