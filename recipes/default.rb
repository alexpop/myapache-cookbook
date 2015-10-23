#
# Cookbook Name:: myapache-cookbook
# Recipe:: default
#
# Copyright 2014, Great Blogs Ltd
#

# Use the `package` resource to install or upgrade Apache. This allows a repo
# strategy to incluence the package versions available per environment and promotion between environments
package 'httpd' do
  action :upgrade
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
  # Stop chef-client and provide a `pry` prompt for troubleshooting
  require 'pry'
  binding.pry
end
