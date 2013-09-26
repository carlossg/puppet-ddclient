puppet-ddclient
=================

Puppet module for DDclient

DDclient is a small but full featured client requiring only Perl and no additional modules. It runs under most UNIX OSes and has been tested under GNU/Linux and FreeBSD. Supported features include: operating as a daemon, manual and automatic updates, static and dynamic updates, optimized updates for multiple addresses, MX, wildcards, abuse avoidance, retrying failed updates, and sending update status to syslog and through e-mail.

# Usage

    class { 'ddclient':
      login    => 'john@doe.com',
      password => 'mypassword',
      host     => 'acme.dnsdynamic.com',
      ssl      => 'yes',
      daemon   => 300,
      server   => 'www.dnsdynamic.org',
      protocol => 'dyndns2',
      use      => 'web, web=myip.dnsdynamic.com',
    }
