#puppet to kill a process

exec { 'killmenow_process':
  command     => '/usr/bin/pkill killmenow',
  path        => ['/bin', '/usr/bin'],
  refreshonly => true,
  onlyif      => '/bin/pgrep killmenow',
  logoutput   => true,
}

