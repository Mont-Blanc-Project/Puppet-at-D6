class give_node($user){
  class {'allow_access':
    users => [$user]
  }
  sudo::conf {"$user":
    priority => 20,
    content  => "$user ALL=(ALL) NOPASSWD: ALL"
  }
}

class basenode($clus_name ){
  include basic_packages
  class { 'locales':
    default_locale  => 'en_US.UTF-8',
    locales         => ['en_US.UTF-8 UTF-8', 'es_ES.UTF-8 UTF-8'],
  }
  include compilation_tools
  class { 'mount_nfs':
    ipHome => "nas-1", 	
    ipApps => "nas-1", 	
    clus   => $clus_name,
  }
  include ldap
  include puppet
  include ssh
  include sudo
  include admin_users
  class {'pam_slurm':
    clus => $clus_name,
  }
  class {'ntp':
    servers => [ '192.168.0.1' ],
  }
  include munge
  class { 'slurm':
    clus => $clus_name,
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
node /^octodroid-[4-6]\.alps$/ {
  include octodroidNode
  include allow_access
  sudo::conf {'kchronaki':
    priority => 20,
    content  => 'kchronaki ALL=NOPASSWD: /usr/bin/cpufreq-set',
  }
}
node /^octodroid-[2-3]\.alps$/ {
  include octodroidNode
  class { 'allow_access':
    users => []
  }
}
node /^octodroid-[7-9]\.alps$/ {
  include octodroidNode
  class { 'allow_access':
    users => []
  }
}
node /^octodroid-1[0-3]\.alps$/ {
  include octodroidNode
  class { 'allow_access':
    users => []
  }
}

#--MB-NODES--
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

