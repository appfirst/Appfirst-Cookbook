apt_repository "appfirst" do
  uri node['appfirst']['apt_repo_url']
  key node['appfirst']['apt_key']
  keyserver node['appfirst']['apt_keyserver']
  distribution node['lsb']['codename']
  components ["main"]
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

# temp, until v85 resolves this
link "/opt/appfirst" do
  to "/opt/AppFirst"
  ignore_failure true
end

package "appfirst" do
  action :install
  options "--force-yes" # keys, pls
end

# workaround, appfirst is removing this from the deb
execute "remove bogus appfirst sources" do
  command 'sed -i -E "s/^(deb|deb-src) http:\/\/frontend.appfirst.com/#\1 http:\/\/frontend.appfirst.com/" /etc/apt/sources.list'
  only_if '/bin/grep -q -E "^(deb|deb-src) http:\/\/frontend.appfirst.com" /etc/apt/sources.list'
end

service "afcollector" do
  supports :restart => true, :start => true
  action [:enable, :start]
end
