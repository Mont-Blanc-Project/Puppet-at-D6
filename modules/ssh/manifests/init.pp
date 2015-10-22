class ssh {
  package { "openssh-server":
    ensure => latest,
  }
  file { "/etc/ssh/sshd_config" :
	  source  => "puppet:///modules/ssh/sshd_config",
	  owner   => "root",
		group   => "root",
		mode    => "640",
		notify  => Service['ssh'],
		require => Package["openssh-server"],
  }
  file { "/etc/pam.d/sshd" :
	  source  => "puppet:///modules/ssh/sshd",
	  owner   => "root",
		group   => "root",
		mode    => "644",
		notify  => Service['ssh'],
		require => Package["openssh-server"],
  }
  file { "/etc/ssh/ssh_config" :
    source  => "puppet:///modules/ssh/ssh_config",
    owner   => "root",
    group   => "root",
    mode    => "640",
    notify  => Service['ssh'],
    require => Package["openssh-server"],
  }
  service { "ssh":
    ensure     => running,
    enable     => true,
    hasstatus  => true,
    hasrestart => true,
	  require => Package["openssh-server"],
  }
}
