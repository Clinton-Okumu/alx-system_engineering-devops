# 0-strace_is_your_friend.pp
# This Puppet manifest fixes the Apache 500 error by ensuring correct permissions and installing missing packages.

exec { 'fix-permissions':
  command => 'chown -R www-data:www-data /var/www/html',
  onlyif  => 'test "$(stat -c %U /var/www/html)" != "www-data"',
}

package { 'php-mysql':
  ensure => installed,
}

service { 'apache2':
  ensure  => running,
  require => Package['php-mysql'],
}
