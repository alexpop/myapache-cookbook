#
# Cookbook Name:: myapache-cookbook
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute

log "*** Time in epoch is: #{lib_epoch}"

case node['platform_family']
when 'debian'
  package_name = 'apache2'
when 'rhel'
  package_name = 'httpd'
end

package package_name do
  action :install
end

service package_name do
  action [:enable, :start]
end

service 'iptables' do
  action [:disable, :stop]
end
