#
## Cookbook Name:: appfirst
## Recipe:: default
##
## Copyright 2012, Yipit.com
##
## All rights reserved - Do Not Redistribute
##


case node['platform_family']
when 'rhel'
  default['appfirst']['provider'] = Chef::Provider::Package::Rpm
  default['appfirst']['package'] = "appfirst-#{node['kernel']['machine']}.rpm"
  default['appfirst']['pre_packages'] = %w(openssl098e compat-openldap perl)
when 'debian'
  default['appfirst']['provider'] = Chef::Provider::Package::Dpkg
  default['appfirst']['package'] = "appfirst-#{node['kernel']['machine']}.deb"
  default['appfirst']['pre_packages'] = %w(libssl0.9.8)
end

# Insert AppFirst account ID here. Required.
default['appfirst']['appfirst_account_id'] = 'xxxx'
# Insert AppFirst frontend URL here. Optional.
default['appfirst']['appfirst_frontend_url'] = 'wwws.appfirst.com'

# Specify local directory where AppFirst collector should be downloaded to.
default['appfirst']['tmp_file_location'] = '/tmp'

# Specify tags to identify collected data in AppFirst
default['appfirst']['tags'] = []

default['appfirst']['apt_repo_url'] = 'http://frontend.appfirst.com/packages/debs'
