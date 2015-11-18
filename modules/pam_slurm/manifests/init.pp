class pam_slurm ($clus) {
  file {"/lib/security":
    ensure => directory,
    owner  => 'root',
    group  => 'root',
    mode   => '755',
  }
  file { '/lib/security/pam_slurm.so':
    ensure  => file,
    owner   => 'root',
    group   => 'root',
    mode    => '755',
    source  => "puppet:///modules/pam_slurm/pam_slurm-${clus}.so",
  }
}
