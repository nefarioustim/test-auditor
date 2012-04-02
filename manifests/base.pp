import "python.pp"
import "nginx.pp"

stage { "pre": before => Stage["main"] }
stage { "last": require => Stage["main"] }

class devbox {
    exec { "aptitude update --quiet --assume-yes":
        alias => "aptupdate",
        path => "/usr/bin",
        user => "root",
        timeout => 0,
        before => Package["build-essential"]
    }
    user { "vagrant":
        groups => [
            "sudo"
        ]
    }
    group { "puppet":
        ensure => present,
    }
    package { "build-essential":
        ensure => latest,
        before => Package["vim"],
    }
    package { [
            "python-software-properties",
            "vim",
            "aptitude"
        ]:
        ensure => latest,
    }
    package { "memcached":
        ensure => latest
    }
    file { "/home/vagrant/.bashrc":
        owner  => vagrant,
        group  => vagrant,
        mode   => 644,
        source => "puppet:////vagrant/manifests/files/bashrc",
    }
    file { "/home/vagrant/.bash_aliases":
        owner  => vagrant,
        group  => vagrant,
        mode   => 644,
        source => "puppet:////vagrant/manifests/files/bash_aliases",
    }
    file { "/etc/motd":
        owner  => root,
        group  => root,
        mode   => 644,
        source => "puppet:////vagrant/manifests/files/motd",
    }
}

class { "devbox": stage => pre }

include python
include nginx
