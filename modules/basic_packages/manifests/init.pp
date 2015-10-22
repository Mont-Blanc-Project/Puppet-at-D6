class basic_packages {
	package { "screen":
		ensure => latest,
	}
	package { "aptitude":
		ensure => latest,
	}
	package { "vim":
		ensure => latest,
	}
	package { "bash-completion":
		ensure => latest,
	}
	package { "command-not-found":
		ensure => latest,
	}
	package { "git":
		ensure => latest,
	}
	package { "htop":
		ensure => latest,
	}
	package { "molly-guard":
		ensure => latest,
	}
	package { "mlocate":
		ensure => latest,
	}
	package { "memtester":
		ensure => latest,
	}
	package { "gdb":
		ensure => latest,
	}
	package { "zsh":
		ensure => latest,
	}
  package { "bc":
    ensure => latest,
  }
  package { "tree":
    ensure => latest,
  }
}
