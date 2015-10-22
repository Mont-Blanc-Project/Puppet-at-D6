class lustre {
  file {'/lib/modules/3.11.0-bsc_opencl+/kernel/fs':
    ensure => 'directory',
    owner  => 'root',
    group  => 'root',
    mode   => '644',
  }
  file {'/lib/modules/3.11.0-bsc_opencl+/kernel/fs/lustre':
    ensure  => 'directory',
    recurse => true,
    source  => 'puppet:///modules/lustre/modules',
    owner   => 'root',
    group   => 'root',
    mode    => '644',
    notify  => Exec['depmod']
  }
  exec { 'depmod':
    path        => '/sbin',
    user        => 'root',
    refreshonly => true,
  }
}
