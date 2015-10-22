class compilation_tools {
	package { "gcc":
		ensure => latest,
	}
	package { "build-essential":
		ensure => latest,
	}
	package { "gfortran":
		ensure => latest,
	}
	package { "make":
		ensure => latest,
	}
	package { "cmake":
		ensure => latest,
	}
	package { "automake":
		ensure => latest,
	}
	package { "autoconf":
		ensure => latest,
	}
	package { "libtool":
		ensure => latest,
	}
	package { "binutils":
		ensure => latest,
	}
	package { "binutils-dev":
		ensure => latest,
	}
	package { "cmake-curses-gui":
		ensure => latest,
	}
	package { "flex":
		ensure => latest,
	}
	package { "bison":
		ensure => latest,
	}
	package { "gnulib":
		ensure => latest,
	}
}
