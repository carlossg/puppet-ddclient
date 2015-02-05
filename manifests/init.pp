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
  $conf_path = "/etc/ddclient.conf"
  ) {

  package { 'ddclient':
    ensure => present,
  }

  case $operatingsystem {
    'RedHat', 'CentOS':  {
      file { '/etc/sysconfig/ddclient':
        mode    => '0600',
        content => template('ddclient/ddclient-redhat.erb'),
        require => Package['ddclient'],
        notify  => Service['ddclient'],
      }
    }
    'Debian', 'Ubuntu' : {
      file { '/etc/default/ddclient':
        mode    => '0600',
        content => template('ddclient/ddclient-debian.erb'),
        require => Package['ddclient'],
        notify  => Service['ddclient'],
      }
    }
    default: { }
  }

  file { 'ddclient.conf':
    path    => $conf_path,
    mode    => '0600',
    content => template('ddclient/ddclient.conf.erb'),
  } ~>
  service { 'ddclient':
    enable => true,
    ensure => running,
  }

}
