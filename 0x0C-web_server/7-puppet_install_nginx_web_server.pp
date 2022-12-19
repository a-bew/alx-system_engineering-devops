# Install Nginx package
package { 'nginx':
  ensure => 'installed',
}

# Ensure Nginx service is running and enabled
service { 'nginx':
  ensure => 'running',
  enable => true,
}

# Configure Nginx to listen on port 80
nginx::resource::server { 'default':
  listen => '80',
}

# Set the root directory for the default server
nginx::resource::location { '/':
  server => 'default',
  root => '/var/www/html',
}

# Create a simple HTML page at the root directory
file { '/var/www/html/index.html':
  ensure  => 'file',
  content => 'Hello World!',
}

# Configure a 301 redirect for the /redirect_me path
nginx::resource::location { '/redirect_me':
  server => 'default',
  return => '301 $scheme://$host$request_uri',
}

