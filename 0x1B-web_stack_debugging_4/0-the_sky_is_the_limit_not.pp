# Increases the ULIMIT for Nginx in the default file
exec { 'fix--for-nginx':
  command => 'sed -i "s/15/4096/" /etc/default/nginx',
  path    => '/bin:/usr/bin:/usr/local/bin',
  notify  => Exec['nginx-restart'],  # Ensures Nginx restarts after the change
}

# Restart Nginx
exec { 'nginx-restart':
  command => 'service nginx restart',  # Correct command to restart Nginx
  path    => '/bin:/usr/sbin:/usr/local/sbin',
  refreshonly => true,  # Ensures this runs only if there's a change in the previous exec
}

