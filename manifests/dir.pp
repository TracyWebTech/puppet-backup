define backup::dir (
  $source = $title,
  $destination,
  $frequency = 'daily',
  $retention = 7,
) {

  file { $destination:
    ensure => directory,
  }

  file { '/usr/local/bin/backup.sh':
    ensure  => present,
    content => template('backup/backup.sh.erb'),
    mode    => '0774',
  }

  case $frequency {
    'hourly':  { $hour = '*' $monthday = '*' $weekday = '*' }
    'daily':   { $hour = '0' $monthday = '*' $weekday = '*' }
    'weekly':  { $hour = '0' $monthday = '*' $weekday = '1' }
    'monthly': { $hour = '0' $monthday = '1' $weekday = '*' }
  }

  cron { "backup ${source}":
    command  => '/usr/local/bin/backup.sh',
    minute   => '0',
    hour     => $hour,
    monthday => $monthday,
    weekday  => $weekday,
  }
}
