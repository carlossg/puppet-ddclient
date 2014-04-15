# ddclient dynamic dns
class ddclient(
  $login,
  $password,
  $host,
  $ssl = "yes",
  $daemon = 300,
  $server = "www.dnsdynamic.org",
  $protocol = "dyndns2",
  $use = "web, web=myip.dnsdynamic.com",
  ) {

  package { 'ddclient':
    ensure => present,
  }

  case $operatingsystem {
    'RedHat', 'CentOS':  {
      $config_file = "/etc/ddclient.conf"
      file { '/etc/sysconfig/ddclient':
        mode    => '0600',
        content => template('ddclient/ddclient-redhat.erb'),
        require => Package['ddclient'],
        notify  => Service['ddclient'],
      }
    }
    'Debian', 'Ubuntu' : {
      $config_file="/etc/ddclient.conf"
      file { '/etc/default/ddclient':
        mode    => '0600',
        content => template('ddclient/ddclient-debian.erb'),
        require => Package['ddclient'],
        notify  => Service['ddclient'],
      }
    }
    'FreeBSD': {
      $config_file = "/usr/local/etc/ddclient.conf"
    }
    default: { }
  }

  file { $config_file:
    mode    => '0600',
    content => template('ddclient/ddclient.conf.erb'),
  } ~>
  service { 'ddclient':
    enable => true,
    ensure => running,
  }

}
