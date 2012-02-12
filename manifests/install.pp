class dotdeb::install {

    file {
        '/etc/apt/sources.list.d':
        ensure  => 'directory',
        owner   => 'root',
        group   => 'root';

        '/etc/apt/sources.list.d/dotdeb.list':
        ensure  => 'present',
        owner   => 'root',
        group   => 'root',
        mode    => '0600',
        content => template('dotdeb/dotdeb.list.erb')
    }

    exec {
        'dotdeb-apt-key':
        path    => '/bin:/usr/bin',
        command => "wget ${dotdeb::key} -O dotdeb.gpg &&
                    cat dotdeb.gpg | apt-key add -",
        unless  => 'apt-key list | grep dotdeb',
        require => File['/etc/apt/sources.list.d/dotdeb.list'],
    }

    exec {
        'update-apt':
        path    => '/bin:/usr/bin',
        command => 'apt-get update',
        unless  => 'ls /usr/bin | grep dotdeb',
        require => Exec['dotdeb-apt-key'],
    }
}