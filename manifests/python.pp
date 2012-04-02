class python {
    package { [
            "python-dev",
            "libpq-dev",
            "python-setuptools",
            "libxml2",
            "libxslt1.1",
            "libxml2-dev",
            "libxslt-dev",
        ]:
        ensure => latest,
        before => Package["flask", "psycopg2", "sqlalchemy", "gunicorn", "lxml"],
    }
    file { "/etc/supervisord.conf":
        owner  => root,
        group  => root,
        mode   => 644,
        source => "puppet:////vagrant/manifests/files/supervisord.conf",
        before => Package["supervisor"]
    }
    file { "/etc/init.d/supervisord":
        owner  => root,
        group  => root,
        mode   => 655,
        source => "puppet:////vagrant/manifests/files/supervisord.initd",
        before => Package["supervisor"]
    }
    file { "/var/log/gunicorn":
        ensure => "directory",
        owner  => vagrant,
        group  => vagrant,
        mode   => 655,
        before => Package["gunicorn"]
    }
    exec { "easy_install pip":
        alias => "easyinstallpip",
        path => [
            "/usr/bin",
            "/usr/local/bin",
        ],
        user => root,
        require => Package["python-setuptools"],
    }
    package { [
            "flask",
            "psycopg2",
            "sqlalchemy",
            "gunicorn",
            "fabric",
            "requests",
            "supervisor",
            "coverage",
            "python-memcached",
            "lxml",
        ]:
        ensure => latest,
        provider => "pip",
        require => Exec["easyinstallpip"],
        notify => Service["supervisord"],
    }
    package { [
            "flask-sqlalchemy",
            "flask-wtf",
            "flask-login"
        ]:
        ensure => latest,
        provider => "pip",
        require => Package["flask"]
    }
    service { "supervisord":
        ensure => stopped,
        hasrestart => true,
    }
}