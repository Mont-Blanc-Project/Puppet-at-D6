class mali {
	file { '/dev/mali0' :
		owner => 'root',
		group => 'root',
		mode => '666',
	}
	file { '/usr/local/lib/libEGL.so' :
		owner => 'root',
		group => 'root',
		mode => '755',
	}
	file { '/usr/local/lib/libGLESv1_CM.so' :
		owner => 'root',
		group => 'root',
		mode => '755',
	}
	file { '/usr/local/lib/libGLESv2.so' :
		owner => 'root',
		group => 'root',
		mode => '755',
	}
	file { '/usr/local/lib/libmali.so' :
		owner => 'root',
		group => 'root',
		mode => '755',
	}
	file { '/usr/local/lib/libOpenCL.so' :
		owner => 'root',
		group => 'root',
		mode => '755',
	}
}
