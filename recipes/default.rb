#
# Cookbook Name:: myapache-cookbook
# Recipe:: default
#
# Copyright 2015, Great Blogs Ltd
#

# Use the `package` resource to install or upgrade Apache. This allows a repo
# strategy to incluence the package versions available per environment and promotion between environments
package 'httpd' do
  action :upgrade
end

# Use the template resource to deploy a custom httpd config
template '/etc/httpd/conf/httpd.conf' do
  source 'httpd.conf.erb'
end

# Use the `service` resource
service 'httpd' do
  action [:enable, :start]
end

# Disabling iptables to showcase audit mode
service 'iptables' do
  action [:disable, :stop]
end

if (ENV['PWD'] == '/tmp')
  require 'pry'
  binding.pry
end

log "**********PLATFORM IS: #{node['platform']}"
