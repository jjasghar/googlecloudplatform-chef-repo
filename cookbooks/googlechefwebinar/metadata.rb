name 'googlechefwebinar'
maintainer 'The Authors'
maintainer_email 'you@example.com'
license 'All Rights Reserved'
description 'Installs/Configures googlechefwebinar'
long_description 'Installs/Configures googlechefwebinar'
version '0.1.0'
chef_version '>= 12.1' if respond_to?(:chef_version)


chef_gem 'googleauth'
chef_gem 'google-api-client'

depends 'google-cloud'
