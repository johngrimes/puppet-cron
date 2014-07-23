class cron ($run_parts_hour = 20) {
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

  file { '/etc/crontab':
    content => template('cron/crontab.erb')
  }

  monit::conf { 'cron':
    content => template('cron/cron.monit.erb'),
    require => Service['cron']
  }
}
