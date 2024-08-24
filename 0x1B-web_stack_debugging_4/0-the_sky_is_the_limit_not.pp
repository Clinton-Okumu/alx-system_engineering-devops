# Increase the ULIMIT for Nginx in the default file
exec { 'fix--for-nginx':
  command => 'sed -i "s/^ULIMIT=.*$/ULIMIT=4096/" /etc/default/nginx',
  path    => ['/bin', '/usr/bin', '/usr/local/bin'],
  unless  => 'grep -q "^ULIMIT=4096$" /etc/default/nginx',
  notify  => Exec['nginx-restart'],  # Ensures Nginx restarts after the change
}

# Restart Nginx to apply the changes
exec { 'nginx-restart':
  command     => 'service nginx restart',
  path        => ['/bin', '/usr/sbin', '/usr/local/sbin'],
  refreshonly => true,  # Ensures this runs only if the previous exec is triggered
}

# Ensure that Nginx init script sources the default file properly
file_line { 'ensure-nginx-sources-default':
  path  => '/etc/init.d/nginx',
  line  => '. /etc/default/nginx',
  match => '^. /etc/default/nginx',
  notify  => Exec['nginx-restart'],  # Restart Nginx if this line is added
  require => Exec['fix--for-nginx'], # Ensure the ulimit fix runs first
}
