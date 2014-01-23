class cron {
  include monit

  $pid_file = '/var/run/crond.pid'

  package { 'cron':
    ensure => present
  }

  service { 'cron':
    ensure     => running,
    enable     => true,
    hasstatus  => true,
    hasrestart => true,
    require    => Package['cron']
  }

  monit::conf { 'cron':
    content => template('cron/cron.monit.erb'),
    require => Service['cron']
  }
}
