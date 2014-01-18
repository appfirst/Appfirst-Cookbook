#
# Cookbook Name:: appfirst
# Recipe:: default
#
# Copyright 2012, Yipit.com
#
# All rights reserved - Do Not Redistribute
#

appfirst_download = "http://#{node['appfirst']['appfirst_frontend_url']}/#{node['appfirst']['appfirst_account_id']}/#{node['appfirst']['package']}"
appfirst_package = "#{node['appfirst']['tmp_file_location']}/#{node['appfirst']['package']}"

node['appfirst']['pre_packages'].each do |pkg|
  package pkg do
    action :install
  end
end

http_request "Check Appfirst Modified Time" do
  message ""
  url appfirst_download
  action :head
  if File.exists?(appfirst_package)
    headers "If-Modified-Since" => File.mtime(appfirst_package).httpdate
  end
  not_if "dpkg -s appfirst" # workaround for images with the package preinstalled
  notifies :create, "remote_file[appfirst]", :immediately
end

remote_file "appfirst" do
  path appfirst_package
  source appfirst_download
  # Don't want our run to fail if the endpoint is having temporary issues.
  ignore_failure true
  action :nothing
  notifies :install, "package[appfirst]", :immediately
end

package "appfirst" do
  source appfirst_package
  provider node['appfirst']['provider']
  action :nothing
  notifies :restart, "service[afcollector]"
end

# temporary, appfirst said to to this symlink
# should be resolved in release v85
link "/opt/appfirst" do
  to "/opt/AppFirst"
  ignore_failure true
end

template "/etc/appfirst.tags" do
  source "appfirst.tags.erb"
  mode 0644
  owner "root"
  group "root"
  variables({
    :tags => node[:appfirst][:tags]
  })
end

service "afcollector" do
  supports :restart => true, :start => true
  action :nothing
end
