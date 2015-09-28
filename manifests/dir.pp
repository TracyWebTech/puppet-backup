define backup::dir (
  $source = $title,
  $destination,
) {

  file { $destination:
    ensure => directory,
  }

  file { '/usr/local/bin/backup.sh':
    ensure => present,
    content => template('backup/backup.sh.erb'),
    mode => '0774',
  }
}

