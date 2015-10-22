class users{
	User {
		managehome => true,
		shell    => '/bin/bash'
	}
	user{"uriviba":
		ensure   => present,
		uid      => 10051,
		password => '$6$6O28M/4c9kjsDIfx$Y.uNuaIW.KiveRefOfEWrEKCfYdaITj6f0yxc3JSDxHOILYIKbVRVS/7pyp6Hb5g4WMKZf9F.hXU0rooV6sGj/'
	}
	user{"druiz":
		ensure   => present,
		uid      => 1004,
		shell    => '/usr/bin/zsh',
		gid		 => 100,
		password => '$6$Ac7AD8WPoSI/ZK$JdOMeEFzTlTQZJwALa/pqqXV0fQ0UUrk9kNi/uKmK5oKfZWuPAaEkb41k1OMhtDFreqy9IFgH7ZGP1mk3R4C5.'
	}
}
