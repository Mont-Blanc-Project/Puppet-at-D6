class ganglia ($clustername){
  package { 'ganglia-monitor':
    ensure => present,
  }
  file {'/etc/ganglia/gmond.conf':
    ensure  => file,
    owner   => 'root',
    group   => 'root',
    mode    => '644',
    content  => template("ganglia/gmond.erb"),
    require => Package['ganglia-monitor'],
    notify  => Service['ganglia-monitor']
  }
  service { 'ganglia-monitor':
    ensure     => stopped,
    enable     => true,
    hasstatus  => true,
    hasrestart => true,
    require    => File['/etc/ganglia/gmond.conf']
  }
}
