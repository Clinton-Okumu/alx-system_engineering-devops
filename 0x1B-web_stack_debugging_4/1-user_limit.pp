# Increase hard file limit for holberton user
exec { 'increase-hard-file-limit-for-holberton-user':
  command => 'sed -i "/holberton hard nofile/s/[0-9]\+/50000/" /etc/security/limits.conf',
  path    => '/bin:/usr/bin:/usr/local/bin',
  unless  => 'grep -q "holberton hard nofile 50000" /etc/security/limits.conf',
}

# Increase soft file limit for holberton user
exec { 'increase-soft-file-limit-for-holberton-user':
  command => 'sed -i "/holberton soft nofile/s/[0-9]\+/50000/" /etc/security/limits.conf',
  path    => '/bin:/usr/bin:/usr/local/bin',
  unless  => 'grep -q "holberton soft nofile 50000" /etc/security/limits.conf',
}
